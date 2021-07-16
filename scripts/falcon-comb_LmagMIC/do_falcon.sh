#!/bin/bash
set -e
# Perform Falcon assembly and Falcon Unzip
# for LmagMIC PacBio reads
# Run script from folder:
# /ebio/abt2_projects/ag-swart-loxodes/assembly/falcon-comb_LmagMIC

ENV=/ebio/abt2_projects/ag-swart-loxodes/envs/pb
THREADS=16
WD=/ebio/abt2_projects/ag-swart-loxodes/assembly/falcon-comb_LmagMIC

case "$1" in
  "reformat_fasta")
    # Reformat Fastq read files into Fasta format
    # Required as input for Falcon (listed in LmagMIC.fofn file)
    source activate bbmap
    mkdir -p reads_unzip
    touch reads_unzip/DO_NOT_BACKUP_THIS_FOLDER
    for i in /ebio/abt2_projects/ag-swart-loxodes/data/pb/{4777_B_HIFI.fastq.gz,4916_B_4777_B3_run540_CCS.fastq.gz,4916_B_HIFI.fastq.gz}; do
      echo $i
      FN=$(basename $i)
      PREFIX=reads_unzip/${FN%%.fastq.gz}
      echo $PREFIX
      reformat.sh threads=8 in=$i out=$PREFIX.fasta
    done
    ;;

  "falcon")
    # Falcon assembly - phase 0, 1, 2
    source activate $ENV
    fc_run.py fc_run_HiFi.cfg 2> fc_run_HiFi.log
    ;;

  "unzip_fastq")
    # Concatenate input files into unzipped Fastq format
    mkdir -p reads_fastq
    touch reads_fastq/DO_NOT_BACKUP_THIS_FOLDER
    source activate bbmap
    for i in /ebio/abt2_projects/ag-swart-loxodes/data/pb/{4777_B_HIFI.fastq.gz,4916_B_4777_B3_run540_CCS.fastq.gz,4916_B_HIFI.fastq.gz}; do
      echo $i
      pigz -p 8 -cd $i >> reads_fastq/LmagMIC.hifi.fastq
    done
    ;;

  "index_fastq")
    source activate bio-env
    samtools fqidx reads_fastq/LmagMIC.hifi.fastq
    ;;

  "falcon_unzip")
    # Unzip haplotypes
    source activate $ENV
    fc_unzip.py --target="ccs" fc_unzip_HiFi.cfg 2> fc_unzip_HiFi.log
    ;;

  "map_polish")
    # Map and polish initial assembly (not unzipped)
    source activate $ENV
    mkdir -p racon_polish_ccs
    REF=2-asm-falcon/p_ctg.fasta
    FQ=reads_fastq/LmagMIC.hifi.fastq
    ALN=racon_polish_ccs/LmagMIC_p_ctg.ccs.pbmm2.bam
    ALN2=racon_polish_ccs/LmagMIC_p_ctg.ccs.pbmm2.filter.sam
    POLISH_ASM=racon_polish_ccs/LmagMIC_p_ctg.racon_polish.fasta
    pbmm2 align --preset CCS --sort -j $THREADS \
      $REF $FQ $ALN
    samtools view -F 1796 -q 20 $ALN > $ALN2
    racon -u -t $THREADS $FQ $ALN2 $REF > $POLISH_ASM
    # Symlink polished assembly as main scaffolds.fasta file
    ln -sr $POLISH_ASM scaffolds.fasta
    ;;

  *)
    ############################################################################
    # Help message to display when script is run without arguments
    echo "Falcon assembly and Unzip for Loxodes magnus"
    echo ""
    echo "Subcommands:"
    echo "  reformat_fasta"
    echo "  falcon"
    echo "  unzip_fastq"
    echo "  index_fastq"
    echo "  falcon_unzip"
    echo "  map_polish"
    exit 1
esac
