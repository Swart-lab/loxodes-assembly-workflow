Loxodes genomics project
========================

This folder contains genome sequencing and assembly data for _Loxodes_ ciliates.

Each subfolder should have a Readme describing its contents. Code and
documentation subfolders are tracked by git.

Project folder contents
-----------------------

### Git repositories
 * `workflow/` - Snakemake pipelines for preprocessing and QC of data
 * `code/` - Custom scripts and code developed for this project
 * `doc/` - Documentation including metadata for read data

### Data and software
 * `data/` - Primary raw data, e.g. sequence read libraries. Most of the large
             data files are symlinked from the `ag-swart-loxodes-raw` storage
             project. Folder also contains intermediate processed files (e.g.
             trimmed or reformatted reads); such folders are not backed up.
 * `assembly/` - Genome and transcriptome assemblies
 * `db/` - Databases used for analysis
 * `envs/` - Conda environments, including those for Snakemake pipeline
 * `opt/` - Third-party software that is not installed via Conda, some are git
            repos. These are documented in `additional_dependencies.md`.
 * `qsub_scripts/` - Scripts for ad hoc tasks

### Analyses and results
 * `annotation/` - Annotation of assembled sequences
 * `analysis/` - Data analysis. Each subfolder is a separate analysis subproject
    and should be documented with a Readme or Jupyter notebook

### Others
 * `tmp/` - Intermediate files that do not need to be backed up
 * `logs/` - Log files from preprocessing and QC steps
 * `logs_SGE/` - Log files from SGE

Using Snakemake workflow
------------------------

The Snakemake workflow is primarily used to manage preprocessing tasks, e.g.
read QC and trimming. To call the workflow you will need to specify the relevant
config files, and use the `snakemake_sge.sh` script to manage job submission to
the MPIEB cluster. 

The script `run_snakemake_sge.sh` contains the setup used here. Assumes that
`snakemake` and `snakemake_sge.sh` are in the path.

To run the workflow on a single machine (e.g. the `dal` server), use
`run_snakemake_dal.sh`.

Both these `run_snakemake` scripts are in `workflow/scripts` and are symlinked
in the storage project root.

### Example Snakemake command line

```
# snakemake conda environment should be activated

snakemake --dryrun \
--reason \
--use-conda \
--printshellcmds \
--conda-prefix envs \
--configfile workflow/config.yaml \
-s workflow/Snakefile \
RULENAME
```

If using on a cluster, in this example submitting 16 jobs at a time:

```
snakemake_sge.sh \
workflow/config.yaml \
workflow/cluster.json \
logs_SGE \
16 \
--dryrun \
--use-conda \
--printshellcmds \
--conda-prefix envs \
-s workflow/Snakefile \
RULENAME
```


Contact
-------

 * [Brandon Seah](mailto:kb.seah@tuebingen.mpg.de)
 * [Estienne Swart](mailto:estienne.swart@tuebingen.mpg.de)
