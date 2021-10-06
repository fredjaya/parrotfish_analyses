#!/bin/bash
set -e

cd /media/meep/GenomeAbyss/pf/2110_noAbInit/aligned_scos

for i in *.fa; do 
	trimal -in $i \
		-out /media/meep/GenomeAbyss/pf/2110_noAbInit/trimmed_scos/${i} \
		-automated1
done

