# XrayAttenuation.jl

[![Build Status](https://github.com/Dale-Black/XrayAttenuation.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/Dale-Black/XrayAttenuation.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/Dale-Black/XrayAttenuation.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/Dale-Black/XrayAttenuation.jl)
[![pkgeval](https://juliahub.com/docs/General/XrayAttenuation/stable/pkgeval.svg)](https://juliaci.github.io/NasalDaemon/pkgeval_badges/X/XrayAttenuation.html)
[![version](https://juliahub.com/docs/General/XrayAttenuation/stable/version.svg)](https://juliahub.com/ui/Packages/General/XrayAttenuation)

X-ray photon attenuation coefficients from the NIST XCOM database with K-edge aware interpolation.

## Features

- Local embedded XCOM database (no HTTP requests at runtime)
- All 92 elements (Hydrogen through Uranium)
- Predefined materials (water, tissues, bones, polymers, contrast agents)
- K-edge discontinuity handling for accurate interpolation near absorption edges
- Full Unitful.jl integration for physical units
- Compound support via chemical formulas (e.g., "H2O", "CaCO3")

## Installation

```julia
using Pkg
Pkg.add("XrayAttenuation")
```

## Usage

### Elements

```julia
using XrayAttenuation
using Unitful: keV, cm, g

# Mass attenuation coefficient (cm²/g)
mu_rho = mass_attenuation_coeff(Elements.Iron, 70keV)

# Linear attenuation coefficient (cm⁻¹)
mu = linear_attenuation_coeff(Elements.Iron, 70keV)

# Multiple energies
energies = [30, 50, 70, 100, 150]keV
mu_rho_array = mass_attenuation_coeff(Elements.Gold, energies)

# Specific attenuation types
mu_photo = mass_attenuation_coeff(Elements.Lead, 100keV, PhotoelectricAbsorption())
mu_compton = mass_attenuation_coeff(Elements.Carbon, 500keV, IncoherentScattering())
```

### Materials

```julia
# Predefined materials
mu_water = mass_attenuation_coeff(Materials.water, 70keV)
mu_bone = linear_attenuation_coeff(Materials.corticalbone, 70keV)

# Available materials include:
# - Basic: water, air
# - Tissues: adipose, muscle, lung, blood, brain, breast, skin
# - Bones: corticalbone,ite_ite
# - Contrast: iodine_blood, calcium_ite
# - Polymers: pmma, polyethylene, polystyrene
```

### Compounds

```julia
# Chemical formulas
water = Compound("H2O")
calcium_carbonate = Compound("CaCO3")

mu_caco3 = mass_attenuation_coeff(calcium_carbonate, 70keV)
```

### Mixtures

```julia
# Custom mixtures by mass fraction
soft_tissue = Mixture(Dict(
    "H2O" => 0.70,
    "C" => 0.20,
    "N" => 0.05,
    "Ca" => 0.05
))
mu_tissue = mass_attenuation_coeff(soft_tissue, 70keV)
```

## Attenuation Types

| Type | Description |
|------|-------------|
| `TotalWithCoherent()` | Total attenuation (default) |
| `TotalWithoutCoherent()` | Total excluding coherent scattering |
| `PhotoelectricAbsorption()` | Photoelectric effect |
| `CoherentScattering()` | Rayleigh scattering |
| `IncoherentScattering()` | Compton scattering |
| `PairProductionNuclear()` | Nuclear pair production (>1.022 MeV) |
| `PairProductionElectron()` | Triplet production (>2.044 MeV) |

## Data Source

Attenuation coefficients from NIST XCOM Photon Cross Sections Database:
https://www.nist.gov/pml/xcom-photon-cross-sections-database

Energy range: 1 keV to 100 GeV with 525 energy points including all K-edges.

## Related Packages

- [Attenuations.jl](https://github.com/Dale-Black/Attenuations.jl): HTTP-based XCOM queries (this package provides equivalent functionality with local data)

## License

MIT License
