#!/bin/bash

# Get -lnL values from null model
for i in `cat fa_list`; do
	grep -P '^lnL' 03_mlc/${i}_post.fa-A.mlc | \
	perl -pe 's/\(.+\): +/\t/;' -pe 's/(?<=\d ).+$//;' -pe 's/^/'${i}'\tA\t/;'
done > lnl.tsv

# Alternate model
for i in `cat fa_list`; do
	grep -P '^lnL' 03_mlc/${i}_post.fa-A1.mlc | \
	perl -pe 's/\(.+\): +/\t/;' -pe 's/(?<=\d ).+$//;' -pe 's/^/'${i}'\tA1\t/;'
done >> lnl.tsv
