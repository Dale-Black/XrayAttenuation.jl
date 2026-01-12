# Changelog

All notable changes to XrayAttenuation.jl will be documented in this file.

## [0.2.0] - 2025-01-12

### Added
- 14 Gammex 472 CT phantom materials:
  - 7 iodine insert materials: `gammex_472_i2_0`, `gammex_472_i2_5`, `gammex_472_i5_0`, `gammex_472_i7_5`, `gammex_472_i10_0`, `gammex_472_i15_0`, `gammex_472_i20_0`
  - 7 calcium insert materials: `gammex_472_ca50_0`, `gammex_472_ca100_0`, `gammex_472_ca200_0`, `gammex_472_ca300_0`, `gammex_472_ca400_0`, `gammex_472_ca500_0`, `gammex_472_ca600_0`
- GitHub Actions CI workflow (Julia 1.10-1.12 on Ubuntu/macOS/Windows)
- TagBot for automatic GitHub releases
- Dependabot for dependency updates
- README badges for build status, coverage, pkgeval, and version

### Non-breaking
This release is purely additive with no API changes or removals.

## [0.1.0] - 2025-01-08

### Added
- Initial release
- NIST XCOM database with K-edge aware interpolation
- All 92 elements (Hydrogen through Uranium)
- 100+ predefined materials (tissues, bones, polymers, detectors, contrast agents)
- Full Unitful.jl integration
- Compound support via chemical formulas
