#########################################################################################
#  Example script for generating 2D Density Maps of residue contributions for chains K, #
#   M, and O with respect to the solvent (WT4) in a coarse-grained molecular dynamics   #
#                                     simulation.                                       #
#########################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the Residue Contribution JSON file.
# Skipping these steps may cause errors or invalid results.

# Step 1: Load the Residue Contribution JSON file
rc = load("./rc_k_wt4", ResidueContributions)

# Step 2: Generate contour plots for the first 501 residues, split into 5 parts
p1 = contourf(rc[1:100], oneletter=true, color=:BuPu)
p2 = contourf(rc[101:200], oneletter=true, color=:BuPu)
p3 = contourf(rc[201:300], oneletter=true, color=:BuPu)
p4 = contourf(rc[301:400], oneletter=true, color=:BuPu)
p5 = contourf(rc[401:501], oneletter=true, color=:BuPu)

# Step 3: Combine all the generated plots into one figure with proper labels, margins, and color settings
plot_all = plot(
    p1, p2, p3, p4, p5,
    clims=(0,5.5), 
    xlabel="Residues",
    ylabel=L"r/ \AA",
    colorbar=:left,
    leftmargin = 0.7Plots.Measures.cm,
    bottommargin = 0.7Plots.Measures.cm,
    size=(1800,1200),
    layout=(5,1)
    )

# Step 4: Save the generated figure to a file in SVG format
savefig("./k_wt4.svg")