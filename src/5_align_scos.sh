#!/bin/bash
set -e

cd /media/meep/GenomeAbyss/pf/Results_Sep29/Single_Copy_Orthologue_Sequences

for i in *.fa; do 
	mafft --anysymbol $i > \
		/media/meep/GenomeAbyss/pf/2110_noAbInit/aligned_scos/${i} 
done

