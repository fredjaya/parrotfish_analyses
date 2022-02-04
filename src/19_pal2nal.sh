#!/bin/bash

CDS=/home/fredjaya/Dropbox/parrotfish/02_working/2110_selection/cds/original
AA=/home/fredjaya/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/Results_Sep29/Orthogroup_Sequences
WORK=/home/fredjaya/Dropbox/parrotfish/02_working/2202_pal2nal
OG=OG0008948.fa

# Ensure sequences are in the same order in CDS and AA
pal2nal.pl ${AA}/${OG} ${CDS}/${OG}

