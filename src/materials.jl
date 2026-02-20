# ============================================================================
# Material Data - NIST and ICRU Standard Reference Data
# ============================================================================
# Composition data from NIST XCOM database and ICRU-44
# Z/A ratios, mean excitation energies (I), densities, and elemental compositions

"""
Named tuple containing predefined materials for X-ray attenuation calculations.
Access materials by name: Materials.water, Materials.bone, etc.

Categories include:
- Basic materials (water, air)
- Tissue materials (ICRU-44 tissue compositions)
- NCAT phantom materials
- Polymers and plastics
- Detector materials
- Contrast agents and calibration materials
"""
const Materials = (
    # ========================================================================
    # Basic Materials
    # ========================================================================
    water = Material(
        "Water, Liquid",
        0.55508,
        75.0eV,
        1.0g / cm^3,
        Dict(1 => 0.111898, 8 => 0.888102),
    ),
    air = Material(
        "Air, Dry (near sea level)",
        0.49919,
        85.7eV,
        1.205E-03g / cm^3,
        Dict(6 => 0.000124, 7 => 0.755267, 8 => 0.231781, 18 => 0.012827),
    ),

    # ========================================================================
    # ICRU-44 Tissue Materials
    # ========================================================================
    adipose = Material(
        "Adipose Tissue (ICRU-44)",
        0.55579,
        63.2eV,
        0.92g / cm^3,
        Dict(
            1 => 0.119477,
            6 => 0.637240,
            7 => 0.007970,
            8 => 0.232333,
            11 => 0.000500,
            16 => 0.000730,
            17 => 0.001190,
            19 => 0.000320,
            20 => 0.000020,
            26 => 0.000020,
            30 => 0.000020,
        ),
    ),
    corticalbone = Material(
        "Bone, Cortical (ICRU-44)",
        0.51478,
        106.4eV,
        1.92g / cm^3,
        Dict(
            1 => 0.034000,
            6 => 0.155000,
            7 => 0.042000,
            8 => 0.435000,
            11 => 0.001000,
            12 => 0.002000,
            15 => 0.103000,
            16 => 0.003000,
            20 => 0.225000,
        ),
    ),
    softtissue = Material(
        "Tissue, Soft (ICRU-44)",
        0.54996,
        72.3eV,
        1.06g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.143000,
            7 => 0.034000,
            8 => 0.708000,
            11 => 0.002000,
            15 => 0.003000,
            16 => 0.003000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    muscle = Material(
        "Muscle, Skeletal (ICRU-44)",
        0.54938,
        75.3eV,
        1.05g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.143000,
            7 => 0.034000,
            8 => 0.710000,
            11 => 0.001000,
            15 => 0.002000,
            16 => 0.003000,
            17 => 0.001000,
            19 => 0.004000,
        ),
    ),
    lung = Material(
        "Lung Tissue (ICRU-44)",
        0.55048,
        75.3eV,
        0.26g / cm^3,
        Dict(
            1 => 0.103000,
            6 => 0.105000,
            7 => 0.031000,
            8 => 0.749000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.003000,
            17 => 0.003000,
            19 => 0.002000,
        ),
    ),
    brain = Material(
        "Brain (ICRU-44)",
        0.55239,
        73.3eV,
        1.04g / cm^3,
        Dict(
            1 => 0.107000,
            6 => 0.145000,
            7 => 0.022000,
            8 => 0.712000,
            11 => 0.002000,
            15 => 0.004000,
            16 => 0.002000,
            17 => 0.003000,
            19 => 0.003000,
        ),
    ),
    blood = Material(
        "Blood, Whole (ICRU-44)",
        0.54999,
        75.2eV,
        1.06g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.110000,
            7 => 0.033000,
            8 => 0.745000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.003000,
            19 => 0.002000,
            26 => 0.001000,
        ),
    ),
    wholeblood = Material(
        "Blood, Whole (ICRU-44)",
        0.54999,
        75.2eV,
        1.06g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.110000,
            7 => 0.033000,
            8 => 0.745000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.003000,
            19 => 0.002000,
            26 => 0.001000,
        ),
    ),
    skin = Material(
        "Skin (ICRU-44)",
        0.54932,
        72.7eV,
        1.09g / cm^3,
        Dict(
            1 => 0.100000,
            6 => 0.204000,
            7 => 0.042000,
            8 => 0.645000,
            11 => 0.002000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.003000,
            19 => 0.001000,
        ),
    ),
    liver = Material(
        "Liver (ICRU-44)",
        0.55052,
        72.5eV,
        1.06g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.139000,
            7 => 0.030000,
            8 => 0.716000,
            11 => 0.002000,
            15 => 0.003000,
            16 => 0.003000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    kidney = Material(
        "Kidney (ICRU-44)",
        0.55066,
        72.6eV,
        1.05g / cm^3,
        Dict(
            1 => 0.103000,
            6 => 0.132000,
            7 => 0.030000,
            8 => 0.724000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.002000,
            20 => 0.001000,
        ),
    ),
    heart = Material(
        "Heart (ICRU-44)",
        0.55021,
        72.6eV,
        1.05g / cm^3,
        Dict(
            1 => 0.104000,
            6 => 0.139000,
            7 => 0.029000,
            8 => 0.718000,
            11 => 0.001000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    spleen = Material(
        "Spleen (ICRU-44)",
        0.55024,
        72.5eV,
        1.06g / cm^3,
        Dict(
            1 => 0.103000,
            6 => 0.113000,
            7 => 0.032000,
            8 => 0.741000,
            11 => 0.001000,
            15 => 0.003000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    pancreas = Material(
        "Pancreas (ICRU-44)",
        0.55028,
        72.5eV,
        1.04g / cm^3,
        Dict(
            1 => 0.106000,
            6 => 0.169000,
            7 => 0.022000,
            8 => 0.694000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.001000,
            17 => 0.002000,
            19 => 0.002000,
        ),
    ),
    stomach = Material(
        "Stomach (ICRU-44)",
        0.55020,
        72.6eV,
        1.05g / cm^3,
        Dict(
            1 => 0.105000,
            6 => 0.115000,
            7 => 0.025000,
            8 => 0.751000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.001000,
            17 => 0.001000,
        ),
    ),
    intestine = Material(
        "Intestine (ICRU-44)",
        0.55017,
        72.5eV,
        1.03g / cm^3,
        Dict(
            1 => 0.106000,
            6 => 0.115000,
            7 => 0.022000,
            8 => 0.751000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.001000,
            17 => 0.002000,
            19 => 0.001000,
        ),
    ),
    thyroid = Material(
        "Thyroid (ICRU-44)",
        0.55009,
        72.5eV,
        1.05g / cm^3,
        Dict(
            1 => 0.104000,
            6 => 0.119000,
            7 => 0.024000,
            8 => 0.745000,
            11 => 0.002000,
            15 => 0.001000,
            16 => 0.001000,
            17 => 0.002000,
            19 => 0.001000,
            53 => 0.001000,
        ),
    ),
    cartilage = Material(
        "Cartilage (ICRU-44)",
        0.54595,
        72.6eV,
        1.10g / cm^3,
        Dict(
            1 => 0.096000,
            6 => 0.099000,
            7 => 0.022000,
            8 => 0.744000,
            11 => 0.005000,
            15 => 0.022000,
            16 => 0.009000,
            17 => 0.003000,
        ),
    ),
    eye_lens = Material(
        "Eye Lens (ICRU-44)",
        0.54707,
        73.3eV,
        1.07g / cm^3,
        Dict(
            1 => 0.096000,
            6 => 0.195000,
            7 => 0.057000,
            8 => 0.646000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.003000,
            17 => 0.001000,
        ),
    ),
    mammary_gland = Material(
        "Mammary Gland (ICRU-44)",
        0.55180,
        70.0eV,
        1.02g / cm^3,
        Dict(
            1 => 0.106000,
            6 => 0.332000,
            7 => 0.030000,
            8 => 0.527000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.001000,
        ),
    ),
    ovary = Material(
        "Ovary (ICRU-44)",
        0.55075,
        72.6eV,
        1.05g / cm^3,
        Dict(
            1 => 0.105000,
            6 => 0.093000,
            7 => 0.024000,
            8 => 0.768000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.002000,
        ),
    ),
    testis = Material(
        "Testis (ICRU-44)",
        0.55080,
        72.5eV,
        1.04g / cm^3,
        Dict(
            1 => 0.106000,
            6 => 0.099000,
            7 => 0.020000,
            8 => 0.766000,
            11 => 0.002000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.002000,
        ),
    ),
    urinary_bladder = Material(
        "Urinary Bladder (ICRU-44)",
        0.55006,
        72.6eV,
        1.04g / cm^3,
        Dict(
            1 => 0.105000,
            6 => 0.096000,
            7 => 0.026000,
            8 => 0.761000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.003000,
            19 => 0.003000,
        ),
    ),
    uterus = Material(
        "Uterus (ICRU-44)",
        0.55052,
        72.5eV,
        1.03g / cm^3,
        Dict(
            1 => 0.105000,
            6 => 0.086000,
            7 => 0.025000,
            8 => 0.773000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    prostate = Material(
        "Prostate (ICRU-44)",
        0.55028,
        72.5eV,
        1.04g / cm^3,
        Dict(
            1 => 0.105000,
            6 => 0.089000,
            7 => 0.025000,
            8 => 0.770000,
            11 => 0.002000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.002000,
            30 => 0.002000,
        ),
    ),
    lymph = Material(
        "Lymph (ICRU-44)",
        0.55009,
        72.5eV,
        1.03g / cm^3,
        Dict(
            1 => 0.108000,
            6 => 0.041000,
            7 => 0.011000,
            8 => 0.832000,
            11 => 0.003000,
            16 => 0.001000,
            17 => 0.004000,
        ),
    ),
    marrow_red = Material(
        "Red Marrow (ICRU-44)",
        0.54918,
        73.3eV,
        1.03g / cm^3,
        Dict(
            1 => 0.105000,
            6 => 0.414000,
            7 => 0.034000,
            8 => 0.439000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.002000,
            26 => 0.001000,
        ),
    ),
    marrow_yellow = Material(
        "Yellow Marrow (ICRU-44)",
        0.55909,
        64.0eV,
        0.98g / cm^3,
        Dict(
            1 => 0.115000,
            6 => 0.644000,
            7 => 0.007000,
            8 => 0.231000,
            11 => 0.001000,
            16 => 0.001000,
            17 => 0.001000,
        ),
    ),

    # ========================================================================
    # Bone Materials
    # ========================================================================
    bone_calcium = Material(
        "Calcium in Bone",
        0.49903,
        191.0eV,
        1.55g / cm^3,
        Dict(20 => 1.0),
    ),
    calcium = Material(
        "Calcium",
        0.49903,
        191.0eV,
        1.55g / cm^3,
        Dict(20 => 1.0),
    ),
    calcium_ite = Material(
        "CalciumIte (CaCO3)",
        0.49955,
        136.4eV,
        2.71g / cm^3,
        Dict(6 => 0.120003, 8 => 0.479554, 20 => 0.400443),
    ),
    calcium_ite100 = Material(
        "Calcium Hydroxyapatite 100 mg/cc",
        0.51565,
        100.0eV,
        1.10g / cm^3,
        Dict(1 => 0.103455, 6 => 0.143000, 7 => 0.034000, 8 => 0.657673, 15 => 0.017873, 20 => 0.043999),
    ),
    calcium_ite200 = Material(
        "Calcium Hydroxyapatite 200 mg/cc",
        0.52119,
        110.0eV,
        1.20g / cm^3,
        Dict(1 => 0.096000, 6 => 0.143000, 7 => 0.034000, 8 => 0.612218, 15 => 0.035207, 20 => 0.079575),
    ),
    calcium_ite300 = Material(
        "Calcium Hydroxyapatite 300 mg/cc",
        0.52547,
        115.0eV,
        1.30g / cm^3,
        Dict(1 => 0.089000, 6 => 0.143000, 7 => 0.034000, 8 => 0.576269, 15 => 0.050400, 20 => 0.107331),
    ),
    calcium_ite400 = Material(
        "Calcium Hydroxyapatite 400 mg/cc",
        0.52876,
        120.0eV,
        1.40g / cm^3,
        Dict(1 => 0.082500, 6 => 0.143000, 7 => 0.034000, 8 => 0.548506, 15 => 0.061889, 20 => 0.130105),
    ),
    calcium_ite500 = Material(
        "Calcium Hydroxyapatite 500 mg/cc",
        0.53134,
        124.0eV,
        1.50g / cm^3,
        Dict(1 => 0.076500, 6 => 0.143000, 7 => 0.034000, 8 => 0.527106, 15 => 0.071080, 20 => 0.148314),
    ),
    calcium_ite600 = Material(
        "Calcium Hydroxyapatite 600 mg/cc",
        0.53341,
        127.0eV,
        1.60g / cm^3,
        Dict(1 => 0.070900, 6 => 0.143000, 7 => 0.034000, 8 => 0.511069, 15 => 0.078363, 20 => 0.162668),
    ),
    calcium_ite700 = Material(
        "Calcium Hydroxyapatite 700 mg/cc",
        0.53510,
        130.0eV,
        1.70g / cm^3,
        Dict(1 => 0.065700, 6 => 0.143000, 7 => 0.034000, 8 => 0.498940, 15 => 0.084110, 20 => 0.174250),
    ),
    calcium_ite800 = Material(
        "Calcium Hydroxyapatite 800 mg/cc",
        0.53651,
        132.0eV,
        1.80g / cm^3,
        Dict(1 => 0.060900, 6 => 0.143000, 7 => 0.034000, 8 => 0.489668, 15 => 0.088579, 20 => 0.183853),
    ),
    hydroxyapatite = Material(
        "Calcium Hydroxyapatite Ca10(PO4)6(OH)2",
        0.49926,
        141.0eV,
        3.18g / cm^3,
        Dict(1 => 0.002013, 8 => 0.414930, 15 => 0.185020, 20 => 0.398037),
    ),

    # ========================================================================
    # NCAT Phantom Materials
    # ========================================================================
    ncat_body = Material(
        "NCAT Body (Soft Tissue)",
        0.54996,
        72.3eV,
        1.05g / cm^3,
        Dict(
            1 => 0.104472,
            6 => 0.232190,
            7 => 0.024880,
            8 => 0.630238,
            11 => 0.001130,
            15 => 0.001330,
            16 => 0.001990,
            17 => 0.001340,
            19 => 0.001990,
            20 => 0.000230,
            26 => 0.000050,
            30 => 0.000030,
        ),
    ),
    ncat_heart = Material(
        "NCAT Heart",
        0.55021,
        72.6eV,
        1.05g / cm^3,
        Dict(
            1 => 0.104000,
            6 => 0.139000,
            7 => 0.029000,
            8 => 0.718000,
            11 => 0.001000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    ncat_liver = Material(
        "NCAT Liver",
        0.55052,
        72.5eV,
        1.06g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.139000,
            7 => 0.030000,
            8 => 0.716000,
            11 => 0.002000,
            15 => 0.003000,
            16 => 0.003000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    ncat_kidney = Material(
        "NCAT Kidney",
        0.55066,
        72.6eV,
        1.05g / cm^3,
        Dict(
            1 => 0.103000,
            6 => 0.132000,
            7 => 0.030000,
            8 => 0.724000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.002000,
            20 => 0.001000,
        ),
    ),
    ncat_spleen = Material(
        "NCAT Spleen",
        0.55024,
        72.5eV,
        1.06g / cm^3,
        Dict(
            1 => 0.103000,
            6 => 0.113000,
            7 => 0.032000,
            8 => 0.741000,
            11 => 0.001000,
            15 => 0.003000,
            16 => 0.002000,
            17 => 0.002000,
            19 => 0.003000,
        ),
    ),
    ncat_lung = Material(
        "NCAT Lung",
        0.55048,
        75.3eV,
        0.26g / cm^3,
        Dict(
            1 => 0.103000,
            6 => 0.105000,
            7 => 0.031000,
            8 => 0.749000,
            11 => 0.002000,
            15 => 0.002000,
            16 => 0.003000,
            17 => 0.003000,
            19 => 0.002000,
        ),
    ),
    ncat_muscle = Material(
        "NCAT Muscle",
        0.54938,
        75.3eV,
        1.05g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.143000,
            7 => 0.034000,
            8 => 0.710000,
            11 => 0.001000,
            15 => 0.002000,
            16 => 0.003000,
            17 => 0.001000,
            19 => 0.004000,
        ),
    ),
    ncat_bone = Material(
        "NCAT Bone",
        0.51478,
        106.4eV,
        1.92g / cm^3,
        Dict(
            1 => 0.034000,
            6 => 0.155000,
            7 => 0.042000,
            8 => 0.435000,
            11 => 0.001000,
            12 => 0.002000,
            15 => 0.103000,
            16 => 0.003000,
            20 => 0.225000,
        ),
    ),
    ncat_spine = Material(
        "NCAT Spine",
        0.52500,
        95.0eV,
        1.42g / cm^3,
        Dict(
            1 => 0.063984,
            6 => 0.278000,
            7 => 0.039900,
            8 => 0.473700,
            12 => 0.001100,
            15 => 0.061600,
            16 => 0.001700,
            20 => 0.079900,
            30 => 0.000100,
        ),
    ),
    ncat_rib = Material(
        "NCAT Rib",
        0.51900,
        100.0eV,
        1.52g / cm^3,
        Dict(
            1 => 0.056300,
            6 => 0.235000,
            7 => 0.040900,
            8 => 0.459400,
            12 => 0.001100,
            15 => 0.070200,
            16 => 0.002200,
            20 => 0.134800,
            30 => 0.000100,
        ),
    ),
    ncat_blood = Material(
        "NCAT Blood",
        0.54999,
        75.2eV,
        1.06g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.110000,
            7 => 0.033000,
            8 => 0.745000,
            11 => 0.001000,
            15 => 0.001000,
            16 => 0.002000,
            17 => 0.003000,
            19 => 0.002000,
            26 => 0.001000,
        ),
    ),
    # Blood with various iodine concentrations
    ncat_blood_with_0_7pct_iodine=Material(
        "NCAT Blood with 0.7% Iodine (7.47 mg I/mL)",
        0.54,  # Approximate Z/A ratio
        75.5eV,  # Approximate I value
        1.067472g / cm^3,
        Dict(
            1 => 0.101286,
            6 => 0.109230,
            7 => 0.032769,
            8 => 0.739785,
            11 => 0.000993,
            15 => 0.000993,
            16 => 0.001986,
            17 => 0.002979,
            19 => 0.001986,
            26 => 0.000993,
            53 => 0.007000,
        ),
    ),
    ncat_blood_with_0_9pct_iodine=Material(
        "NCAT Blood with 0.9% Iodine (9.63 mg I/mL)",
        0.54,  # Approximate Z/A ratio
        75.5eV,  # Approximate I value
        1.069627g / cm^3,
        Dict(
            1 => 0.101082,
            6 => 0.109010,
            7 => 0.032703,
            8 => 0.738295,
            11 => 0.000991,
            15 => 0.000991,
            16 => 0.001982,
            17 => 0.002973,
            19 => 0.001982,
            26 => 0.000991,
            53 => 0.009000,
        ),
    ),
    ncat_blood_with_1_0pct_iodine=Material(
        "NCAT Blood with 1.0% Iodine (10.70 mg I/mL)",
        0.54,  # Approximate Z/A ratio
        75.5eV,  # Approximate I value
        1.070707g / cm^3,
        Dict(
            1 => 0.100980,
            6 => 0.108900,
            7 => 0.032670,
            8 => 0.737550,
            11 => 0.000990,
            15 => 0.000990,
            16 => 0.001980,
            17 => 0.002970,
            19 => 0.001980,
            26 => 0.000990,
            53 => 0.010000,
        ),
    ),
    ncat_blood_with_1_1pct_iodine=Material(
        "NCAT Blood with 1.1% Iodine (11.79 mg I/mL)",
        0.54,  # Approximate Z/A ratio
        75.5eV,  # Approximate I value
        1.071789g / cm^3,
        Dict(
            1 => 0.100878,
            6 => 0.108790,
            7 => 0.032637,
            8 => 0.736805,
            11 => 0.000989,
            15 => 0.000989,
            16 => 0.001978,
            17 => 0.002967,
            19 => 0.001978,
            26 => 0.000989,
            53 => 0.011000,
        ),
    ),
    ncat_blood_with_2_0pct_iodine=Material(
        "NCAT Blood with 2.0% Iodine (21.63 mg I/mL)",
        0.54,  # Approximate Z/A ratio
        75.5eV,  # Approximate I value
        1.081632g / cm^3,
        Dict(
            1 => 0.099960,
            6 => 0.107800,
            7 => 0.032340,
            8 => 0.730100,
            11 => 0.000980,
            15 => 0.000980,
            16 => 0.001960,
            17 => 0.002940,
            19 => 0.001960,
            26 => 0.000980,
            53 => 0.020000,
        ),
    ),
    ncat_blood_with_3_0pct_iodine=Material(
        "NCAT Blood with 3.0% Iodine (32.78 mg I/mL)",
        0.53,  # Approximate Z/A ratio
        76.0eV,  # Approximate I value
        1.092784g / cm^3,
        Dict(
            1 => 0.098940,
            6 => 0.106700,
            7 => 0.032010,
            8 => 0.722650,
            11 => 0.000970,
            15 => 0.000970,
            16 => 0.001940,
            17 => 0.002910,
            19 => 0.001940,
            26 => 0.000970,
            53 => 0.030000,
        )
    ),
    ncat_fat = Material(
        "NCAT Fat/Adipose",
        0.55579,
        63.2eV,
        0.92g / cm^3,
        Dict(
            1 => 0.119477,
            6 => 0.637240,
            7 => 0.007970,
            8 => 0.232333,
            11 => 0.000500,
            16 => 0.000730,
            17 => 0.001190,
            19 => 0.000320,
            20 => 0.000020,
            26 => 0.000020,
            30 => 0.000020,
        ),
    ),

    # ========================================================================
    # Polymer and Plastic Materials
    # ========================================================================
    pmma = Material(
        "Polymethyl Methacrylate (PMMA, Lucite, Acrylic)",
        0.53937,
        74.0eV,
        1.19g / cm^3,
        Dict(1 => 0.080538, 6 => 0.599848, 8 => 0.319614),
    ),
    polyethylene = Material(
        "Polyethylene",
        0.57034,
        57.4eV,
        0.93g / cm^3,
        Dict(1 => 0.143711, 6 => 0.856289),
    ),
    polystyrene = Material(
        "Polystyrene",
        0.53768,
        68.7eV,
        1.06g / cm^3,
        Dict(1 => 0.077418, 6 => 0.922582),
    ),
    teflon = Material(
        "Teflon (PTFE)",
        0.47992,
        99.1eV,
        2.20g / cm^3,
        Dict(6 => 0.240183, 9 => 0.759817),
    ),
    pvc = Material(
        "Polyvinyl Chloride (PVC)",
        0.51201,
        108.2eV,
        1.40g / cm^3,
        Dict(1 => 0.048380, 6 => 0.384361, 17 => 0.567259),
    ),
    mylar = Material(
        "Mylar (PET, Polyethylene Terephthalate)",
        0.52037,
        78.7eV,
        1.40g / cm^3,
        Dict(1 => 0.041959, 6 => 0.625017, 8 => 0.333024),
    ),
    nylon = Material(
        "Nylon, Type 6/6",
        0.54790,
        63.9eV,
        1.14g / cm^3,
        Dict(1 => 0.097976, 6 => 0.636856, 7 => 0.123779, 8 => 0.141389),
    ),
    kapton = Material(
        "Kapton Polyimide Film",
        0.51264,
        79.6eV,
        1.42g / cm^3,
        Dict(1 => 0.026362, 6 => 0.691133, 7 => 0.073270, 8 => 0.209235),
    ),
    lexan = Material(
        "Lexan (Polycarbonate)",
        0.52697,
        73.1eV,
        1.20g / cm^3,
        Dict(1 => 0.055491, 6 => 0.755751, 8 => 0.188758),
    ),
    paraffin = Material(
        "Paraffin Wax",
        0.57275,
        55.9eV,
        0.93g / cm^3,
        Dict(1 => 0.148605, 6 => 0.851395),
    ),
    epoxy = Material(
        "Epoxy Resin",
        0.53790,
        67.0eV,
        1.15g / cm^3,
        Dict(1 => 0.064700, 6 => 0.646000, 7 => 0.003000, 8 => 0.286300),
    ),

    # ========================================================================
    # Detector Materials
    # ========================================================================
    gos = Material(
        "Gadolinium Oxysulfide (GOS, Gd2O2S)",
        0.42266,
        493.3eV,
        7.34g / cm^3,
        Dict(8 => 0.084527, 16 => 0.084704, 64 => 0.830769),
    ),
    csi = Material(
        "Cesium Iodide (CsI)",
        0.41569,
        553.1eV,
        4.51g / cm^3,
        Dict(53 => 0.488451, 55 => 0.511549),
    ),
    cdte = Material(
        "Cadmium Telluride (CdTe)",
        0.41626,
        539.3eV,
        6.20g / cm^3,
        Dict(48 => 0.468355, 52 => 0.531645),
    ),
    caf = Material(
        "Calcium Fluoride (CaF2)",
        0.48671,
        166.0eV,
        3.18g / cm^3,
        Dict(9 => 0.486659, 20 => 0.513341),
    ),
    gaas = Material(
        "Gallium Arsenide (GaAs)",
        0.44247,
        384.9eV,
        5.31g / cm^3,
        Dict(31 => 0.482030, 33 => 0.517970),
    ),
    nai = Material(
        "Sodium Iodide (NaI)",
        0.42697,
        452.0eV,
        3.67g / cm^3,
        Dict(11 => 0.153373, 53 => 0.846627),
    ),
    bgo = Material(
        "Bismuth Germanate (BGO, Bi4Ge3O12)",
        0.42065,
        534.1eV,
        7.13g / cm^3,
        Dict(8 => 0.154126, 32 => 0.174820, 83 => 0.671054),
    ),
    lso = Material(
        "Lutetium Oxyorthosilicate (LSO, Lu2SiO5)",
        0.40907,
        565.0eV,
        7.40g / cm^3,
        Dict(8 => 0.182034, 14 => 0.063714, 71 => 0.754252),
    ),
    lyso = Material(
        "Lutetium Yttrium Oxyorthosilicate (LYSO)",
        0.41200,
        550.0eV,
        7.10g / cm^3,
        Dict(8 => 0.182034, 14 => 0.063714, 39 => 0.040000, 71 => 0.714252),
    ),
    cwo = Material(
        "Cadmium Tungstate (CdWO4)",
        0.41280,
        550.0eV,
        7.90g / cm^3,
        Dict(8 => 0.177645, 48 => 0.312027, 74 => 0.510328),
    ),
    se = Material(
        "Amorphous Selenium",
        0.43060,
        348.0eV,
        4.50g / cm^3,
        Dict(34 => 1.0),
    ),
    silicon = Material(
        "Silicon (crystalline)",
        0.49848,
        173.0eV,
        2.33g / cm^3,
        Dict(14 => 1.0),
    ),
    germanium = Material(
        "Germanium (crystalline)",
        0.44071,
        350.0eV,
        5.32g / cm^3,
        Dict(32 => 1.0),
    ),

    # ========================================================================
    # Shielding and Construction Materials
    # ========================================================================
    concrete = Material(
        "Concrete, Ordinary (NIST)",
        0.50932,
        135.2eV,
        2.30g / cm^3,
        Dict(
            1 => 0.022100,
            6 => 0.002484,
            8 => 0.574930,
            11 => 0.015208,
            12 => 0.001266,
            13 => 0.019953,
            14 => 0.304627,
            19 => 0.010045,
            20 => 0.042951,
            26 => 0.006435,
        ),
    ),
    concrete_barite = Material(
        "Concrete, Barite (iteiteite)",
        0.45560,
        221.0eV,
        3.35g / cm^3,
        Dict(
            1 => 0.003585,
            8 => 0.311622,
            12 => 0.001195,
            13 => 0.004183,
            14 => 0.010457,
            16 => 0.107858,
            20 => 0.050194,
            26 => 0.047505,
            56 => 0.463400,
        ),
    ),
    lead_glass = Material(
        "Lead Glass",
        0.42101,
        526.4eV,
        6.22g / cm^3,
        Dict(8 => 0.156453, 14 => 0.080866, 22 => 0.008092, 33 => 0.002651, 82 => 0.751938),
    ),
    borosilicate_glass = Material(
        "Borosilicate Glass (Pyrex)",
        0.49707,
        134.0eV,
        2.23g / cm^3,
        Dict(5 => 0.040066, 8 => 0.539559, 11 => 0.028191, 13 => 0.011644, 14 => 0.377220, 19 => 0.003321),
    ),
    soda_lime_glass = Material(
        "Soda Lime Glass",
        0.49712,
        145.4eV,
        2.53g / cm^3,
        Dict(8 => 0.459800, 11 => 0.096441, 14 => 0.336553, 20 => 0.107205),
    ),
    copper = Material(
        "Copper (pure)",
        0.45636,
        322.0eV,
        8.96g / cm^3,
        Dict(29 => 1.0),
    ),
    aluminum = Material(
        "Aluminum (pure)",
        0.48181,
        166.0eV,
        2.70g / cm^3,
        Dict(13 => 1.0),
    ),
    lead = Material(
        "Lead (pure)",
        0.39575,
        823.0eV,
        11.35g / cm^3,
        Dict(82 => 1.0),
    ),
    tungsten = Material(
        "Tungsten (pure)",
        0.40250,
        727.0eV,
        19.30g / cm^3,
        Dict(74 => 1.0),
    ),
    gold = Material(
        "Gold (pure)",
        0.40108,
        790.0eV,
        19.32g / cm^3,
        Dict(79 => 1.0),
    ),
    iron = Material(
        "Iron (pure)",
        0.46556,
        286.0eV,
        7.87g / cm^3,
        Dict(26 => 1.0),
    ),
    steel_stainless = Material(
        "Stainless Steel 304",
        0.46235,
        283.0eV,
        8.00g / cm^3,
        Dict(6 => 0.0008, 14 => 0.01, 15 => 0.00045, 16 => 0.0003, 24 => 0.19, 25 => 0.02, 26 => 0.68095, 28 => 0.095, 42 => 0.0025),
    ),

    # ========================================================================
    # Contrast Agent Materials
    # ========================================================================
    iodine = Material(
        "Iodine (pure)",
        0.41764,
        491.0eV,
        4.93g / cm^3,
        Dict(53 => 1.0),
    ),
    barium = Material(
        "Barium (pure)",
        0.40779,
        491.0eV,
        3.50g / cm^3,
        Dict(56 => 1.0),
    ),
    gadolinium = Material(
        "Gadolinium (pure)",
        0.40699,
        591.0eV,
        7.90g / cm^3,
        Dict(64 => 1.0),
    ),
    barium_sulfate = Material(
        "Barium Sulfate (BaSO4)",
        0.43953,
        285.7eV,
        4.50g / cm^3,
        Dict(8 => 0.274212, 16 => 0.137368, 56 => 0.588420),
    ),

    # Iodine contrast agent concentrations (in water)
    iodine_1 = Material(
        "Iodine 1 mg/mL in Water",
        0.55473,
        75.4eV,
        1.001g / cm^3,
        Dict(1 => 0.111786, 8 => 0.887214, 53 => 0.001000),
    ),
    iodine_2 = Material(
        "Iodine 2 mg/mL in Water",
        0.55438,
        75.8eV,
        1.002g / cm^3,
        Dict(1 => 0.111674, 8 => 0.886326, 53 => 0.002000),
    ),
    iodine_5 = Material(
        "Iodine 5 mg/mL in Water",
        0.55333,
        77.0eV,
        1.005g / cm^3,
        Dict(1 => 0.111340, 8 => 0.883660, 53 => 0.005000),
    ),
    iodine_10 = Material(
        "Iodine 10 mg/mL in Water",
        0.55158,
        79.0eV,
        1.010g / cm^3,
        Dict(1 => 0.110787, 8 => 0.879213, 53 => 0.010000),
    ),
    iodine_15 = Material(
        "Iodine 15 mg/mL in Water",
        0.54986,
        81.0eV,
        1.015g / cm^3,
        Dict(1 => 0.110238, 8 => 0.874762, 53 => 0.015000),
    ),
    iodine_20 = Material(
        "Iodine 20 mg/mL in Water",
        0.54817,
        83.0eV,
        1.020g / cm^3,
        Dict(1 => 0.109694, 8 => 0.870306, 53 => 0.020000),
    ),
    iodine_25 = Material(
        "Iodine 25 mg/mL in Water",
        0.54650,
        85.0eV,
        1.025g / cm^3,
        Dict(1 => 0.109154, 8 => 0.865846, 53 => 0.025000),
    ),
    iodine_30 = Material(
        "Iodine 30 mg/mL in Water",
        0.54487,
        87.0eV,
        1.030g / cm^3,
        Dict(1 => 0.108618, 8 => 0.861382, 53 => 0.030000),
    ),
    iodine_40 = Material(
        "Iodine 40 mg/mL in Water",
        0.54166,
        91.0eV,
        1.040g / cm^3,
        Dict(1 => 0.107556, 8 => 0.852444, 53 => 0.040000),
    ),
    iodine_50 = Material(
        "Iodine 50 mg/mL in Water",
        0.53854,
        95.0eV,
        1.050g / cm^3,
        Dict(1 => 0.106509, 8 => 0.843491, 53 => 0.050000),
    ),

    # Omnipaque (Iohexol) concentrations
    omnipaque_140 = Material(
        "Omnipaque 140 (Iohexol, 64.7 mg I/mL)",
        0.53678,
        95.0eV,
        1.16g / cm^3,
        Dict(1 => 0.086200, 6 => 0.179400, 7 => 0.025700, 8 => 0.652900, 53 => 0.055800),
    ),
    omnipaque_180 = Material(
        "Omnipaque 180 (Iohexol, 83.2 mg I/mL)",
        0.53350,
        100.0eV,
        1.21g / cm^3,
        Dict(1 => 0.082400, 6 => 0.198700, 7 => 0.028400, 8 => 0.621800, 53 => 0.068700),
    ),
    omnipaque_240 = Material(
        "Omnipaque 240 (Iohexol, 110.9 mg I/mL)",
        0.52868,
        110.0eV,
        1.28g / cm^3,
        Dict(1 => 0.076500, 6 => 0.225500, 7 => 0.032300, 8 => 0.579100, 53 => 0.086600),
    ),
    omnipaque_300 = Material(
        "Omnipaque 300 (Iohexol, 138.6 mg I/mL)",
        0.52351,
        120.0eV,
        1.35g / cm^3,
        Dict(1 => 0.070200, 6 => 0.253800, 7 => 0.036300, 8 => 0.535000, 53 => 0.104700),
    ),
    omnipaque_350 = Material(
        "Omnipaque 350 (Iohexol, 161.8 mg I/mL)",
        0.51920,
        128.0eV,
        1.41g / cm^3,
        Dict(1 => 0.064800, 6 => 0.278400, 7 => 0.039800, 8 => 0.496300, 53 => 0.120700),
    ),

    # ========================================================================
    # Basis Materials for Decomposition
    # ========================================================================
    basis_water = Material(
        "Water (Basis Material)",
        0.55508,
        75.0eV,
        1.0g / cm^3,
        Dict(1 => 0.111898, 8 => 0.888102),
    ),
    basis_bone = Material(
        "Bone (Basis Material)",
        0.51478,
        106.4eV,
        1.92g / cm^3,
        Dict(
            1 => 0.034000,
            6 => 0.155000,
            7 => 0.042000,
            8 => 0.435000,
            11 => 0.001000,
            12 => 0.002000,
            15 => 0.103000,
            16 => 0.003000,
            20 => 0.225000,
        ),
    ),
    basis_iodine = Material(
        "Iodine (Basis Material)",
        0.41764,
        491.0eV,
        4.93g / cm^3,
        Dict(53 => 1.0),
    ),
    basis_calcium = Material(
        "Calcium (Basis Material)",
        0.49903,
        191.0eV,
        1.55g / cm^3,
        Dict(20 => 1.0),
    ),
    basis_fat = Material(
        "Fat/Adipose (Basis Material)",
        0.55579,
        63.2eV,
        0.92g / cm^3,
        Dict(
            1 => 0.119477,
            6 => 0.637240,
            7 => 0.007970,
            8 => 0.232333,
            11 => 0.000500,
            16 => 0.000730,
            17 => 0.001190,
            19 => 0.000320,
            20 => 0.000020,
            26 => 0.000020,
            30 => 0.000020,
        ),
    ),
    basis_muscle = Material(
        "Muscle (Basis Material)",
        0.54938,
        75.3eV,
        1.05g / cm^3,
        Dict(
            1 => 0.102000,
            6 => 0.143000,
            7 => 0.034000,
            8 => 0.710000,
            11 => 0.001000,
            15 => 0.002000,
            16 => 0.003000,
            17 => 0.001000,
            19 => 0.004000,
        ),
    ),
    basis_air = Material(
        "Air (Basis Material)",
        0.49919,
        85.7eV,
        1.205E-03g / cm^3,
        Dict(6 => 0.000124, 7 => 0.755267, 8 => 0.231781, 18 => 0.012827),
    ),
    basis_gadolinium = Material(
        "Gadolinium (Basis Material)",
        0.40699,
        591.0eV,
        7.90g / cm^3,
        Dict(64 => 1.0),
    ),

    # ========================================================================
    # Calibration Phantom Materials
    # ========================================================================
    catphan_teflon = Material(
        "Catphan Teflon Insert",
        0.47992,
        99.1eV,
        2.16g / cm^3,
        Dict(6 => 0.240183, 9 => 0.759817),
    ),
    catphan_delrin = Material(
        "Catphan Delrin Insert (Acetal)",
        0.52698,
        77.4eV,
        1.41g / cm^3,
        Dict(1 => 0.067135, 6 => 0.400017, 8 => 0.532848),
    ),
    catphan_acrylic = Material(
        "Catphan Acrylic Insert",
        0.53937,
        74.0eV,
        1.18g / cm^3,
        Dict(1 => 0.080538, 6 => 0.599848, 8 => 0.319614),
    ),
    catphan_polystyrene = Material(
        "Catphan Polystyrene Insert",
        0.53768,
        68.7eV,
        1.03g / cm^3,
        Dict(1 => 0.077418, 6 => 0.922582),
    ),
    catphan_ldpe = Material(
        "Catphan LDPE Insert",
        0.57034,
        57.4eV,
        0.92g / cm^3,
        Dict(1 => 0.143711, 6 => 0.856289),
    ),
    catphan_pmp = Material(
        "Catphan PMP Insert",
        0.55910,
        52.0eV,
        0.83g / cm^3,
        Dict(1 => 0.143711, 6 => 0.856289),
    ),
    catphan_air = Material(
        "Catphan Air Insert",
        0.49919,
        85.7eV,
        1.205E-03g / cm^3,
        Dict(6 => 0.000124, 7 => 0.755267, 8 => 0.231781, 18 => 0.012827),
    ),
    catphan_water = Material(
        "Catphan Water Insert",
        0.55508,
        75.0eV,
        1.0g / cm^3,
        Dict(1 => 0.111898, 8 => 0.888102),
    ),

    # Gammex phantom materials
    gammex_water = Material(
        "Gammex Solid Water (Model 451 Org. CT)",
        0.54031,
        76.5eV,
        1.02g / cm^3,
        Dict(
            1  => 0.0839,  # H
            6  => 0.6859,  # C
            7  => 0.0219,  # N
            8  => 0.1840,  # O
            16 => 0.0003,  # S
            17 => 0.0014,  # Cl
            20 => 0.0226,  # Ca
        ),
    ),
    gammex_lung_inhale = Material(
        "Gammex Lung (Inhale)",
        0.54552,
        70.0eV,
        0.20g / cm^3,
        Dict(1 => 0.086840, 6 => 0.604530, 7 => 0.016590, 8 => 0.175640, 12 => 0.116400),
    ),
    gammex_lung_exhale = Material(
        "Gammex Lung (Exhale)",
        0.54552,
        70.0eV,
        0.50g / cm^3,
        Dict(1 => 0.086840, 6 => 0.604530, 7 => 0.016590, 8 => 0.175640, 12 => 0.116400),
    ),
    gammex_adipose = Material(
        "Gammex Adipose",
        0.55590,
        63.2eV,
        0.96g / cm^3,
        Dict(1 => 0.099570, 6 => 0.713320, 7 => 0.019890, 8 => 0.167220),
    ),
    gammex_breast = Material(
        "Gammex Breast (50% Gland)",
        0.54932,
        70.0eV,
        0.99g / cm^3,
        Dict(1 => 0.097260, 6 => 0.694230, 7 => 0.020230, 8 => 0.183260, 17 => 0.005020),
    ),
    gammex_muscle = Material(
        "Gammex Muscle",
        0.54868,
        75.3eV,
        1.05g / cm^3,
        Dict(1 => 0.091780, 6 => 0.694920, 7 => 0.019800, 8 => 0.167830, 17 => 0.025670),
    ),
    gammex_liver = Material(
        "Gammex Liver",
        0.54934,
        72.5eV,
        1.07g / cm^3,
        Dict(1 => 0.089820, 6 => 0.711000, 7 => 0.019380, 8 => 0.166090, 17 => 0.013710),
    ),
    gammex_brain = Material(
        "Gammex Brain",
        0.55000,
        73.3eV,
        1.05g / cm^3,
        Dict(1 => 0.090680, 6 => 0.696630, 7 => 0.012560, 8 => 0.191820, 17 => 0.008310),
    ),

    # ========================================================================
    # Gammex 472 CT Phantom Materials (Iodine Inserts)
    # ========================================================================
    gammex_472_i2_0 = Material(
        "Gammex 472 (2.0 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.03g / cm^3,
        Dict(
            1  => 0.0864, # H
            6  => 0.6953, # C
            7  => 0.0215, # N
            8  => 0.1751, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0181, # Ca
            53 => 0.0020, # I
        ),
    ),
    gammex_472_i2_5 = Material(
        "Gammex 472 (2.5 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.03g / cm^3,
        Dict(
            1  => 0.0863, # H
            6  => 0.6950, # C
            7  => 0.0214, # N
            8  => 0.1750, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0181, # Ca
            53 => 0.0025, # I
        ),
    ),
    gammex_472_i5_0 = Material(
        "Gammex 472 (5.0 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.03g / cm^3,
        Dict(
            1  => 0.0861, # H
            6  => 0.6937, # C
            7  => 0.0214, # N
            8  => 0.1743, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0181, # Ca
            53 => 0.0049, # I
        ),
    ),
    gammex_472_i7_5 = Material(
        "Gammex 472 (7.5 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.03g / cm^3,
        Dict(
            1  => 0.0859, # H
            6  => 0.6924, # C
            7  => 0.0213, # N
            8  => 0.1736, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0180, # Ca
            53 => 0.0073, # I
        ),
    ),
    gammex_472_i10_0 = Material(
        "Gammex 472 (10.0 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.03g / cm^3,
        Dict(
            1  => 0.0856, # H
            6  => 0.6911, # C
            7  => 0.0212, # N
            8  => 0.1729, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0179, # Ca
            53 => 0.0097, # I
        ),
    ),
    gammex_472_i15_0 = Material(
        "Gammex 472 (15.0 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.03g / cm^3,
        Dict(
            1  => 0.0851, # H
            6  => 0.6885, # C
            7  => 0.0210, # N
            8  => 0.1715, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0178, # Ca
            53 => 0.0146, # I
        ),
    ),
    gammex_472_i20_0 = Material(
        "Gammex 472 (20.0 mg/ml Iodine)",
        0.0,
        0.0eV,
        1.04g / cm^3,
        Dict(
            1  => 0.0846, # H
            6  => 0.6859, # C
            7  => 0.0209, # N
            8  => 0.1701, # O
            16 => 0.0003, # S
            17 => 0.0013, # Cl
            20 => 0.0176, # Ca
            53 => 0.0194, # I
        ),
    ),

    # ========================================================================
    # Gammex 472 CT Phantom Materials (Calcium Inserts)
    # ========================================================================
    gammex_472_ca50_0 = Material(
        "Gammex 472 (50.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        1.17g / cm^3,
        Dict(
            1  => 0.0710, # H
            6  => 0.6266, # C
            7  => 0.0270, # N
            8  => 0.2308, # O
            16 => 0.0007, # S
            17 => 0.0012, # Cl
            20 => 0.0427, # Ca
        ),
    ),
    gammex_472_ca100_0 = Material(
        "Gammex 472 (100.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        1.24g / cm^3,
        Dict(
            1  => 0.0635, # H
            6  => 0.5720, # C
            7  => 0.0241, # N
            8  => 0.2579, # O
            16 => 0.0012, # S
            17 => 0.0010, # Cl
            20 => 0.0802, # Ca
        ),
    ),
    gammex_472_ca200_0 = Material(
        "Gammex 472 (200.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        1.40g / cm^3,
        Dict(
            1  => 0.0509, # H
            6  => 0.4806, # C
            7  => 0.0193, # N
            8  => 0.3031, # O
            16 => 0.0022, # S
            17 => 0.0008, # Cl
            20 => 0.1431, # Ca
        ),
    ),
    gammex_472_ca300_0 = Material(
        "Gammex 472 (300.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        1.55g / cm^3,
        Dict(
            1  => 0.0408, # H
            6  => 0.4070, # C
            7  => 0.0154, # N
            8  => 0.3396, # O
            16 => 0.0030, # S
            17 => 0.0007, # Cl
            20 => 0.1936, # Ca
        ),
    ),
    gammex_472_ca400_0 = Material(
        "Gammex 472 (400.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        1.70g / cm^3,
        Dict(
            1  => 0.0325, # H
            6  => 0.3465, # C
            7  => 0.0121, # N
            8  => 0.3695, # O
            16 => 0.0036, # S
            17 => 0.0005, # Cl
            20 => 0.2352, # Ca
        ),
    ),
    gammex_472_ca500_0 = Material(
        "Gammex 472 (500.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        1.85g / cm^3,
        Dict(
            1  => 0.0256, # H
            6  => 0.2958, # C
            7  => 0.0095, # N
            8  => 0.3946, # O
            16 => 0.0041, # S
            17 => 0.0004, # Cl
            20 => 0.2700, # Ca
        ),
    ),
    gammex_472_ca600_0 = Material(
        "Gammex 472 (600.0 mg/ml Calcium)",
        0.0,
        0.0eV,
        2.01g / cm^3,
        Dict(
            1  => 0.0196, # H
            6  => 0.2525, # C
            7  => 0.0072, # N
            8  => 0.4161, # O
            16 => 0.0046, # S
            17 => 0.0003, # Cl
            20 => 0.2998, # Ca
        ),
    ),

    # ========================================================================
    # Gammex 472 CT Phantom Materials (Solid Water Reference Rod)
    # Source: Gammex TMM Nominal Characteristics 2016-03-10
    # Model 451 Org. CT Solid Water (ρ=1.02 g/cm³, ρe=0.99)
    # ========================================================================
    gammex_472_solidwater = Material(
        "Gammex 472 Solid Water (Model 451)",
        0.0,
        0.0eV,
        1.02g / cm^3,
        Dict(
            1  => 0.0839, # H
            6  => 0.6859, # C
            7  => 0.0219, # N
            8  => 0.1840, # O
            16 => 0.0003, # S
            17 => 0.0014, # Cl
            20 => 0.0226, # Ca
        ),
    ),

    # ========================================================================
    # Additional Common Materials
    # ========================================================================
    graphite = Material(
        "Graphite (Carbon)",
        0.49954,
        78.0eV,
        1.70g / cm^3,
        Dict(6 => 1.0),
    ),
    diamond = Material(
        "Diamond",
        0.49954,
        78.0eV,
        3.52g / cm^3,
        Dict(6 => 1.0),
    ),
    bone_ite = Material(
        "BoneIte (ICRU)",
        0.51478,
        106.4eV,
        1.85g / cm^3,
        Dict(
            1 => 0.063984,
            6 => 0.278000,
            7 => 0.027000,
            8 => 0.410016,
            12 => 0.002000,
            15 => 0.070000,
            16 => 0.002000,
            20 => 0.147000,
        ),
    ),
    trabecular_bone = Material(
        "Trabecular Bone (Spongiosa)",
        0.53100,
        85.0eV,
        1.18g / cm^3,
        Dict(
            1 => 0.085000,
            6 => 0.404000,
            7 => 0.028000,
            8 => 0.367000,
            11 => 0.001000,
            12 => 0.001000,
            15 => 0.034000,
            16 => 0.002000,
            17 => 0.001000,
            19 => 0.001000,
            20 => 0.076000,
        ),
    ),
    tooth_enamel = Material(
        "Tooth Enamel",
        0.49740,
        130.0eV,
        2.89g / cm^3,
        Dict(1 => 0.009500, 6 => 0.001100, 7 => 0.003200, 8 => 0.428000, 12 => 0.005500, 15 => 0.178600, 20 => 0.362000, 30 => 0.012100),
    ),
    tooth_dentin = Material(
        "Tooth Dentin",
        0.50220,
        110.0eV,
        2.14g / cm^3,
        Dict(1 => 0.027500, 6 => 0.127000, 7 => 0.042500, 8 => 0.418000, 12 => 0.008000, 15 => 0.112000, 20 => 0.265000),
    ),
    cerebrospinal_fluid = Material(
        "Cerebrospinal Fluid",
        0.55200,
        75.0eV,
        1.01g / cm^3,
        Dict(1 => 0.110000, 6 => 0.004000, 7 => 0.001000, 8 => 0.876000, 11 => 0.003000, 15 => 0.001000, 17 => 0.004000, 19 => 0.001000),
    ),
    vitreous_humor = Material(
        "Vitreous Humor",
        0.55400,
        75.0eV,
        1.01g / cm^3,
        Dict(1 => 0.110000, 8 => 0.881000, 11 => 0.003000, 17 => 0.003000, 19 => 0.003000),
    ),
    bile = Material(
        "Bile",
        0.55000,
        75.0eV,
        1.03g / cm^3,
        Dict(1 => 0.108000, 6 => 0.061000, 7 => 0.008000, 8 => 0.806000, 11 => 0.004000, 17 => 0.011000, 19 => 0.002000),
    ),
    urine = Material(
        "Urine",
        0.55300,
        75.0eV,
        1.02g / cm^3,
        Dict(1 => 0.108000, 6 => 0.006000, 7 => 0.010000, 8 => 0.861000, 11 => 0.004000, 15 => 0.004000, 17 => 0.005000, 19 => 0.002000),
    ),
    feces = Material(
        "Feces",
        0.54000,
        70.0eV,
        1.05g / cm^3,
        Dict(1 => 0.100000, 6 => 0.200000, 7 => 0.020000, 8 => 0.660000, 11 => 0.003000, 15 => 0.005000, 17 => 0.005000, 19 => 0.007000),
    ),
    mucus = Material(
        "Mucus",
        0.55000,
        75.0eV,
        1.01g / cm^3,
        Dict(1 => 0.105000, 6 => 0.050000, 7 => 0.015000, 8 => 0.818000, 11 => 0.004000, 17 => 0.005000, 19 => 0.003000),
    ),
    synovial_fluid = Material(
        "Synovial Fluid",
        0.55100,
        75.0eV,
        1.01g / cm^3,
        Dict(1 => 0.108000, 6 => 0.030000, 7 => 0.005000, 8 => 0.845000, 11 => 0.003000, 17 => 0.005000, 19 => 0.004000),
    ),
    salt_water = Material(
        "Salt Water (3.5% NaCl)",
        0.54800,
        75.0eV,
        1.025g / cm^3,
        Dict(1 => 0.108000, 8 => 0.857200, 11 => 0.013800, 17 => 0.021000),
    ),
    ethanol = Material(
        "Ethanol (C2H5OH)",
        0.56437,
        62.9eV,
        0.789g / cm^3,
        Dict(1 => 0.131269, 6 => 0.521438, 8 => 0.347294),
    ),
    methanol = Material(
        "Methanol (CH3OH)",
        0.56246,
        67.6eV,
        0.791g / cm^3,
        Dict(1 => 0.125822, 6 => 0.374852, 8 => 0.499326),
    ),
    glycerol = Material(
        "Glycerol (C3H8O3)",
        0.54929,
        72.6eV,
        1.261g / cm^3,
        Dict(1 => 0.087554, 6 => 0.391262, 8 => 0.521185),
    ),
    formaldehyde = Material(
        "Formaldehyde (CH2O)",
        0.53333,
        70.6eV,
        0.815g / cm^3,
        Dict(1 => 0.067135, 6 => 0.400017, 8 => 0.532848),
    ),
    acetic_acid = Material(
        "Acetic Acid (CH3COOH)",
        0.54220,
        67.0eV,
        1.049g / cm^3,
        Dict(1 => 0.067549, 6 => 0.399931, 8 => 0.532521),
    ),
)
