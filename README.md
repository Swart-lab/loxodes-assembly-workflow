# Snakemake workflow for Loxodes genomics project

Snakefiles and Conda environment definition files for the Loxodes genomics 
project. The top level Readme for this project is `README_root.md`, which
documents the folder structure of the main storage project folder.

These files should reside in a subfolder `workflow` of the main storage project. 
The Snakemake pipeline is called from there, so the paths in Snakemake rules are 
relative to the enclosing folder.

The main Snakefile is called `Snakefile`, and rules for discrete tasks are 
organized into separate Snakefiles that are included in the main Snakefile. This 
is to limit the size of individual Snakefiles to make them less unwieldy.

Some steps, e.g. assembly with Falcon, were not included as Snakefiles because
these require manual intervention or checking between steps, not suitable for
automation. For purposes of version control the scripts responsible are
included in the `scripts/` subfolder, and documented with READMEs in each
folder.
