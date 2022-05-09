#!/bin/bash
JAR=/home/meep/anaconda3/envs/paml/share/macse-1.2-1/macse_v1.2.jar
CDS=/media/meep/GenomeAbyss/pf/cds/original
WORK=/media/meep/GenomeAbyss/pf/2202_macse

ls ${CDS} | \
	xargs -I {} -n 1 -P 10 \
	sh -c 'java -Xmx6g -jar '${JAR}' -prog alignSequences -seq '${CDS}'/{}'

# mv ${CDS}/*.fa 

#JAR=/home/fredjaya/miniconda3/envs/paml/share/macse-1.2-1/macse_v1.2.jar
#CDS=/home/fredjaya/Dropbox/parrotfish/02_working/2110_selection/cds/original
#WORK=/home/fredjaya/Dropbox/parrotfish/02_working/2202_macse
#
#ls ${CDS}| \
#	xargs -I {} -n 1 -P 10 \
#	sh -c 'java -Xmx6g -jar '${JAR}' -seq '${CDS}'/{}'
#
# mv to 01_aligned_nt/
