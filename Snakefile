include: "snakefiles/snakefile-reads-assembly-spades"
include: "snakefiles/snakefile-reads-assembly-megahit"
include: "snakefiles/snakefile-reads-assembly-spades-qc"
include: "snakefiles/snakefile-reads-assembly-megahit-qc"
include: "snakefiles/snakefile-reads-assembly-qc"
include: "snakefiles/snakefile-reads-preprocess-qc"
include: "snakefiles/snakefile-pb-assembly-flye"
include: "snakefiles/snakefile-reads-rnaseq-preprocess-qc"
include: "snakefiles/snakefile-reads-rnaseq-assembly"

rule annotation_flye_comb:
    input:
        expand("annotation/flye-comb_{sp}/flye-comb_{sp}.{output_type}",
                sp=['LmagMAC','LmagMIC'],
                output_type=['gbtquick.blobplot.png','gbtquick.covstats.tsv']),

rule annotation_megahit_comb:
    input:
        expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.{output_type}",
               sp=config['species'],
               qtrimvals=[28],
               output_type=['bin_cds50_gc40.fasta','gbtquick.blobplot.png','gbtquick.covstats.tsv']),
        expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.barrnap.{kingdom}.gff",
               sp=config['species'],
               qtrimvals=[28],
               kingdom=config['barrnap_kingdoms']),

rule annotation_spades_comb:
    # Annotate each combined metagenomic assembly
    input:
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.{output_type}",
               sp=config['species'],
               qtrimvals=[28],
               output_type=['bin_cds50_gc40.fasta','gbtquick.blobplot.png','gbtquick.covstats.tsv']),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.barrnap.{kingdom}.gff",
               sp=config['species'],
               qtrimvals=[28],
               kingdom=config['barrnap_kingdoms']),

rule annotation_spades_sc:
    # Annotate each single-cell MDA assembly
    input:
        expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.{output_type}",
               lib=config['libraries_sc'],
               qtrimvals=config['qtrimvals'],
               output_type=['gbtquick.blobplot.png','gbtquick.covstats.tsv','bin_cds50_gc40.fasta']),

rule latest_assemblies:
    # symlink latest versions of all the target assemblies
    input:
        # single-cell assemblies
        expand("assembly/latest/spades-sc_{lib_sc}_q{qtrimvals}.{output_type}",
               lib_sc=config["libraries_sc"],
               qtrimvals=config["qtrimvals"],
               output_type=['scaffolds.fasta','assembly_graph.fastg']),
        # Combined assemblies of all bulk metagenomic libraries per species
        expand("assembly/latest/{assembler}-comb_{sp}_q{qtrimvals}.{output_type}",
               assembler=['spades','megahit'],
               sp=config['species'],
               qtrimvals=[28],
               output_type=['scaffolds.fasta','assembly_graph.fastg']),
        # Combined assemblies of PacBio libraries per species
        expand("assembly/latest/flye-comb_{sp}.{output_type}",
                sp=['LmagMAC','LmagMIC'],
                output_type=['assembly.fasta','assembly_graph.gfa','assembly_graph.gv','assembly_info.txt']),
        # Combined assemblies of RNAseq libraries, combined by experiment
        expand("assembly/latest/trinity_rnaseq_{experiment}_nochlamy_comb.{output_type}",
               experiment=["exp146"],
               output_type=['Trinity.fasta','Trinity.fasta.gene_trans_map']),
        expand("assembly/latest/trinity_rnaseq_{experiment}_nochlamy_comb.mapped_{ref_params}.{output_type}",
                experiment=["exp146"],
                ref_params=['spades-comb_LmagMAC_q28'],
                output_type=['Trinity.fasta','Trinity.fasta.gene_trans_map']),

rule assembly_rnaseq:
    input:
        # Combined assemblies of RNAseq libraries, combined by experiment
        expand("assembly/trinity_rnaseq_{experiment}_nochlamy_comb/trinity_outdir/Trinity.fasta",
               experiment=["exp146"]),
        expand("assembly/trinity_rnaseq_{experiment}_nochlamy_comb.mapped_{ref_params}/trinity_outdir/Trinity.fasta",
                experiment=["exp146"],
                ref_params=['spades-comb_LmagMAC_q28','flye-comb_LmagMAC']),
        # expand("assembly/trinity_rnaseq_{experiment}_nochlamy_comb.gg_{ref_params}/trinity_outdir/Trinity.fasta",
        #         experiment=["exp146"],
        #         ref_params=['flye-comb_LmagMAC']),

rule assembly_illumina_sc: #todel
    input:
        # Individual assemblies of each single-cell MDA library
        expand("assembly/spades-sc_{lib_sc}_q{qtrimvals}/scaffolds.fasta",
               lib_sc=config["libraries_sc"],
               qtrimvals=config["qtrimvals"]),

rule assembly_illumina_comb: # todel
    input:
        # Combined assemblies of all bulk metagenomic libraries per species
        expand("assembly/{assembler}-comb_{sp}_q{qtrimvals}/scaffolds.fasta",
               assembler=['spades','megahit'],
               sp=config['species'],
               qtrimvals=[28]),
        expand("assembly/{assembler}-comb_{sp}_q{qtrimvals}/assembly_graph.fastg",
               assembler=['spades','megahit'],
               sp=config['species'],
               qtrimvals=[28])

rule assembly_flye_comb: # todel
    input:
        expand("assembly/flye-comb_{sp}/assembly.fasta",
                sp=['LmagMAC','LmagMIC'])

rule qc:
    input:
        expand("qc/phyloFlash/{lib}.phyloFlash.tar.gz",lib=config["libraries"])

rule rnaseq_qc:
    input:
        expand("qc/phyloFlash_rnaseq/{lib}.phyloFlash.tar.gz",lib=config["libraries_rnaseq"])

rule rnaseq_filter:
    input:
        expand("data/reads-rnaseq-filter/{lib}_R12_ktrim_qtrim{qtrimvals}_bbmap_nochlamy.R12.fq.gz",lib=config["libraries_rnaseq"],qtrimvals=[28])
