module XrayAttenuation

using AxisArrays
using Interpolations
using Unitful
using Unitful: g, cm, eV, keV, MeV

# Export types
export Element, Compound, Mixture, Material
export Elements, Materials

# Export attenuation types
export PhotoelectricAbsorption, CoherentScattering, IncoherentScattering
export PairProductionNuclear, PairProductionElectron
export TotalWithCoherent, TotalWithoutCoherent

# Export functions
export mass_attenuation_coeff, linear_attenuation_coeff, val, unit

# Export fluorescence data
export K_SHELL_BINDING_ENERGIES_KEV, K_FLUORESCENCE_YIELDS, K_ALPHA1_ENERGIES_KEV
export k_binding_energy, k_fluorescence_yield, k_alpha_energy

# Include source files
include("types.jl")
include("xcom_data.jl")
include("interpolation.jl")
include("attenuation.jl")
include("elements.jl")
include("materials.jl")
include("fluorescence_data.jl")

end # module
