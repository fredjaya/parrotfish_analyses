#!/bin/bash
BIN=/home/meep/Desktop/Biocomputing/hyphy-analyses/codon-msa
CDS=/media/meep/GenomeAbyss/pf/cds/original_1L
WORK=/media/meep/GenomeAbyss/pf/2202_hyphy_aln

# Run pre-msa.bf
cat ${WORK}/og_names.txt | \
	xargs -I {} -n 1 -P 11 \
	sh -c 'hyphy '${BIN}'/post-msa.bf --protein-msa '${WORK}'/aligned_protein/{}_aligned.faa --nucleotide-sequences '${WORK}'/{}.fa_nuc.fas --output '${WORK}'/post/{}_post.fa --compress No'
