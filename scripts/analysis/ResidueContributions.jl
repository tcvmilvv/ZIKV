#######################################################################################
#        Example script for calculating the residue contributions of chains K         #
# with respect to the solvent (WT4) in a coarse-grained molecular dynamics simulation #
#######################################################################################

# WARNING: The following steps are essential for the script to run correctly:
# 1. Activate the environment with Pkg.activate(".").
# 2. Ensure all required packages are installed and loaded.
# 3. Load the Coordination Number JSON file.
# Skipping these steps may cause errors or invalid results.

# Step 1: Load the Coordination Number JSON file
r = load("./kmo_wt4.json")

# Step 2: Select residues from chain K, segment S1
chaink = select(ats, "chain K and segname S1")

# Step 3: Calculate the initial residue contributions for segment S1
rc = ResidueContributions(r, chaink; dmin=3, dmax=8, type=:coordination_number)

# Step 4: Loop through segments S2 to S60 and compute total residue contributions
for iseg in 2:60
    # Select residues for the current chain
    chain_selection = select(ats, "chain K and segname S$iseg")
    
    # Calculate the residue contributions for the current chain
    rc_i = ResidueContributions(r, chain_selection; dmin=3, dmax=8, type=:coordination_number)
    
    # Sum up the contributions
    rc += rc_i
end

# Step 5: Average the residue contributions over all chains K
rc = rc/60

# Step 6: Save the contributions per residue as a JSON file
save("./rc_k_wt4", rc)