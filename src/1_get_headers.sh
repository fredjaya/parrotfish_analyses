#!/bin/bash
set -e
mkdir -p headers

fasta_dir=$1

for f in ${fasta_dir}/*.fa; do
	name=`basename $f`
	echo "Extracting .fasta headers from ${name}"
	grep '>' $f | uniq > headers/${name}
done
