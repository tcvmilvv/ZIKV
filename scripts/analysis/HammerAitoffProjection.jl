#########################################################################################
#     Example script for converting Cartesian coordinates to spherical coordinates      #
# for chains K, M, and O in a coarse-grained molecular dynamics simulation, followed by #
#      performing a Hammer-Aitoff projection and generating a custom 2D histogram       #
#########################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the correct PDB file and define custom SIRAH elements/residues ("modified_zikv.pdb").
# Skipping these steps may cause errors or invalid results.

# Module for Hammer-Aitoff projection
module HammerAitoffProjection

# Function to perform the Hammer-Aitoff projection on a protein structure
function hammer_aitoff_conversion(protein)
    # Extract the coordinates
    x_coords = [atom.x for atom in protein]
    y_coords = [atom.y for atom in protein]
    z_coords = [atom.z for atom in protein]

    # Convert (x, y, z) to spherical coordinates (r, φ, λ)
    r = sqrt.(x_coords.^2 .+ y_coords.^2 .+ z_coords.^2)
    φ = asin.(z_coords ./ r)
    λ = atan.(y_coords, x_coords)

    # Apply Hammer-Aitoff projection
    z_hammer = sqrt.(1 .+ cos.(φ) .* cos.(λ ./ 2))
    x_hammer = 2 .* cos.(φ) .* sin.(λ ./ 2) ./ z_hammer
    y_hammer = sin.(φ) ./ z_hammer

    return x_hammer, y_hammer
end

# Custom histogram function to bin 2D data
function hammer_aitoff_histogram(x, y, values; nbins=100)
    # Initialize arrays for storing the bin centers and binned values
    xbin = zeros(nbins)
    ybin = zeros(nbins)
    cbins = zeros(nbins, nbins)

    # Calculate the range (min and max) of the x and y data
    xext = extrema(x)
    xlen = xext[2] - xext[1]
    yext = extrema(y)
    ylen = yext[2] - yext[1]

    # Loop over each bin for the x-axis
    for i in 1:nbins
        xmin = xext[1] + (i-1)*(xlen/nbins)
        xmax = xext[1] + i*(xlen/nbins)
        xbin[i] = (xmin + xmax) / 2

        # Loop over each bin for the y-axis
        for j in 1:nbins
            ymin = yext[1] + (j-1)*(ylen/nbins)
            ymax = yext[1] + j*(ylen/nbins)
            ybin[j] = (ymin + ymax) / 2

            # Variable to accumulate the sum of values in the bin
            cbin = 0.0
            # Counter for the number of values in the bin
            nvals = 0

            # Loop over all data points to check if they fall into the current bin
            for ival in eachindex(values)
                # Check if the value falls within the x and y bin ranges
                if (xmin <= x[ival] < xmax) && (ymin <= y[ival] < ymax)
                    cbin += values[ival]
                    nvals += 1
                end
            end

            # If there were values in the bin, calculate the average
            cbins[j, i] = nvals > 0 ? cbin / nvals : 0.0
        end
    end

    # Return the binned x, y coordinates and the corresponding binned values
    return xbin, ybin, cbins
end
end