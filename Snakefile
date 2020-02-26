include: "snakefile-reads-assembly-spades"
include: "snakefile-reads-assembly-megahit"
include: "snakefile-reads-assembly-spades-qc"
include: "snakefile-reads-assembly-megahit-qc"
include: "snakefile-reads-assembly-qc"
include: "snakefile-reads-preprocess-qc"
include: "snakefile-reads-rnaseq-preprocess-qc"
include: "snakefile-reads-rnaseq-assembly"

rule annotation_megahit_comb:
    input:
        expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.bin_cds50_gc40.fasta",
               sp=config['species'],
               qtrimvals=[28]),
        expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.bt2.blobplot.png",
               sp=config['species'],
               qtrimvals=[28]),
        # expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.cds-dens.tsv",
        #        sp=config['species'],
        #        qtrimvals=[28])
        expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
               sp=config['species'],
               qtrimvals=[28],
               kingdom=config['barrnap_kingdoms']),
        expand("annotation/megahit-comb_{sp}_q{qtrimvals}/megahit-comb_{sp}_q{qtrimvals}.{rrnagene}.nhmmer.out",
               sp=config['species'],
               rrnagene=config['ciliate_mt_rRNA'],
               qtrimvals=[28])

rule annotation_spades_comb:
    # Annotate each combined metagenomic assembly
    input:
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.bin_cds50_gc40.fasta",
               sp=config['species'],
               qtrimvals=[28]),
        # expand("annotation/spades-comb_{sp}_q{qtrimvals}/mapping/spades-comb_{sp}_q{qtrimvals}.sort.bam",
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.bt2.blobplot.png",
               sp=config['species'],
               qtrimvals=[28]),
        # expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.scaffolds.covstats",
        #        sp=config['species'],
        #        qtrimvals=[28]),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
               sp=config['species'],
               qtrimvals=[28],
               kingdom=config['barrnap_kingdoms']),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.{rrnagene}.nhmmer.out",
               sp=config['species'],
               rrnagene=config['ciliate_mt_rRNA'],
               qtrimvals=[28]),
        expand("annotation/spades-comb_{sp}_q{qtrimvals}/spades-comb_{sp}_q{qtrimvals}.cds-dens.tsv",
               sp=config['species'],
               qtrimvals=[28])

# rule annotation_spades:
#     # Annotate each bulk metagenomic assembly
#     input:
#         # expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.scaffolds.covstats",
#         expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.bt2.blobplot.png",
#                lib=config['libraries_mg'],
#                qtrimvals=config['qtrimvals']),
#         expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.barrnap.{kingdom}.Bandage.png",
#                lib=config['libraries_mg'],
#                qtrimvals=config['qtrimvals'],
#                kingdom=config['barrnap_kingdoms']),
#         expand("annotation/spades_{lib}_q{qtrimvals}/spades_{lib}_q{qtrimvals}.{rrnagene}.nhmmer.out",
#                lib=config['libraries_mg'],
#                rrnagene=config['ciliate_mt_rRNA'],
#                qtrimvals=config['qtrimvals'])

rule annotation_spades_sc:
    # Annotate each single-cell MDA assembly
    input:
        expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.bin_cds50_gc40.fasta",
               lib=config['libraries_sc'],
               qtrimvals=config['qtrimvals']),
        # expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.scaffolds.covstats",
        expand("annotation/spades-sc_{lib}_q{qtrimvals}/spades-sc_{lib}_q{qtrimvals}.bt2.blobplot.png",
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

rule assembly_rnaseq:
    input:
        # Combined assemblies of RNAseq libraries, combined by experiment
        expand("assembly/trinity_rnaseq_{experiment}_nochlamy_comb/trinity_outdir/Trinity.fasta",
               experiment=["exp146"])
rule assembly:
    input:
        # Individual assemblies of each bulk metagenomic library
        # expand("assembly/spades_{lib_mg}_q{qtrimvals}/scaffolds.fasta",
        #        lib_mg=config['libraries_mg'],
        #        qtrimvals=config['qtrimvals']),
        # Individual assemblies of each single-cell MDA library
        expand("assembly/spades-sc_{lib_sc}_q{qtrimvals}/scaffolds.fasta",
               lib_sc=config["libraries_sc"],
               qtrimvals=config["qtrimvals"]),
        # Combined assemblies of all bulk metagenomic libraries per species
        expand("assembly/{assembler}-comb_{sp}_q{qtrimvals}/scaffolds.fasta",
               assembler=['spades','megahit'],
               sp=config['species'],
               qtrimvals=[28]),
        expand("assembly/{assembler}-comb_{sp}_q{qtrimvals}/assembly_graph.fastg",
               assembler=['spades','megahit'],
               sp=config['species'],
               qtrimvals=[28])

rule qc:
    input:
        expand("qc/phyloFlash/{lib}.phyloFlash.tar.gz",lib=config["libraries"])

rule rnaseq_qc:
    input:
        expand("qc/phyloFlash_rnaseq/{lib}.phyloFlash.tar.gz",lib=config["libraries_rnaseq"])

rule rnaseq_filter:
    input:
        expand("data/reads-rnaseq-filter/{lib}_R12_ktrim_qtrim{qtrimvals}_bbmap_nochlamy.R12.fq.gz",lib=config["libraries_rnaseq"],qtrimvals=[28])
