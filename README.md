# Snakemake workflow for Loxodes genomics project

Snakefiles and Conda environment definition files for the Loxodes genomics 
project.

These files should reside in a subfolder `workflow` of the main storage project. 
The Snakemake pipeline is called from there, so the paths in Snakemake rules are 
relative to the enclosing folder.

The main Snakefile is called `Snakefile`, and rules for discrete tasks are 
organized into separate Snakefiles that are included in the main Snakefile. This 
is to limit the size of individual Snakefiles to make them less unwieldy.
