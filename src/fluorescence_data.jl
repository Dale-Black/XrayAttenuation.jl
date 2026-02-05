# ============================================================================
# Fluorescence Data — Shell Binding Energies, Yields, and Transition Energies
# ============================================================================
# Sources:
#   - K-shell binding energies: NIST X-Ray Transition Energies Database
#     (https://physics.nist.gov/PhysRefData/XrayTrans/Html/search.html)
#     Also matches Geant4 G4AtomicShells data
#   - K-shell fluorescence yields (ωK): M.O. Krause, "Atomic radiative and
#     radiationless yields for K and L shells", J. Phys. Chem. Ref. Data,
#     8 (1979) 307-327. Also matches Geant4 G4FluoData values.
#   - K-alpha1 transition energies: NIST X-Ray Transition Energies (2003)
#     Deslattes, Kessler et al., Rev. Mod. Phys. 75, 35-99 (2003)
#
# Used by Monteray.jl for Monte Carlo photon transport fluorescence modeling.
# ============================================================================

export K_SHELL_BINDING_ENERGIES_KEV, K_FLUORESCENCE_YIELDS, K_ALPHA1_ENERGIES_KEV

"""
K-shell binding energies in keV, indexed by atomic number Z (1-92).
Values from NIST X-Ray Transition Energies Database.
Zero for Z < 3 (no K-edge in diagnostic range).
"""
const K_SHELL_BINDING_ENERGIES_KEV = Float64[
    # Z=1 (H) through Z=10 (Ne)
    0.0136,    # Z=1  H
    0.0246,    # Z=2  He
    0.0547,    # Z=3  Li
    0.1115,    # Z=4  Be
    0.1880,    # Z=5  B
    0.2838,    # Z=6  C
    0.4016,    # Z=7  N
    0.5320,    # Z=8  O
    0.6854,    # Z=9  F
    0.8701,    # Z=10 Ne
    # Z=11 (Na) through Z=20 (Ca)
    1.0721,    # Z=11 Na
    1.3050,    # Z=12 Mg
    1.5596,    # Z=13 Al
    1.8389,    # Z=14 Si
    2.1455,    # Z=15 P
    2.4720,    # Z=16 S
    2.8224,    # Z=17 Cl
    3.2060,    # Z=18 Ar
    3.6074,    # Z=19 K
    4.0381,    # Z=20 Ca
    # Z=21 (Sc) through Z=30 (Zn)
    4.4928,    # Z=21 Sc
    4.9664,    # Z=22 Ti
    5.4651,    # Z=23 V
    5.9892,    # Z=24 Cr
    6.5390,    # Z=25 Mn
    7.1120,    # Z=26 Fe
    7.7089,    # Z=27 Co
    8.3328,    # Z=28 Ni
    8.9789,    # Z=29 Cu
    9.6586,    # Z=30 Zn
    # Z=31 (Ga) through Z=40 (Zr)
    10.3671,   # Z=31 Ga
    11.1031,   # Z=32 Ge
    11.8667,   # Z=33 As
    12.6578,   # Z=34 Se
    13.4737,   # Z=35 Br
    14.3256,   # Z=36 Kr
    15.2000,   # Z=37 Rb
    16.1046,   # Z=38 Sr
    17.0384,   # Z=39 Y
    17.9976,   # Z=40 Zr
    # Z=41 (Nb) through Z=50 (Sn)
    18.9856,   # Z=41 Nb
    19.9995,   # Z=42 Mo
    21.0440,   # Z=43 Tc
    22.1172,   # Z=44 Ru
    23.2199,   # Z=45 Rh
    24.3503,   # Z=46 Pd
    25.5140,   # Z=47 Ag
    26.7112,   # Z=48 Cd
    27.9399,   # Z=49 In
    29.2001,   # Z=50 Sn
    # Z=51 (Sb) through Z=60 (Nd)
    30.4912,   # Z=51 Sb
    31.8138,   # Z=52 Te
    33.1694,   # Z=53 I
    34.5614,   # Z=54 Xe
    35.9846,   # Z=55 Cs
    37.4406,   # Z=56 Ba
    38.9246,   # Z=57 La
    40.4430,   # Z=58 Ce
    41.9906,   # Z=59 Pr
    43.5689,   # Z=60 Nd
    # Z=61 (Pm) through Z=70 (Yb)
    45.1840,   # Z=61 Pm
    46.8342,   # Z=62 Sm
    48.5190,   # Z=63 Eu
    50.2391,   # Z=64 Gd
    51.9957,   # Z=65 Tb
    53.7885,   # Z=66 Dy
    55.6177,   # Z=67 Ho
    57.4855,   # Z=68 Er
    59.3896,   # Z=69 Tm
    61.3323,   # Z=70 Yb
    # Z=71 (Lu) through Z=80 (Hg)
    63.3138,   # Z=71 Lu
    65.3508,   # Z=72 Hf
    67.4164,   # Z=73 Ta
    69.5250,   # Z=74 W
    71.6764,   # Z=75 Re
    73.8708,   # Z=76 Os
    76.1110,   # Z=77 Ir
    78.3948,   # Z=78 Pt
    80.7249,   # Z=79 Au
    83.1023,   # Z=80 Hg
    # Z=81 (Tl) through Z=92 (U)
    85.5304,   # Z=81 Tl
    88.0045,   # Z=82 Pb
    90.5259,   # Z=83 Bi
    93.1050,   # Z=84 Po
    95.7300,   # Z=85 At
    98.4040,   # Z=86 Rn
    101.1370,  # Z=87 Fr
    103.9220,  # Z=88 Ra
    106.7590,  # Z=89 Ac
    109.6510,  # Z=90 Th
    112.6010,  # Z=91 Pa
    115.6060,  # Z=92 U
]

"""
K-shell fluorescence yields (ωK), indexed by atomic number Z (1-92).
Probability that a K-shell vacancy is filled via X-ray emission (vs Auger).
Source: M.O. Krause, J. Phys. Chem. Ref. Data, 8 (1979) 307-327.
Also matches Geant4's G4FluoData K-shell yield values.
Zero for Z < 6 (negligible fluorescence for very light elements).
"""
const K_FLUORESCENCE_YIELDS = Float64[
    # Z=1 (H) through Z=10 (Ne)
    0.0,       # Z=1  H   (no fluorescence)
    0.0,       # Z=2  He
    0.0,       # Z=3  Li
    0.0,       # Z=4  Be
    0.0,       # Z=5  B
    0.0017,    # Z=6  C
    0.0028,    # Z=7  N
    0.0083,    # Z=8  O
    0.0132,    # Z=9  F
    0.0185,    # Z=10 Ne
    # Z=11 (Na) through Z=20 (Ca)
    0.0234,    # Z=11 Na
    0.0303,    # Z=12 Mg
    0.0392,    # Z=13 Al
    0.0500,    # Z=14 Si
    0.0620,    # Z=15 P
    0.0760,    # Z=16 S
    0.0910,    # Z=17 Cl
    0.1090,    # Z=18 Ar
    0.1280,    # Z=19 K
    0.1630,    # Z=20 Ca
    # Z=21 (Sc) through Z=30 (Zn)
    0.1780,    # Z=21 Sc
    0.2090,    # Z=22 Ti
    0.2280,    # Z=23 V
    0.2570,    # Z=24 Cr
    0.2810,    # Z=25 Mn
    0.3140,    # Z=26 Fe
    0.3510,    # Z=27 Co
    0.3830,    # Z=28 Ni
    0.4410,    # Z=29 Cu
    0.4690,    # Z=30 Zn
    # Z=31 (Ga) through Z=40 (Zr)
    0.5120,    # Z=31 Ga
    0.5390,    # Z=32 Ge
    0.5670,    # Z=33 As
    0.5960,    # Z=34 Se
    0.6220,    # Z=35 Br
    0.6480,    # Z=36 Kr
    0.6690,    # Z=37 Rb
    0.6910,    # Z=38 Sr
    0.7110,    # Z=39 Y
    0.7300,    # Z=40 Zr
    # Z=41 (Nb) through Z=50 (Sn)
    0.7470,    # Z=41 Nb
    0.7640,    # Z=42 Mo
    0.7790,    # Z=43 Tc
    0.7930,    # Z=44 Ru
    0.8060,    # Z=45 Rh
    0.8180,    # Z=46 Pd
    0.8300,    # Z=47 Ag
    0.8410,    # Z=48 Cd
    0.8510,    # Z=49 In
    0.8590,    # Z=50 Sn
    # Z=51 (Sb) through Z=60 (Nd)
    0.8680,    # Z=51 Sb
    0.8750,    # Z=52 Te
    0.8820,    # Z=53 I
    0.8880,    # Z=54 Xe
    0.8930,    # Z=55 Cs
    0.8990,    # Z=56 Ba
    0.9040,    # Z=57 La
    0.9080,    # Z=58 Ce
    0.9120,    # Z=59 Pr
    0.9150,    # Z=60 Nd
    # Z=61 (Pm) through Z=70 (Yb)
    0.9190,    # Z=61 Pm
    0.9220,    # Z=62 Sm
    0.9250,    # Z=63 Eu
    0.9270,    # Z=64 Gd
    0.9300,    # Z=65 Tb
    0.9320,    # Z=66 Dy
    0.9340,    # Z=67 Ho
    0.9360,    # Z=68 Er
    0.9380,    # Z=69 Tm
    0.9400,    # Z=70 Yb
    # Z=71 (Lu) through Z=80 (Hg)
    0.9410,    # Z=71 Lu
    0.9430,    # Z=72 Hf
    0.9450,    # Z=73 Ta
    0.9460,    # Z=74 W
    0.9480,    # Z=75 Re
    0.9490,    # Z=76 Os
    0.9510,    # Z=77 Ir
    0.9520,    # Z=78 Pt
    0.9530,    # Z=79 Au
    0.9540,    # Z=80 Hg
    # Z=81 (Tl) through Z=92 (U)
    0.9560,    # Z=81 Tl
    0.9570,    # Z=82 Pb
    0.9580,    # Z=83 Bi
    0.9590,    # Z=84 Po
    0.9600,    # Z=85 At
    0.9610,    # Z=86 Rn
    0.9620,    # Z=87 Fr
    0.9630,    # Z=88 Ra
    0.9640,    # Z=89 Ac
    0.9650,    # Z=90 Th
    0.9650,    # Z=91 Pa
    0.9660,    # Z=92 U
]

"""
K-alpha1 (Kα₁) transition energies in keV, indexed by atomic number Z (1-92).
Energy of the dominant K X-ray line (K-L3 transition, 2p3/2 → 1s).
Source: NIST X-Ray Transition Energies, Deslattes et al. (2003).
Zero for Z < 4 (transitions below our energy range or negligible yield).

For MC transport, K-alpha1 is the most probable K fluorescence line (~50-55% of K X-rays).
The full K-alpha (Kα₁ + Kα₂) accounts for ~80% of K X-rays; the remainder is K-beta.
For simplified modeling, using Kα₁ energy for all K fluorescence is acceptable
(error < 1 keV for Z < 82).
"""
const K_ALPHA1_ENERGIES_KEV = Float64[
    # Z=1 (H) through Z=10 (Ne)
    0.0,       # Z=1  H   (no K fluorescence)
    0.0,       # Z=2  He
    0.0,       # Z=3  Li
    0.1085,    # Z=4  Be  (Kα1)
    0.1833,    # Z=5  B
    0.2774,    # Z=6  C
    0.3924,    # Z=7  N
    0.5249,    # Z=8  O
    0.6768,    # Z=9  F
    0.8486,    # Z=10 Ne
    # Z=11 (Na) through Z=20 (Ca)
    1.0410,    # Z=11 Na
    1.2536,    # Z=12 Mg
    1.4867,    # Z=13 Al
    1.7400,    # Z=14 Si
    2.0137,    # Z=15 P
    2.3078,    # Z=16 S
    2.6224,    # Z=17 Cl
    2.9577,    # Z=18 Ar
    3.3138,    # Z=19 K
    3.6917,    # Z=20 Ca
    # Z=21 (Sc) through Z=30 (Zn)
    4.0906,    # Z=21 Sc
    4.5108,    # Z=22 Ti
    4.9522,    # Z=23 V
    5.4147,    # Z=24 Cr
    5.8988,    # Z=25 Mn
    6.4038,    # Z=26 Fe
    6.9303,    # Z=27 Co
    7.4782,    # Z=28 Ni
    8.0478,    # Z=29 Cu
    8.6389,    # Z=30 Zn
    # Z=31 (Ga) through Z=40 (Zr)
    9.2517,    # Z=31 Ga
    9.8864,    # Z=32 Ge
    10.5437,   # Z=33 As
    11.2224,   # Z=34 Se
    11.9242,   # Z=35 Br
    12.6490,   # Z=36 Kr
    13.3953,   # Z=37 Rb
    14.1650,   # Z=38 Sr
    14.9584,   # Z=39 Y
    15.7751,   # Z=40 Zr
    # Z=41 (Nb) through Z=50 (Sn)
    16.6151,   # Z=41 Nb
    17.4793,   # Z=42 Mo
    18.3671,   # Z=43 Tc
    19.2792,   # Z=44 Ru
    20.2161,   # Z=45 Rh
    21.1771,   # Z=46 Pd
    22.1629,   # Z=47 Ag
    23.1736,   # Z=48 Cd
    24.2097,   # Z=49 In
    25.2713,   # Z=50 Sn
    # Z=51 (Sb) through Z=60 (Nd)
    26.3591,   # Z=51 Sb
    27.4723,   # Z=52 Te
    28.6120,   # Z=53 I
    29.7790,   # Z=54 Xe
    30.9728,   # Z=55 Cs
    32.1936,   # Z=56 Ba
    33.4418,   # Z=57 La
    34.7197,   # Z=58 Ce
    36.0263,   # Z=59 Pr
    37.3610,   # Z=60 Nd
    # Z=61 (Pm) through Z=70 (Yb)
    38.7247,   # Z=61 Pm
    40.1181,   # Z=62 Sm
    41.5422,   # Z=63 Eu
    42.9962,   # Z=64 Gd
    44.4816,   # Z=65 Tb
    45.9984,   # Z=66 Dy
    47.5467,   # Z=67 Ho
    49.1277,   # Z=68 Er
    50.7416,   # Z=69 Tm
    52.3889,   # Z=70 Yb
    # Z=71 (Lu) through Z=80 (Hg)
    54.0698,   # Z=71 Lu
    55.7902,   # Z=72 Hf
    57.5320,   # Z=73 Ta
    59.3182,   # Z=74 W
    61.1403,   # Z=75 Re
    62.9991,   # Z=76 Os
    64.8956,   # Z=77 Ir
    66.8320,   # Z=78 Pt
    68.8037,   # Z=79 Au
    70.8190,   # Z=80 Hg
    # Z=81 (Tl) through Z=92 (U)
    72.8715,   # Z=81 Tl
    74.9694,   # Z=82 Pb
    77.1079,   # Z=83 Bi
    79.2900,   # Z=84 Po
    81.5160,   # Z=85 At
    83.7850,   # Z=86 Rn
    86.1050,   # Z=87 Fr
    88.4710,   # Z=88 Ra
    90.8840,   # Z=89 Ac
    93.3500,   # Z=90 Th
    95.8680,   # Z=91 Pa
    98.4390,   # Z=92 U
]

"""
    k_binding_energy(Z::Int) → Float64

Return K-shell binding energy in keV for element with atomic number Z.
"""
function k_binding_energy(Z::Int)
    @assert 1 <= Z <= 92 "Atomic number must be 1-92, got $Z"
    return K_SHELL_BINDING_ENERGIES_KEV[Z]
end

"""
    k_fluorescence_yield(Z::Int) → Float64

Return K-shell fluorescence yield (probability of X-ray vs Auger) for element Z.
"""
function k_fluorescence_yield(Z::Int)
    @assert 1 <= Z <= 92 "Atomic number must be 1-92, got $Z"
    return K_FLUORESCENCE_YIELDS[Z]
end

"""
    k_alpha_energy(Z::Int) → Float64

Return K-alpha1 transition energy in keV for element Z.
"""
function k_alpha_energy(Z::Int)
    @assert 1 <= Z <= 92 "Atomic number must be 1-92, got $Z"
    return K_ALPHA1_ENERGIES_KEV[Z]
end
