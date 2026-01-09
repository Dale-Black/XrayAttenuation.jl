# ============================================================================
# Interpolation for XCOM Data
# ============================================================================

using Interpolations

# Cache for interpolators to avoid recreating them
const INTERPOLATOR_CACHE = Dict{Tuple{Int, Symbol}, Any}()

# K-edge energies in MeV for elements Z=3 to Z=92
# K-edges cause discontinuities in attenuation coefficients
const K_EDGES_MEV = Dict{Int, Float64}(
    3 => 5.5e-5, 4 => 1.12e-4, 5 => 1.88e-4, 6 => 2.84e-4, 7 => 4.10e-4,
    8 => 5.32e-4, 9 => 6.86e-4, 10 => 8.67e-4, 11 => 1.072e-3, 12 => 1.305e-3,
    13 => 1.560e-3, 14 => 1.839e-3, 15 => 2.146e-3, 16 => 2.472e-3, 17 => 2.822e-3,
    18 => 3.206e-3, 19 => 3.608e-3, 20 => 4.038e-3, 21 => 4.493e-3, 22 => 4.966e-3,
    23 => 5.465e-3, 24 => 5.989e-3, 25 => 6.539e-3, 26 => 7.112e-3, 27 => 7.709e-3,
    28 => 8.333e-3, 29 => 8.979e-3, 30 => 9.659e-3, 31 => 10.367e-3, 32 => 11.103e-3,
    33 => 11.867e-3, 34 => 12.658e-3, 35 => 13.474e-3, 36 => 14.326e-3, 37 => 15.200e-3,
    38 => 16.105e-3, 39 => 17.038e-3, 40 => 17.998e-3, 41 => 18.986e-3, 42 => 20.000e-3,
    43 => 21.044e-3, 44 => 22.117e-3, 45 => 23.220e-3, 46 => 24.350e-3, 47 => 25.514e-3,
    48 => 26.711e-3, 49 => 27.940e-3, 50 => 29.200e-3, 51 => 30.491e-3, 52 => 31.814e-3,
    53 => 33.169e-3, 54 => 34.561e-3, 55 => 35.985e-3, 56 => 37.441e-3, 57 => 38.925e-3,
    58 => 40.443e-3, 59 => 41.991e-3, 60 => 43.569e-3, 61 => 45.184e-3, 62 => 46.834e-3,
    63 => 48.519e-3, 64 => 50.239e-3, 65 => 51.996e-3, 66 => 53.789e-3, 67 => 55.618e-3,
    68 => 57.486e-3, 69 => 59.390e-3, 70 => 61.332e-3, 71 => 63.314e-3, 72 => 65.351e-3,
    73 => 67.416e-3, 74 => 69.525e-3, 75 => 71.676e-3, 76 => 73.871e-3, 77 => 76.111e-3,
    78 => 78.395e-3, 79 => 80.725e-3, 80 => 83.102e-3, 81 => 85.530e-3, 82 => 88.005e-3,
    83 => 90.526e-3, 84 => 93.105e-3, 85 => 95.730e-3, 86 => 98.404e-3, 87 => 101.137e-3,
    88 => 103.922e-3, 89 => 106.755e-3, 90 => 109.651e-3, 91 => 112.601e-3, 92 => 115.606e-3
)

# Cache for K-edge indices in the energy grid
const K_EDGE_INDICES = Dict{Int, Int}()

"""
    get_kedge_index(Z::Int)

Get the index of the K-edge energy in the XCOM_ENERGIES_MEV array for element Z.
Returns nothing if Z < 3 or K-edge not found.
"""
function get_kedge_index(Z::Int)
    if haskey(K_EDGE_INDICES, Z)
        return K_EDGE_INDICES[Z]
    end

    if !haskey(K_EDGES_MEV, Z)
        return nothing
    end

    kedge = K_EDGES_MEV[Z]
    idx = findfirst(e -> abs(e - kedge) / kedge < 0.001, XCOM_ENERGIES_MEV)
    if idx !== nothing
        K_EDGE_INDICES[Z] = idx
    end
    return idx
end

"""
    get_interpolator(Z::Int, attenuation_type::Symbol)

Get or create an interpolator for the given element and attenuation type.
Uses log-log interpolation for better accuracy across wide energy ranges.
"""
function get_interpolator(Z::Int, attenuation_type::Symbol)
    key = (Z, attenuation_type)

    if haskey(INTERPOLATOR_CACHE, key)
        return INTERPOLATOR_CACHE[key]
    end

    if !haskey(XCOM_ELEMENT_DATA, Z)
        error("No XCOM data available for element Z=$Z")
    end

    data = XCOM_ELEMENT_DATA[Z]
    energies = XCOM_ENERGIES_MEV

    # Get the appropriate data column
    values = getfield(data, attenuation_type)

    if length(values) != length(energies)
        error("Data length mismatch for Z=$Z, type=$attenuation_type")
    end

    # Use log-log interpolation for better accuracy
    # Replace zeros with small values to avoid log(0)
    log_energies = log.(energies)
    log_values = log.(max.(values, 1e-30))

    # Create linear interpolation in log-log space
    itp = interpolate((log_energies,), log_values, Gridded(Linear()))

    # Extrapolate for energies outside the grid
    itp_extrap = extrapolate(itp, Line())

    INTERPOLATOR_CACHE[key] = itp_extrap
    return itp_extrap
end

"""
    interpolate_attenuation(Z::Int, energy_MeV::Real, attenuation_type::Symbol)

Interpolate mass attenuation coefficient for element Z at given energy.
Returns value in cm^2/g.

Handles K-edge discontinuities: For energies below a K-edge, the below-edge
value is used. For energies at or above a K-edge, the above-edge value is used.
"""
function interpolate_attenuation(Z::Int, energy_MeV::Real, attenuation_type::Symbol)
    kedge_idx = get_kedge_index(Z)
    energies = XCOM_ENERGIES_MEV

    # Check if we need special K-edge handling
    if kedge_idx !== nothing && Z >= 3
        kedge_energy = K_EDGES_MEV[Z]

        # If query is below K-edge, interpolate using only points below K-edge
        if energy_MeV < kedge_energy
            # Find the bracketing indices below K-edge
            idx = searchsortedlast(energies, energy_MeV)
            if idx < 1
                idx = 1
            end

            # Make sure we don't cross the K-edge
            if idx >= kedge_idx
                idx = kedge_idx - 1
            end

            # Get data values
            data = XCOM_ELEMENT_DATA[Z]
            values = getfield(data, attenuation_type)

            # Use two points below the K-edge for interpolation
            if idx >= 2
                e1, e2 = energies[idx-1], energies[idx]
                v1, v2 = values[idx-1], values[idx]

                # Log-log interpolation
                log_e = log(energy_MeV)
                log_e1, log_e2 = log(e1), log(e2)
                log_v1, log_v2 = log(max(v1, 1e-30)), log(max(v2, 1e-30))

                t = (log_e - log_e1) / (log_e2 - log_e1)
                log_result = log_v1 + t * (log_v2 - log_v1)
                return exp(log_result)
            elseif idx == 1
                return max(values[1], 1e-30)
            end
        end
    end

    # Standard interpolation for energies at or above K-edge (or no K-edge)
    itp = get_interpolator(Z, attenuation_type)
    log_result = itp(log(energy_MeV))
    return exp(log_result)
end

"""
    clear_interpolator_cache!()

Clear the interpolator cache to free memory.
"""
function clear_interpolator_cache!()
    empty!(INTERPOLATOR_CACHE)
    empty!(K_EDGE_INDICES)
end
