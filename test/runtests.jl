using Test
using Unitful: g, cm, eV, keV, MeV
import Unitful

# Import packages with aliases to avoid conflicts
import XrayAttenuation as XA
import Attenuations as ATT

@testset "XrayAttenuation.jl" begin

    @testset "Attenuation Types" begin
        @test XA.PhotoelectricAbsorption isa Type
        @test XA.CoherentScattering isa Type
        @test XA.IncoherentScattering isa Type
        @test XA.PairProductionNuclear isa Type
        @test XA.PairProductionElectron isa Type
        @test XA.TotalWithCoherent isa Type
        @test XA.TotalWithoutCoherent isa Type
    end

    @testset "Elements - Basic Properties" begin
        @test XA.Elements.Hydrogen.Z == 1
        @test XA.Elements.Hydrogen.symbol == "H"
        @test XA.Elements.Hydrogen.name == "Hydrogen"
        @test XA.Elements.Aluminum.Z == 13
        @test XA.Elements.Aluminum.symbol == "Al"
        @test XA.Elements.Gold.Z == 79
        @test XA.Elements.Gold.symbol == "Au"
        @test XA.Elements.Uranium.Z == 92
        @test XA.Elements.Uranium.symbol == "U"
        @test length(XA.Elements) == 92
    end

    @testset "Comparison with Attenuations.jl - Elements" begin
        # Compare XrayAttenuation (local database) with Attenuations.jl (HTTP XCOM)
        # This ensures our local database matches the authoritative NIST XCOM source

        element_names = [
            :Hydrogen, :Helium, :Carbon, :Nitrogen, :Oxygen,
            :Aluminum, :Silicon, :Calcium, :Iron, :Copper,
            :Silver, :Iodine, :Barium, :Gadolinium, :Gold,
            :Lead, :Uranium
        ]

        test_energies = [20.0, 30.0, 50.0, 70.0, 100.0, 150.0]

        for name in element_names
            xa_elem = getfield(XA.Elements, name)
            att_elem = getfield(ATT.Elements, name)

            for energy_keV in test_energies
                energy = energy_keV * keV

                # XrayAttenuation (local database)
                xa_result = XA.mass_attenuation_coeff(xa_elem, energy)
                xa_val = XA.val(xa_result)

                # Attenuations.jl (HTTP to NIST XCOM)
                att_result = ATT.μᵨ(att_elem, energy)
                att_val = Float64(Unitful.ustrip(att_result))

                # Should match within 1% (accounting for interpolation differences)
                @test isapprox(xa_val, att_val, rtol=0.01) ||
                    @warn "Mismatch: $name at $energy_keV keV: XA=$xa_val vs ATT=$att_val"
            end
        end
    end

    @testset "Comparison with Attenuations.jl - K-Edge Critical Tests" begin
        # K-edges are critical discontinuities that must match precisely
        # These are the most important tests for medical imaging applications

        kedge_tests = [
            # (element_name, below_keV, above_keV, description)
            (:Iodine, 33.0, 33.5, "Iodine K-edge (contrast imaging)"),
            (:Barium, 37.3, 37.6, "Barium K-edge (GI contrast)"),
            (:Gadolinium, 50.0, 50.5, "Gadolinium K-edge (MRI/CT contrast)"),
            (:Gold, 80.5, 81.0, "Gold K-edge (nanoparticle imaging)"),
        ]

        for (name, below_keV, above_keV, desc) in kedge_tests
            xa_elem = getfield(XA.Elements, name)
            att_elem = getfield(ATT.Elements, name)

            # Test below K-edge
            energy_below = below_keV * keV
            xa_below = XA.val(XA.mass_attenuation_coeff(xa_elem, energy_below))
            att_below = Float64(Unitful.ustrip(ATT.μᵨ(att_elem, energy_below)))
            @test isapprox(xa_below, att_below, rtol=0.02)

            # Test above K-edge
            energy_above = above_keV * keV
            xa_above = XA.val(XA.mass_attenuation_coeff(xa_elem, energy_above))
            att_above = Float64(Unitful.ustrip(ATT.μᵨ(att_elem, energy_above)))
            @test isapprox(xa_above, att_above, rtol=0.02)

            # Verify jump ratio matches between packages
            xa_ratio = xa_above / xa_below
            att_ratio = att_above / att_below
            @test isapprox(xa_ratio, att_ratio, rtol=0.05)

            # K-edge jump should be significant (>3x)
            @test xa_ratio > 3.0
        end
    end

    @testset "K-Edge Discontinuities - Physics Validation" begin
        # Verify K-edges show proper discontinuity behavior

        # Iodine K-edge at 33.169 keV
        below = XA.mass_attenuation_coeff(XA.Elements.Iodine, 33.0keV)
        above = XA.mass_attenuation_coeff(XA.Elements.Iodine, 33.5keV)
        ratio = XA.val(above) / XA.val(below)
        @test ratio > 4.0 && ratio < 7.0

        # Barium K-edge at 37.441 keV
        below = XA.mass_attenuation_coeff(XA.Elements.Barium, 37.3keV)
        above = XA.mass_attenuation_coeff(XA.Elements.Barium, 37.6keV)
        ratio = XA.val(above) / XA.val(below)
        @test ratio > 4.0 && ratio < 7.0

        # Gadolinium K-edge at 50.239 keV
        below = XA.mass_attenuation_coeff(XA.Elements.Gadolinium, 50.0keV)
        above = XA.mass_attenuation_coeff(XA.Elements.Gadolinium, 50.5keV)
        ratio = XA.val(above) / XA.val(below)
        @test ratio > 3.5 && ratio < 6.0

        # Gold K-edge at 80.725 keV
        below = XA.mass_attenuation_coeff(XA.Elements.Gold, 80.5keV)
        above = XA.mass_attenuation_coeff(XA.Elements.Gold, 81.0keV)
        ratio = XA.val(above) / XA.val(below)
        @test ratio > 3.0 && ratio < 6.0
    end

    @testset "Linear Attenuation Coefficients" begin
        # Linear attenuation = mass attenuation * density
        result = XA.linear_attenuation_coeff(XA.Elements.Aluminum, 70keV)
        mu_rho = XA.val(XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV))
        expected = mu_rho * 2.699  # Al density
        @test isapprox(XA.val(result), expected, rtol=0.01)

        result = XA.linear_attenuation_coeff(XA.Elements.Iron, 100keV)
        mu_rho = XA.val(XA.mass_attenuation_coeff(XA.Elements.Iron, 100keV))
        expected = mu_rho * 7.874  # Fe density
        @test isapprox(XA.val(result), expected, rtol=0.01)
    end

    @testset "Compounds" begin
        # Water (H2O)
        water = XA.Compound("H2O")
        result = XA.mass_attenuation_coeff(water, 70keV)
        @test isapprox(XA.val(result), 0.1929, rtol=0.02)

        # Sodium Chloride (NaCl)
        nacl = XA.Compound("NaCl")
        result = XA.mass_attenuation_coeff(nacl, 70keV)
        @test XA.val(result) > 0.2

        # Calcium Carbonate (CaCO3) - bone mineral
        calcite = XA.Compound("CaCO3")
        result = XA.mass_attenuation_coeff(calcite, 70keV)
        @test XA.val(result) > XA.val(XA.mass_attenuation_coeff(water, 70keV))
    end

    @testset "Mixtures" begin
        # 90% water, 10% NaCl mixture
        mix = XA.Mixture(Dict("H2O" => 0.9, "NaCl" => 0.1))
        result = XA.mass_attenuation_coeff(mix, 70keV)

        # Verify mixture rule
        water = XA.Compound("H2O")
        nacl = XA.Compound("NaCl")
        mu_water = XA.val(XA.mass_attenuation_coeff(water, 70keV))
        mu_nacl = XA.val(XA.mass_attenuation_coeff(nacl, 70keV))
        expected = 0.9 * mu_water + 0.1 * mu_nacl
        @test isapprox(XA.val(result), expected, rtol=0.001)
    end

    @testset "Materials - Predefined" begin
        # Water material
        result = XA.mass_attenuation_coeff(XA.Materials.water, 70keV)
        @test isapprox(XA.val(result), 0.1929, rtol=0.02)

        # Linear attenuation for water (density = 1 g/cm^3)
        result = XA.linear_attenuation_coeff(XA.Materials.water, 70keV)
        @test isapprox(XA.val(result), 0.1929, rtol=0.02)

        # Air material
        result = XA.mass_attenuation_coeff(XA.Materials.air, 70keV)
        @test XA.val(result) > 0
        @test XA.val(result) < XA.val(XA.mass_attenuation_coeff(XA.Materials.water, 70keV))

        # Bone material should have higher attenuation than soft tissue
        bone_result = XA.mass_attenuation_coeff(XA.Materials.corticalbone, 70keV)
        water_result = XA.mass_attenuation_coeff(XA.Materials.water, 70keV)
        @test XA.val(bone_result) > XA.val(water_result)
    end

    @testset "Materials - Composition Validation" begin
        for m in XA.Materials
            total = sum(values(m.composition))
            @test isapprox(total, 1.0, atol=1e-3)
        end
    end

    @testset "Energy Range Coverage" begin
        # Diagnostic X-ray range (20-150 keV)
        energies = [20, 30, 40, 50, 60, 70, 80, 90, 100, 120, 150] .* keV

        for elem in [XA.Elements.Carbon, XA.Elements.Aluminum, XA.Elements.Calcium,
                     XA.Elements.Iron, XA.Elements.Copper, XA.Elements.Iodine]
            for energy in energies
                result = XA.mass_attenuation_coeff(elem, energy)
                @test XA.val(result) > 0
                @test isfinite(XA.val(result))
            end
        end

        # High energy range (0.5-10 MeV)
        high_energies = [0.5, 1.0, 2.0, 5.0, 10.0] .* MeV
        for energy in high_energies
            result = XA.mass_attenuation_coeff(XA.Elements.Carbon, energy)
            @test XA.val(result) > 0
            @test isfinite(XA.val(result))
        end
    end

    @testset "Energy Arrays" begin
        energies = 20keV:10keV:120keV
        result = XA.mass_attenuation_coeff(XA.Elements.Gold, energies)
        @test length(result) == length(energies)
        @test all(XA.val.(result) .> 0)

        energy_vec = [50keV, 70keV, 100keV]
        result = XA.mass_attenuation_coeff(XA.Elements.Aluminum, energy_vec)
        @test length(result) == 3
    end

    @testset "Attenuation Types Selection" begin
        result_total = XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV, XA.TotalWithCoherent())
        result_photo = XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV, XA.PhotoelectricAbsorption())
        result_coh = XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV, XA.CoherentScattering())
        result_incoh = XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV, XA.IncoherentScattering())

        @test XA.val(result_total) > 0
        @test XA.val(result_photo) >= 0
        @test XA.val(result_coh) >= 0
        @test XA.val(result_incoh) >= 0

        result_no_coh = XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV, XA.TotalWithoutCoherent())
        @test XA.val(result_total) >= XA.val(result_no_coh)

        # High energy pair production
        result_pair = XA.mass_attenuation_coeff(XA.Elements.Lead, 5MeV, XA.PairProductionNuclear())
        @test XA.val(result_pair) > 0
    end

    @testset "Value Extraction" begin
        result = XA.mass_attenuation_coeff(XA.Elements.Gold, 70keV)
        @test typeof(XA.val(result)) <: AbstractFloat

        results = XA.mass_attenuation_coeff(XA.Elements.Gold, [50keV, 70keV, 100keV])
        @test all(typeof.(XA.val.(results)) .<: AbstractFloat)

        @test XA.val(1.5) == 1.5
        @test XA.val(2) == 2.0
    end

    @testset "Unit Handling" begin
        result = XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV)
        @test XA.unit(result) == cm^2/g

        result = XA.linear_attenuation_coeff(XA.Elements.Aluminum, 70keV)
        @test XA.unit(result) == cm^-1

        # Energy unit conversion
        result_keV = XA.mass_attenuation_coeff(XA.Elements.Iron, 100keV)
        result_MeV = XA.mass_attenuation_coeff(XA.Elements.Iron, 0.1MeV)
        @test isapprox(XA.val(result_keV), XA.val(result_MeV), rtol=0.001)
    end

    @testset "Database Integrity" begin
        for Z in 1:92
            elem = nothing
            for e in XA.Elements
                if e.Z == Z
                    elem = e
                    break
                end
            end
            @test elem !== nothing

            result = XA.mass_attenuation_coeff(elem, 70keV)
            @test XA.val(result) > 0
            @test isfinite(XA.val(result))
        end
    end

    @testset "Physical Consistency" begin
        # Attenuation decreases with energy (below absorption edges)
        energies = [30, 50, 70, 100, 150] .* keV
        results_C = [XA.val(XA.mass_attenuation_coeff(XA.Elements.Carbon, e)) for e in energies]

        for i in 1:length(results_C)-1
            @test results_C[i] >= results_C[i+1]
        end

        # Higher Z → higher attenuation
        mu_C = XA.val(XA.mass_attenuation_coeff(XA.Elements.Carbon, 70keV))
        mu_Al = XA.val(XA.mass_attenuation_coeff(XA.Elements.Aluminum, 70keV))
        mu_Fe = XA.val(XA.mass_attenuation_coeff(XA.Elements.Iron, 70keV))
        mu_Pb = XA.val(XA.mass_attenuation_coeff(XA.Elements.Lead, 70keV))

        @test mu_C < mu_Al < mu_Fe < mu_Pb
    end

    @testset "Fluorescence Data — K-Shell" begin
        # Data arrays should have 92 entries
        @test length(XA.K_SHELL_BINDING_ENERGIES_KEV) == 92
        @test length(XA.K_FLUORESCENCE_YIELDS) == 92
        @test length(XA.K_ALPHA1_ENERGIES_KEV) == 92

        # Binding energies should increase monotonically with Z
        for Z in 2:92
            @test XA.K_SHELL_BINDING_ENERGIES_KEV[Z] > XA.K_SHELL_BINDING_ENERGIES_KEV[Z-1]
        end

        # Fluorescence yields should increase monotonically with Z (for Z >= 6)
        for Z in 7:92
            @test XA.K_FLUORESCENCE_YIELDS[Z] >= XA.K_FLUORESCENCE_YIELDS[Z-1]
        end

        # Fluorescence yields should be in [0, 1]
        @test all(0.0 .<= XA.K_FLUORESCENCE_YIELDS .<= 1.0)

        # K-alpha energies should increase with Z (for Z >= 4)
        for Z in 5:92
            @test XA.K_ALPHA1_ENERGIES_KEV[Z] > XA.K_ALPHA1_ENERGIES_KEV[Z-1]
        end

        # K-alpha energy should be less than K-binding energy
        for Z in 11:92
            @test XA.K_ALPHA1_ENERGIES_KEV[Z] < XA.K_SHELL_BINDING_ENERGIES_KEV[Z]
        end

        # Spot checks — Cu (Z=29)
        @test isapprox(XA.k_binding_energy(29), 8.979, atol=0.01)
        @test isapprox(XA.k_alpha_energy(29), 8.048, atol=0.01)
        @test isapprox(XA.k_fluorescence_yield(29), 0.441, atol=0.01)

        # I (Z=53)
        @test isapprox(XA.k_binding_energy(53), 33.17, atol=0.01)
        @test isapprox(XA.k_alpha_energy(53), 28.61, atol=0.01)
        @test isapprox(XA.k_fluorescence_yield(53), 0.882, atol=0.005)

        # Pb (Z=82)
        @test isapprox(XA.k_binding_energy(82), 88.00, atol=0.01)
        @test isapprox(XA.k_alpha_energy(82), 74.97, atol=0.01)
        @test isapprox(XA.k_fluorescence_yield(82), 0.957, atol=0.005)

        # Cd (Z=48) and Te (Z=52) — CdTe detector
        @test isapprox(XA.k_binding_energy(48), 26.71, atol=0.01)
        @test isapprox(XA.k_alpha_energy(48), 23.17, atol=0.01)
        @test isapprox(XA.k_binding_energy(52), 31.81, atol=0.01)
        @test isapprox(XA.k_alpha_energy(52), 27.47, atol=0.01)

        # K-edge should match XrayAttenuation.jl's K_EDGES_MEV dict
        # Use 3% tolerance — light elements have small differences between
        # NIST binding energies and XCOM absorption edge tabulation
        for Z in keys(XA.K_EDGES_MEV)
            k_edge_keV = XA.K_EDGES_MEV[Z] * 1000.0
            @test isapprox(XA.K_SHELL_BINDING_ENERGIES_KEV[Z], k_edge_keV, rtol=0.03)
        end

        # Function API
        @test XA.k_binding_energy(26) == XA.K_SHELL_BINDING_ENERGIES_KEV[26]
        @test XA.k_fluorescence_yield(26) == XA.K_FLUORESCENCE_YIELDS[26]
        @test XA.k_alpha_energy(26) == XA.K_ALPHA1_ENERGIES_KEV[26]
    end

    @testset "Comprehensive Attenuations.jl Comparison - All 92 Elements" begin
        # Test all 92 elements against Attenuations.jl at 70 keV
        # This is the gold standard comparison

        all_elements = [
            :Hydrogen, :Helium, :Lithium, :Beryllium, :Boron,
            :Carbon, :Nitrogen, :Oxygen, :Fluorine, :Neon,
            :Sodium, :Magnesium, :Aluminum, :Silicon, :Phosphorus,
            :Sulfur, :Chlorine, :Argon, :Potassium, :Calcium,
            :Scandium, :Titanium, :Vanadium, :Chromium, :Manganese,
            :Iron, :Cobalt, :Nickel, :Copper, :Zinc,
            :Gallium, :Germanium, :Arsenic, :Selenium, :Bromine,
            :Krypton, :Rubidium, :Strontium, :Yttrium, :Zirconium,
            :Niobium, :Molybdenum, :Technetium, :Ruthenium, :Rhodium,
            :Palladium, :Silver, :Cadmium, :Indium, :Tin,
            :Antimony, :Tellurium, :Iodine, :Xenon, :Cesium,
            :Barium, :Lanthanum, :Cerium, :Praseodymium, :Neodymium,
            :Promethium, :Samarium, :Europium, :Gadolinium, :Terbium,
            :Dysprosium, :Holmium, :Erbium, :Thulium, :Ytterbium,
            :Lutetium, :Hafnium, :Tantalum, :Tungsten, :Rhenium,
            :Osmium, :Iridium, :Platinum, :Gold, :Mercury,
            :Thallium, :Lead, :Bismuth, :Polonium, :Astatine,
            :Radon, :Francium, :Radium, :Actinium, :Thorium,
            :Protactinium, :Uranium
        ]

        max_diff = 0.0
        failed_elements = String[]

        for name in all_elements
            xa_elem = getfield(XA.Elements, name)
            att_elem = getfield(ATT.Elements, name)

            energy = 70keV
            xa_val = XA.val(XA.mass_attenuation_coeff(xa_elem, energy))
            att_val = Float64(Unitful.ustrip(ATT.μᵨ(att_elem, energy)))

            diff = abs(xa_val - att_val) / att_val
            max_diff = max(max_diff, diff)

            if diff > 0.02  # 2% tolerance
                push!(failed_elements, "$name: XA=$xa_val, ATT=$att_val, diff=$(round(diff*100, digits=2))%")
            end

            @test diff < 0.02
        end

        if !isempty(failed_elements)
            @warn "Elements exceeding 2% difference:\n" * join(failed_elements, "\n")
        end
    end

end
