#!/bin/bash

FA=/media/meep/GenomeAbyss/pf/2202_hyphy_aln/post/complete
TREE=/media/meep/GenomeAbyss/pf/2202_hyphy_aln/post/n14.tre

# cd /media/meep/GenomeAbyss/pf/2202_codeml/03_prep
for i in ${FA}/*; do
	name=`basename $i _post.fa`
	echo $name
	
	# Make separate directories for each .fa and model
	mkdir -p 01_null/${name}
	mkdir -p 02_alt/${name}

	# Add symlinks for .fa and tree
	ln -sf $i 01_null/${name}
	ln -sf $i 02_alt/${name}

	ln -sf ${TREE} 01_null/${name}
	ln -sf ${TREE} 02_alt/${name} 

	# Add .ctl files for each sequence and model using template .ctls
	sed 's/SEQ_FILE/'${name}'_post\.fa/' ../02_ctl_template/A.ctl > 01_null/${name}/A.ctl
	sed 's/SEQ_FILE/'${name}'_post\.fa/' ../02_ctl_template/A1.ctl > 02_alt/${name}/A1.ctl

done
