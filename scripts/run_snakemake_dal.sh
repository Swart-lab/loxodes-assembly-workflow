#!/bin/bash

# Script containing boilerplate for running snakemake_sge.sh
# Specify additional parameters (e.g. --dryrun) and rule names 
# after invoking this script 

# activate snakemake conda environment
source activate ./envs/snakemake

snakemake \
--cores 24 \
--configfile workflow/config.yaml \
--use-conda \
--printshellcmds \
--conda-prefix envs \
-s workflow/Snakefile $@
