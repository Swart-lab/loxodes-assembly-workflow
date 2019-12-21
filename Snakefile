include: "snakefile-reads-assembly-qc"
include: "snakefile-reads-assembly"
include: "snakefile-reads-preprocess-qc"
include: "snakefile-reads-rnaseq-preprocess-qc"

rule annotation_spades_comb:
    input:
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.scaffolds.covstats",
               sp=config['species'],
               qtrimvals=28),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
               sp=config['species'],
               qtrimvals=28,
               kingdom=config['barrnap_kingdoms']),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.{rrnagene}.nhmmer.out",
               sp=config['species'],
               rrnagene=config['ciliate_mt_rRNA'],
               qtrimvals=28),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.cds-dens.tsv",
               sp=config['species'],
               qtrimvals=28)

rule annotation_spades:
    input:
        expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.scaffolds.covstats",
               lib=config['libraries_mg'],
               qtrimvals=config['qtrimvals']),
        expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
               lib=config['libraries_mg'],
               qtrimvals=config['qtrimvals'],
               kingdom=config['barrnap_kingdoms']),
        expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.{rrnagene}.nhmmer.out",
               lib=config['libraries_mg'],
               rrnagene=config['ciliate_mt_rRNA'],
               qtrimvals=config['qtrimvals'])

rule annotation_spades_sc:
    input:
        expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.scaffolds.covstats",
               lib=config['libraries_sc'],
               qtrimvals=config['qtrimvals']),
        expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
               lib=config['libraries_sc'],
               qtrimvals=config['qtrimvals'],
               kingdom=config['barrnap_kingdoms']),
        expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.{rrnagene}.nhmmer.out",
               lib=config['libraries_sc'],
               rrnagene=config['ciliate_mt_rRNA'],
               qtrimvals=config['qtrimvals'])

rule assembly:
    input:
        expand("assembly/spades_{lib_mg}_q{qtrimvals}/scaffolds.fasta",
               lib_mg=config['libraries_mg'],
               qtrimvals=config['qtrimvals']),
        expand("assembly/spades-sc_{lib_sc}_q{qtrimvals}/scaffolds.fasta",
               lib_sc=config["libraries_sc"],
               qtrimvals=config["qtrimvals"]),
        expand("assembly/spades-comb_{sp}_q{qtrimvals}/scaffolds.fasta",
               sp=config['species'],
               qtrimvals=config['qtrimvals'])

rule qc:
    input:
        expand("qc/phyloFlash/{lib}.phyloFlash.tar.gz",lib=config["libraries"])

rule rnaseq_qc:
    input:
        expand("qc/phyloFlash_rnaseq/{lib}.phyloFlash.tar.gz",lib=config["libraries_rnaseq"])

# rule rnaseq_trim:
#     input:
#         expand("data/reads-rnaseq-trim/{lib}_R12_ktrim_qtrim{qtrimvals}.fq.gz",lib=config["libraries_rnaseq"],qtrimvals=[28])

rule rnaseq_filter:
    input:
        expand("data/reads-rnaseq-filter/{lib}_R12_ktrim_qtrim{qtrimvals}_bbmap_nochlamy.R12.fq.gz",lib=config["libraries_rnaseq"],qtrimvals=[28])
