#!/bin/bash
set -e
cd /Users/13444841/Dropbox/parrotfish/02_working/2110_selection
mkdir -p headers_fixed

refseq() {
	echo $1
	perl -pe 's/lcl.+protein_id=//;' genomes/${1}.fa | \
	cut -f1 -d' ' | \
	perl -pe 's/]$//;' \
	> headers_fixed/$1.fa
}

ensembl() {
	# No longer used as `primary_transcripts.py` fixes ensembl headers
	echo $1
	perl -pe 's/ENS.+gene[:=]//' genomes/$1.fa | \
	cut -f1 -d' ' | \
	> headers_fixed/$1.fa
}

# RefSeq
# Some headers do not contain a protein ID and headers were not processed
refseq chelmon
refseq humphead
refseq spotty

# Ensembl 
seqs=(coelacanth corkwing fugu gar human medaka sparus stickleback tilapia zebra)
for s in ${seqs[@]}; do
	python3 ~/GitHub/OrthoFinder/tools/primary_transcript.py genomes/${s}.fa
done

mv genomes/primary_transcripts/* headers_fixed
rm -rv genomes/primary_transcripts

echo 'parrotfish'
cut -f1 -d' ' genomes/parrotfish.fa > headers_fixed/parrotfish.fa
