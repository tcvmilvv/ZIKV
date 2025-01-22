#########################################################################################
# Example script for generating Hammer-Aitoff projections and plotting contour maps     #
#     of residue contributions in a coarse-grained molecular dynamics simulation.       #
#########################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the correct PDB file and define custom SIRAH elements/residues ("modified_zikv.pdb").
# Skipping these steps may cause errors or invalid results.

# Step 1: Selection of chain K, M, and O
protein = select(ats, "chain K or chain M or chain O")

#Step 2: Set clims
clims=(0,1)

# Step 2: Convert the Cartesian coordinates
x_hammer, y_hammer = hammer_aitoff_conversion(protein)

# Step 3: Generate Hammer-Aitoff projection and create the initial contour plot of residue contributions
xbin, ybin, cn_bins = hammer_aitoff_histogram(x_hammer, y_hammer, beta.(protein))

p1 = contourf(
    xbin, ybin, cn_bins;
    clims,
    label="",
    ticks=[],
    color=:BuPu,
    lw=0.0,
    levels=7
    )

# Step 4: Generate contours for chains K, M, O
for chain in ["K", "M", "O"]
    # Define contour values for each chain based on its residue contributions
    cont(x) = x == chain ? last(clims) : first(clims)
    cont_values = [cont(atom.chain) for atom in protein]
    
    # Create a separate histogram for each chain's residue contribution
    xbin_chain, ybin_chain, cn_bins_chain = hand_made_histogram(x_hammer, y_hammer, cont_values)
    
    # Add contour for the current chain to the plot
    contour!(p1, xbin_chain, ybin_chain, cn_bins_chain; color=:grey30, lw=0.5, levels=1, clims, label="", ticks=[])
end

# Step 5: Save the figure as an SVG file
savefig("./hammer_aitoff_k_wt4.svg")