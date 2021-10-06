#!/bin/bash
set -e

cd /media/meep/GenomeAbyss/pf/2110_noAbInit

AMAS.py concat \
	--in-files trimmed_scos/*.fa \
	--in-format fasta \
	--data-type aa \
	--concat-part pf16_noAbInit.partitions \
	--concat-out pf16_noAbInit_concat.fa \
	--part-format nexus \
	-c 10

