## Scripts Directory

The `scripts/` directory contains example scripts designed to demonstrate how to perform the analyses and process the molecular dynamics data described in this work. These scripts serve as templates, allowing users to reproduce the results and customize inputs to suit their specific analysis needs. Each script is organized and annotated for clarity, ensuring ease of use and reproducibility.

## Contents
- **`analysis/`**: Scripts for analyzing trajectory data, calculating metrics like coordination number.
- **`visualization/`**: Scripts for plotting results.

> [!NOTE] Scripts are organized into subdirectories based on their functionality.

## Recommended workflow for reproducibility

This section outlines a step-by-step workflow designed to ensure reproducibility in the molecular dynamics analysis. Follow the steps below to reproduce the analysis and modify them as needed for your specific datasets or research goals.

```julia
# Activate the project environment
import Pkg; Pkg.activate(".")

# Load required packages
using ComplexMixtures
using PDBTools
using Plots
using LaTeXStrings

# Include external script for custom plotting functions
includet("/home/user/Documents/HammerAitoffConversion.jl")
includet("/home/user/Documents/HammerAitoffProjection.jl")
using .HammerAitoffProjection: hammer_aitoff_conversion, hammer_aitoff_histogram

# Set default plotting attributes for consistency
default(
    fontfamily = "Computer Modern",
    linewidth = 2,
    framestyle = :box,
    label = nothing,
    grid = false,
    titlefontsize = 9
)

# Define custom elements and residues
custom_elements!(SIRAH)
custom_protein_residues!(SIRAH)

# Load the PDB file
ats = readPDB("zikv_structure.pdb")
```