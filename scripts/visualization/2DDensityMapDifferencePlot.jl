#########################################################################################
# Example script for calculating and plotting the difference in residue contributions    #
# between chains K and M with respect to the solvent (WT4) in a coarse-grained           #
# molecular dynamics simulation.#
#########################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the correct data files containing the residue contributions for chains K and M.
# Skipping these steps may cause errors or invalid results.

# Step 1: Load the residue contributions for chains K and M
r1 = load("./rc_k_wt4.json", ResidueContributions)
r2 = load("./rc_m_wt4.json", ResidueContributions)

# Step 2: Calculate the difference in residue contributions between chains M and K
rc_diff = r2 - r1

# Step 3: Generate contour plots for the differences in residue contributions
p1 = contourf(rc_diff[1:100], oneletter=true)
p2 = contourf(rc_diff[101:200], oneletter=true)
p3 = contourf(rc_diff[201:300], oneletter=true)
p4 = contourf(rc_diff[301:400], oneletter=true)
p5 = contourf(rc_diff[401:501], oneletter=true)

# Step 4: Combine the contour plots into one figure and customize layout
plot_all = plot(
    p1, p2, p3, p4, p5,
    clims=(-0.2,0.2)
    xlabel="Residues",
    ylabel=L"r/ \AA",
    colorbar=:left,
    leftmargin = 0.7Plots.Measures.cm,
    bottommargin = 0.7Plots.Measures.cm,
    size=(1800,1200),
    layout=(5,1)
    )

# Step 5: Save the figure as an SVG file
savefig("./k_m_wt4.svg")