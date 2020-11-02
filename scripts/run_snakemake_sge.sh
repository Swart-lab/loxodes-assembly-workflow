#!/bin/bash

# Script containing boilerplate for running snakemake_sge.sh
# Specify additional parameters (e.g. --dryrun) and rule names 
# after invoking this script 

# snakemake_sge.sh should be in path
# snakemake conda environment should be activated

# Use snakemake_sge.sh to run on cluster
# submit 16 jobs at a time
snakemake_sge.sh \
workflow/config.yaml \
workflow/cluster.json \
logs_SGE \
16 \
--use-conda \
--printshellcmds \
--conda-prefix envs \
-s workflow/Snakefile $@
