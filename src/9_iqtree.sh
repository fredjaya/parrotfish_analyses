#!/bin/bash
set -e

cd /data/iqtree

iqtree2 -s pf16_noAbInit_concat.fa -p pf16_noAbInit.partitions -m MFP+MERGE -B 1000 -T 60

