#!/bin/bash
JAR=/home/fredjaya/miniconda3/envs/paml/share/macse-1.2-1/macse_v1.2.jar
CDS=/home/fredjaya/Dropbox/parrotfish/02_working/2110_selection/cds/original
AA=/home/fredjaya/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/Results_Sep29/Orthogroup_Sequences
WORK=/home/fredjaya/Dropbox/parrotfish/02_working/2202_prank

ls `/home/fredjaya/Dropbox/parrotfish/02_working/2110_selection/cds/original` | \
	xargs 
java -Xmx8g -jar ${JAR} \
	-seq ${CDS}/${OG} \
	-out_NT 01_aligned_nt/${OG}
