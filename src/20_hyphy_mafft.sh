#!/bin/bash
WORK=/media/meep/GenomeAbyss/pf/2202_hyphy_aln

# Run pre-msa.bf
cat ${WORK}/og_names.txt | xargs -I {} -n 1 -P 10 sh -c 'mafft '${WORK}'/{}.fa_protein.fas > '${WORK}'/aligned_protein/{}_aligned.faa'


