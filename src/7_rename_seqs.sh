#!/bin/bash
set -e

cd /media/meep/GenomeAbyss/pf/dating/trimmed_scos

for i in *.fa; do
        sed -i -e 's/XP_0345.*/spotty/' \
        -e 's/ENSTRUG.*/fugu/' \
        -e 's/XP_02.*/ballan/' \
        -e 's/NP_001.*/ballan/' \
        -e 's/.*SYMME.*/>corkwing/' \
        -e 's/XP_0416.*/humphead/' \
        -e 's/YP_003.*/humphead/' \
        -e 's/XP_041.*/chelmon/' \
        -e 's/YP_00911.*/chelmon/' \
        -e 's/scaffold.*/parrotfish/' \
        -e 's/ENSSAUG.*/sparus/' \
        -e 's/ENSDARG.*/zebra/' \
        -e 's/ENSLAC.*/coelacanth/' \
        -e 's/ENSLOC.*/gar/' \
		-e 's/ENSP00000.*/human/' \
        -e 's/ENSG00000.*/human/' \
        -e 's/ENSORL.*/medaka/' \
        -e 's/ENSGAC.*/stickleback/' \
        -e 's/ENSONI.*/tilapia/' \
        -e 's/Sunfish.*/sunfish/' \
        $i
done
