include: "snakefile-reads-assembly-qc"
include: "snakefile-reads-assembly"
include: "snakefile-reads-preprocess-qc"

rule annotation_spades_comb:
    input:
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.scaffolds.covstats",
               sp=config['species'],
#               qtrimvals=config['qtrimvals']),
               qtrimvals=28),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
               sp=config['species'],
#               qtrimvals=config['qtrimvals'],
               qtrimvals=28,
               kingdom=config['barrnap_kingdoms']),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.{rrnagene}.nhmmer.out",
               sp=config['species'],
               rrnagene=config['ciliate_mt_rRNA'],
               qtrimvals=28),
#               qtrimvals=config['qtrimvals']),
#        "qc/quast_spades_k127_comb/report.html"
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
