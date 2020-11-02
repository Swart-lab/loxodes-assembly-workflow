#!/bin/bash

# Script containing boilerplate for running snakemake_sge.sh
# Specify additional parameters (e.g. --dryrun) and rule names 
# after invoking this script 

# snakemake conda environment should be activated


snakemake \
--cores 48 \
--configfile workflow/config.yaml \
--use-conda \
--printshellcmds \
--conda-prefix envs \
-s workflow/Snakefile $@
