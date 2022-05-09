#!/bin/bash
BIN=/home/meep/Desktop/Biocomputing/hyphy-analyses/codon-msa
CDS=/media/meep/GenomeAbyss/pf/cds/original_1L
WORK=/media/meep/GenomeAbyss/pf/2202_hyphy_aln

# Run pre-msa.bf
ls ${WORK} | xargs -I {} -n 1 -P 10 sh -c 'hyphy '${BIN}'/pre-msa.bf --input {}'

