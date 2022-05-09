#!/bin/bash
JAR=/home/meep/anaconda3/envs/paml/share/macse-1.2-1/macse_v1.2.jar
CDS=/media/meep/GenomeAbyss/pf/cds/original
WORK=/media/meep/GenomeAbyss/pf/2202_macse

ls ${CDS} | \
	xargs -I {} -n 1 -P 10 \
	sh -c 'java -Xmx6g -jar '${JAR}' -prog alignSequences -seq '${CDS}'/{}'

# mv ${CDS}/*.fa 
