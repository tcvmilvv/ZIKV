#########################################################################################
#   Example script for plotting the coordination number of chains K, M, and O divided   #
#   into groups with respect to the solvent (WT4) from residue contribution data in a   #
#                       coarse-grained molecular dynamics simulation                    #
#########################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the Coordination Number JSON file.
# Skipping these steps may cause errors or invalid results.

# Step 1: Load the Coordination Number JSON file
r = load("./kmo_groups_wt4.json")

# Step 2: Plot the total coordination number
plot!(
    r.d, coordination_number(r),
    label="Total",
    )

# Step 3: Plot coordination number for chain K
plot!(
    r.d, coordination_number(r, SoluteGroup("K")),
    label="Chain K",
    )

# Step 4: Plot coordination number for chain M
plot!(
    r.d, coordination_number(r, SoluteGroup("M")),
    label="Chain M",
    )

# Step 5: Plot coordination number for chain O
plot!(
    r.d, coordination_number(r, SoluteGroup("O")),
    label="Chain O",
    )

# Step 6: Customize the plot with labels and transparent background
plot!(
    ylabel="Coordination Number",
    xlabel=L"r / \AA",
    titlelocation=:left
    )

# Step 7: Save the figure as an SVG file
savefig("./coordination_number_kmo_wt4.svg")
