#!/bin/bash
set -e

cut -f1 -d' ' headers/parrotfish_1L_noAbIn.fa > headers/pf1
grep -oE '##.*##' headers/parrotfish_1L_noAbIn.fa | \
	perl -pe 's/## //;' \
	-pe 's/ ##//;' \
	-pe 's/\[.+\]//;' \
	-pe 's/^BY //;' | \
	cut -f3- -d' ' \
 	> headers/pf2
pr -mts' ' headers/pf1 headers/pf2 > headers/parrotfish_1L_noAbIn.fa
rm headers/pf1 headers/pf2
