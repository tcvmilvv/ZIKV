################################################################################################
# Example script for replacing the Beta column in a PDB file with residue contribution values, #
#   calculated for chain K with respect to the solvent (WT4) in a coarse-grained simulation.   #
################################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with `Pkg.activate(".")`.
# 2. Ensure all required packages are installed and loaded.
# 3. Load the Residue Contribution JSON file.
# Skipping these steps may cause errors or invalid results.

# Step 1: Load the residue contributions data
rc = load("./rc_k_wt4", ResidueContributions)

# Step 2: Define the distance threshold
d = 5.0

# Step 3: Find the index corresponding to the specified distance
id = findfirst(>=(d), rc.d)

# Step 4: Select all residues in chain K
chainsk = select(ats, "chain K")

# Step 5: Replace the Beta column with residue contribution values
for res in eachresidue(chainsk)
    for at in res
        at.beta = rc.residue_contributions[resnum(at)][id]
    end
end

# Step 6: Write the modified structure to a new PDB file
writePDB(ats, "modified_zikv.pdb")