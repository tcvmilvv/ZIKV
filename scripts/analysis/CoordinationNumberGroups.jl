############################################################################################
#   Example script for calculating the coordination number of chains K, M, and O divided   #
#        into groups with respect to the solvent (WT4) in a coarse-grained                 #
#                              molecular dynamics simulation                               #
############################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the correct PDB file and define custom SIRAH elements/residues.
# Skipping these steps may cause errors or invalid results.

# Step 1: Define the solute, solute groups and solvent selections
protein = select(ats, "chain K or chain M or chain O")

solute = AtomSelection(protein,
    nmols = 1,
    group_atom_indices = [
        findall(Select("chain K"), ats),
        findall(Select("chain M"), ats),
        findall(Select("chain O"), ats),
    ],
    group_names = [ "K", "M", "O" ]
  )
solvent = AtomSelection(select(ats, "resname WT4"), 
    natomspermol=4)

# Step 2: Load the trajectory file
trajectory = Trajectory(
    "./zikv_reduced_trajectory_50frames.xtc",
    solute,
    solvent
)

# Step 3: Set options for coordination number calculation
options = Options(bulk_range=(8.0, 12.0))

# Step 4: Calculate the coordination number
r = coordination_number(trajectory, options)

# Step 5: Save the results as a JSON file
save("./kmo_groups_wt4.json", r)