#!/bin/bash
set -e

seqs=(coelacanth fugu gar human medaka sparus stickleback tilapia zebra)

for s in ${seqs[@]}; do
	# Keep only GeneID, GeneSymbol, Description
	echo $s
	perl -i -pe 's/ transcript.*transcript_biotype:protein_coding//;' \
		-pe 's/ transcript.*transcript_biotype:IG_\w_gene//;' \
		-pe 's/ transcript.*transcript_biotype:TR_\w_gene//;' \
		-pe 's/ transcript.*transcript_biotype:nonsense_mediated_decay//;' \
		-pe 's/^.*gene:/>/;' \
		-pe 's/gene_symbol://;' \
		-pe 's/description://;' \
		headers/${s}.fa 
done
