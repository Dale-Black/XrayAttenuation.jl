# ============================================================================
# Attenuation Coefficient Functions
# ============================================================================

# Map attenuation types to data column symbols
attenuation_symbol(::PhotoelectricAbsorption) = :photoelectric
attenuation_symbol(::CoherentScattering) = :coherent
attenuation_symbol(::IncoherentScattering) = :incoherent
attenuation_symbol(::PairProductionNuclear) = :pair_nuclear
attenuation_symbol(::PairProductionElectron) = :pair_electron
attenuation_symbol(::TotalWithCoherent) = :total
attenuation_symbol(::TotalWithoutCoherent) = :total_no_coh

# Default attenuation type
const DEFAULT_ATTENUATION = TotalWithCoherent()

# ============================================================================
# Mass Attenuation Coefficient (mu/rho)
# ============================================================================

"""
    mass_attenuation_coeff(element::Element, energy, [attenuation_type])

Calculate mass attenuation coefficient (cm^2/g) for an element at given energy.

# Arguments
- `element`: Element from the Elements collection
- `energy`: Energy with units (e.g., 70keV) or array of energies
- `attenuation_type`: Type of attenuation (default: TotalWithCoherent())

# Returns
- Single energy: Quantity with units cm^2/g
- Multiple energies: AxisArray with units
"""
function mass_attenuation_coeff(element::Element, energy::Unitful.Energy,
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    energy_MeV = val(Unitful.uconvert(MeV, energy))
    sym = attenuation_symbol(attenuation_type)
    result = interpolate_attenuation(element.Z, energy_MeV, sym)
    return result * cm^2/g
end

function mass_attenuation_coeff(element::Element, energies::AbstractVector{<:Unitful.Energy},
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    results = [mass_attenuation_coeff(element, e, attenuation_type) for e in energies]
    return AxisArray(results, Axis{:energy}(energies))
end

function mass_attenuation_coeff(element::Element, energies::StepRange{<:Unitful.Energy},
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    return mass_attenuation_coeff(element, collect(energies), attenuation_type)
end

# ============================================================================
# Compound Attenuation (mixture rule)
# ============================================================================

"""
    parse_formula(formula::String)

Parse a chemical formula into element symbols and counts.
Returns Dict{String, Int} mapping symbols to atom counts.

Examples:
- "H2O" => Dict("H" => 2, "O" => 1)
- "NaCl" => Dict("Na" => 1, "Cl" => 1)
- "CaCO3" => Dict("Ca" => 1, "C" => 1, "O" => 3)
"""
function parse_formula(formula::String)
    result = Dict{String, Int}()
    i = 1
    while i <= length(formula)
        # Match element symbol (uppercase + optional lowercase)
        if isuppercase(formula[i])
            symbol = string(formula[i])
            i += 1
            while i <= length(formula) && islowercase(formula[i])
                symbol *= formula[i]
                i += 1
            end
            # Match optional count
            count_str = ""
            while i <= length(formula) && isdigit(formula[i])
                count_str *= formula[i]
                i += 1
            end
            count = isempty(count_str) ? 1 : parse(Int, count_str)
            result[symbol] = get(result, symbol, 0) + count
        else
            i += 1
        end
    end
    return result
end

"""
    get_element_by_symbol(symbol::String)

Get an Element from the Elements collection by its symbol.
"""
function get_element_by_symbol(symbol::String)
    for elem in Elements
        if elem.symbol == symbol
            return elem
        end
    end
    error("Unknown element symbol: $symbol")
end

# Atomic masses (approximate, in atomic mass units)
const ATOMIC_MASS = Dict{String, Float64}(
    "H" => 1.008, "He" => 4.003, "Li" => 6.941, "Be" => 9.012, "B" => 10.81,
    "C" => 12.01, "N" => 14.01, "O" => 16.00, "F" => 19.00, "Ne" => 20.18,
    "Na" => 22.99, "Mg" => 24.31, "Al" => 26.98, "Si" => 28.09, "P" => 30.97,
    "S" => 32.07, "Cl" => 35.45, "Ar" => 39.95, "K" => 39.10, "Ca" => 40.08,
    "Sc" => 44.96, "Ti" => 47.87, "V" => 50.94, "Cr" => 52.00, "Mn" => 54.94,
    "Fe" => 55.85, "Co" => 58.93, "Ni" => 58.69, "Cu" => 63.55, "Zn" => 65.38,
    "Ga" => 69.72, "Ge" => 72.63, "As" => 74.92, "Se" => 78.96, "Br" => 79.90,
    "Kr" => 83.80, "Rb" => 85.47, "Sr" => 87.62, "Y" => 88.91, "Zr" => 91.22,
    "Nb" => 92.91, "Mo" => 95.96, "Tc" => 98.00, "Ru" => 101.1, "Rh" => 102.9,
    "Pd" => 106.4, "Ag" => 107.9, "Cd" => 112.4, "In" => 114.8, "Sn" => 118.7,
    "Sb" => 121.8, "Te" => 127.6, "I" => 126.9, "Xe" => 131.3, "Cs" => 132.9,
    "Ba" => 137.3, "La" => 138.9, "Ce" => 140.1, "Pr" => 140.9, "Nd" => 144.2,
    "Pm" => 145.0, "Sm" => 150.4, "Eu" => 152.0, "Gd" => 157.3, "Tb" => 158.9,
    "Dy" => 162.5, "Ho" => 164.9, "Er" => 167.3, "Tm" => 168.9, "Yb" => 173.1,
    "Lu" => 175.0, "Hf" => 178.5, "Ta" => 180.9, "W" => 183.8, "Re" => 186.2,
    "Os" => 190.2, "Ir" => 192.2, "Pt" => 195.1, "Au" => 197.0, "Hg" => 200.6,
    "Tl" => 204.4, "Pb" => 207.2, "Bi" => 209.0, "Po" => 209.0, "At" => 210.0,
    "Rn" => 222.0, "Fr" => 223.0, "Ra" => 226.0, "Ac" => 227.0, "Th" => 232.0,
    "Pa" => 231.0, "U" => 238.0
)

"""
    formula_to_mass_fractions(formula::String)

Convert a chemical formula to mass fractions.
Returns Dict{Int, Float64} mapping atomic numbers to mass fractions.
"""
function formula_to_mass_fractions(formula::String)
    parsed = parse_formula(formula)
    total_mass = sum(count * ATOMIC_MASS[sym] for (sym, count) in parsed)

    result = Dict{Int, Float64}()
    for (sym, count) in parsed
        elem = get_element_by_symbol(sym)
        mass_fraction = (count * ATOMIC_MASS[sym]) / total_mass
        result[elem.Z] = get(result, elem.Z, 0.0) + mass_fraction
    end
    return result
end

function mass_attenuation_coeff(compound::Compound, energy::Unitful.Energy,
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    fractions = formula_to_mass_fractions(compound.formula)
    result = 0.0
    for (Z, fraction) in fractions
        elem = get_element_by_Z(Z)
        mu_rho = val(mass_attenuation_coeff(elem, energy, attenuation_type))
        result += fraction * mu_rho
    end
    return result * cm^2/g
end

function mass_attenuation_coeff(compound::Compound, energies::AbstractVector{<:Unitful.Energy},
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    results = [mass_attenuation_coeff(compound, e, attenuation_type) for e in energies]
    return AxisArray(results, Axis{:energy}(energies))
end

"""
    get_element_by_Z(Z::Int)

Get an Element from the Elements collection by atomic number.
"""
function get_element_by_Z(Z::Int)
    for elem in Elements
        if elem.Z == Z
            return elem
        end
    end
    error("Unknown atomic number: $Z")
end

# ============================================================================
# Mixture Attenuation
# ============================================================================

function mass_attenuation_coeff(mixture::Mixture, energy::Unitful.Energy,
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    result = 0.0
    for (formula, mass_fraction) in mixture.components
        compound = Compound(formula)
        mu_rho = val(mass_attenuation_coeff(compound, energy, attenuation_type))
        result += mass_fraction * mu_rho
    end
    return result * cm^2/g
end

function mass_attenuation_coeff(mixture::Mixture, energies::AbstractVector{<:Unitful.Energy},
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    results = [mass_attenuation_coeff(mixture, e, attenuation_type) for e in energies]
    return AxisArray(results, Axis{:energy}(energies))
end

# ============================================================================
# Material Attenuation
# ============================================================================

function mass_attenuation_coeff(material::Material, energy::Unitful.Energy,
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    result = 0.0
    for (Z, fraction) in material.composition
        elem = get_element_by_Z(Z)
        mu_rho = val(mass_attenuation_coeff(elem, energy, attenuation_type))
        result += fraction * mu_rho
    end
    return result * cm^2/g
end

function mass_attenuation_coeff(material::Material, energies::AbstractVector{<:Unitful.Energy},
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    results = [mass_attenuation_coeff(material, e, attenuation_type) for e in energies]
    return AxisArray(results, Axis{:energy}(energies))
end

function mass_attenuation_coeff(material::Material, energies::StepRange{<:Unitful.Energy},
                                 attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    return mass_attenuation_coeff(material, collect(energies), attenuation_type)
end

# ============================================================================
# Linear Attenuation Coefficient (mu)
# ============================================================================

"""
    linear_attenuation_coeff(matter, energy, [attenuation_type])

Calculate linear attenuation coefficient (cm^-1) for matter at given energy.
Linear attenuation = mass attenuation * density.

# Arguments
- `matter`: Element or Material with density
- `energy`: Energy with units (e.g., 70keV) or array of energies
- `attenuation_type`: Type of attenuation (default: TotalWithCoherent())
"""
function linear_attenuation_coeff(element::Element, energy::Unitful.Energy,
                                   attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    mu_rho = mass_attenuation_coeff(element, energy, attenuation_type)
    rho = element.density
    return mu_rho * rho
end

function linear_attenuation_coeff(element::Element, energies::AbstractVector{<:Unitful.Energy},
                                   attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    results = [linear_attenuation_coeff(element, e, attenuation_type) for e in energies]
    return AxisArray(results, Axis{:energy}(energies))
end

function linear_attenuation_coeff(element::Element, energies::StepRange{<:Unitful.Energy},
                                   attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    return linear_attenuation_coeff(element, collect(energies), attenuation_type)
end

function linear_attenuation_coeff(material::Material, energy::Unitful.Energy,
                                   attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    mu_rho = mass_attenuation_coeff(material, energy, attenuation_type)
    rho = material.density
    return mu_rho * rho
end

function linear_attenuation_coeff(material::Material, energies::AbstractVector{<:Unitful.Energy},
                                   attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    results = [linear_attenuation_coeff(material, e, attenuation_type) for e in energies]
    return AxisArray(results, Axis{:energy}(energies))
end

function linear_attenuation_coeff(material::Material, energies::StepRange{<:Unitful.Energy},
                                   attenuation_type::Attenuation=DEFAULT_ATTENUATION)
    return linear_attenuation_coeff(material, collect(energies), attenuation_type)
end
