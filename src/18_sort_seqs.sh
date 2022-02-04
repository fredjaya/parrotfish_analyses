#!/bin/bash

CDS=/home/fredjaya/Dropbox/parrotfish/02_working/2110_selection/cds/original
AA=/home/fredjaya/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/Results_Sep29/Orthogroup_Sequences
WORK=/home/fredjaya/Dropbox/parrotfish/02_working/2202_pal2nal

## AA
for i in ${AA}/*.fa; do
	OG=`basename $i .fa`
	echo ${OG}.fa
	# multi -> single line fasta
	perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' $i | \
		# headers and seqs on one line and sort
		sed 'N;s/\n/ /' | sort | sed 's/ /\n/' > ${WORK}/01_aa_sorted/${OG}.fa
done

## CDS
for i in ${CDS}/*.fa; do
	OG=`basename $i .fa`
	echo ${OG}.fa
	perl -pe '$. > 1 and /^>/ ? print "\n" : chomp' $i | \
		sed 'N;s/\n/ /' | sort | sed 's/ /\n/' > ${WORK}/02_cds_sorted/${OG}.fa
done

# Remove sunfish and ballan sequences from AA
for i in ${AA}/*.fa; do
	echo ${OG}.fa
	sed -i '/XP_02/,+1 d' ${i}
	sed -i '/NP_001/,+1 d' ${i}
	sed -i '/Sunfish/,+1 d' ${i}
done
