# ============================================================================
# Attenuation Type Hierarchy
# ============================================================================

"""
Abstract base type for all attenuation mechanisms.
"""
abstract type Attenuation end

"""
Photoelectric absorption - photon absorbed by atom, electron ejected.
Dominant at low energies.
"""
struct PhotoelectricAbsorption <: Attenuation end

"""
Abstract type for scattering mechanisms.
"""
abstract type Scattering <: Attenuation end

"""
Coherent (Rayleigh) scattering - elastic scattering, no energy loss.
"""
struct CoherentScattering <: Scattering end

"""
Incoherent (Compton) scattering - inelastic scattering with energy loss.
"""
struct IncoherentScattering <: Scattering end

"""
Abstract type for pair production mechanisms.
"""
abstract type PairProduction <: Attenuation end

"""
Pair production in nuclear field - electron-positron pair created near nucleus.
Threshold: 1.022 MeV
"""
struct PairProductionNuclear <: PairProduction end

"""
Pair production in electron field (triplet production).
Threshold: 2.044 MeV
"""
struct PairProductionElectron <: PairProduction end

"""
Abstract type for total attenuation.
"""
abstract type Total <: Attenuation end

"""
Total attenuation including coherent scattering.
"""
struct TotalWithCoherent <: Total end

"""
Total attenuation excluding coherent scattering.
"""
struct TotalWithoutCoherent <: Total end

# ============================================================================
# Matter Type Hierarchy
# ============================================================================

"""
Abstract base type for all matter types.
"""
abstract type Matter end

"""
    Element{T,E,D}

Represents a chemical element with physical properties.

# Fields
- `Z::Int`: Atomic number
- `symbol::String`: Chemical symbol (e.g., "H", "Au")
- `name::String`: Full element name
- `ZA_ratio::T`: Z/A ratio (atomic number / atomic mass)
- `I::E`: Mean excitation energy (with units)
- `density::D`: Standard density (with units)
"""
struct Element{T<:Real, E, D} <: Matter
    Z::Int
    symbol::String
    name::String
    ZA_ratio::T
    I::E
    density::D
end

"""
    Compound

Represents a chemical compound defined by its formula string.

# Fields
- `formula::String`: Chemical formula (e.g., "H2O", "NaCl", "CaCO3")
"""
struct Compound <: Matter
    formula::String
end

"""
    Mixture{T}

Represents a mixture of compounds with specified mass fractions.

# Fields
- `components::Dict{String, T}`: Dictionary mapping formula strings to mass fractions
"""
struct Mixture{T<:Real} <: Matter
    components::Dict{String, T}
end

"""
    Material{T,E,D}

Represents a predefined material with known composition and properties.

# Fields
- `name::String`: Descriptive material name
- `ZA_ratio::T`: Average Z/A ratio
- `I::E`: Mean excitation energy (with units)
- `density::D`: Material density (with units)
- `composition::Dict{Int, T}`: Dictionary mapping atomic numbers to mass fractions
"""
struct Material{T<:Real, E, D} <: Matter
    name::String
    ZA_ratio::T
    I::E
    density::D
    composition::Dict{Int, T}
end

# Convenience constructor for Material
function Material(name::String, ZA_ratio::Real, I, density, composition::Dict{Int, <:Real})
    T = promote_type(typeof(ZA_ratio), valtype(composition))
    Material{T, typeof(I), typeof(density)}(name, T(ZA_ratio), I, density, Dict{Int,T}(composition))
end

# ============================================================================
# Helper Functions
# ============================================================================

"""
    val(x)

Extract the numeric value from a Unitful quantity.

# Arguments
- `x`: A Unitful quantity or numeric value

# Returns
- `Float64`: The numeric value without units
"""
val(x::Unitful.Quantity) = Float64(Unitful.ustrip(x))
val(x::Real) = Float64(x)
val(x::AbstractArray) = val.(x)

"""
    unit(x)

Get the units of a Unitful quantity. Re-exported from Unitful.
"""
unit(x) = Unitful.unit(x)
