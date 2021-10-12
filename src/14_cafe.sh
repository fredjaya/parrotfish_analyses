#!/bin/bash

cd /data/cafe_noAbInit

cafe5 -t SpeciesTree_rooted_node_labels.txt.ultrametric.tre -i cafe_gene_counts.tsv -c 60 -o orthofinderTree_no-p
