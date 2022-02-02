# parrotfish_analyses
Evolutionary analyses of the Parrotfish genome

## Table of contents

## Dependencies
**Dependencies outdated**
- perl
- python3.7
- OrthoFinder v2.4.0
- MAFFT v7.487
- trimAl v1.4
- IQ-TREE v2.1.4-beta
- BEAST v2.6.3
- AMAS v1.0
- FigTree

## Preparing proteomes

**Ensembl, RefSeq, and corkwing** proteomes filtered with OrthoFinder script `primary_transcript.py`

<p align="right">(<a href="#parrotfish_analyses">[back to top]</a>)</p>

## OrthoFinder

Orthofinder ran with default settings.  

### Annotate orthogroups

First, account for Ensembl IDs that have been replaced by Gene IDs by OrthoFinder:
```
src/1_get_headers.sh ~/Dropbox/parrotfish/02_working/2108_orthofinder/proteomes/
src/2_fix_ensembl_headers # coelacanth fugu gar human medaka sparus stickleback tilapia zebra
```

Also Parrotfish/FGENESH++ headers:
```
src/3_fix_pf_headers.sh
```

Finally, annotate orthogroups according to most common gene name/description:
```
python3 src/4_annotate_orthogroups.py \
	~/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/Results_Sep29/Orthogroups/Orthogroups.tsv \
	~/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/headers/
```

<p align="right">(<a href="#parrotfish_analyses">[back to top]</a>)</p>

## Phylogenies

### Prepare single-copy group sequences

Align all single-copy orthogroups with MAFFT and remove poorly aligned regions with TrimAl:
```
src/5_align_scos.sh
src/6_trim_scos.sh
```
1771 SCOs in total.

Rename all sequences with species names:
```
src/7_rename_seqs.sh

# Check sequences renamed correctly:
for i in *.fa; do grep '>' $i; done | sort | uniq -c
```

Concatenate and generate partitions file:
```
src/8_concat.sh
```

### Tree inference

Run IQ-TREE for species tree:
```
src/9_iqtree.sh
```

Run MCMCTree for divergence times - see [mcmctree_example](https://github.com/fredjaya/parrotfish_analyses/tree/main/mcmctree_example)

<p align="right">(<a href="#parrotfish_analyses">[back to top]</a>)</p>

## CAFE

### Prepare input files

Concatenate orthogroup descriptions with gene counts:
```
src/12_prep_gene_counts.R
```

Make OrthoFinder species tree ultrametric
```
src/13_iqtree2ultrametric.sh
```

### Running CAFE

Run CAFE:
```
src/14_cafe.sh
```

Investigate branches that tested significant for expansion/contraction:
```
# 423/14995 (2.9%) orthogroups with a signficantly fast evolving branch
grep -c '*' Base_asr.tre

# 211 orthogroups with significant changes on PF branch
grep -Ec '<2>\* Base_asr.tre'

# Subset orthogroups where PF branch == significant
grep -c '<2>\*' Base_asr.tre > pf_significant.tre
```

<p align="right">(<a href="#parrotfish_analyses">[back to top]</a>)</p>

## Positive selection analyses

### Convert single-copy groups to CDS

Downloaded *.cds.all sequences from Ensembl.

Some text wrangling and parsing to get headers in the right format:
```
# Get list of all single-copy orthogroups (n = 1771)
ls Single_Copy_Orthologue_Sequences/ | sed 's/\.fa//' > sco.list

# Subset SCOs in Orthogroups.tsv
head -1 Orthogroups.tsv > Orthogroups_SCO.tsv
for i in `cat sco.list`; do grep $i Orthogroups.tsv >> Orthogroups_SCO.tsv; done

# Fix headers according to Ensembl, RefSeq, FGENESH++
# Note: not all RefSeq sequence headers contain protein IDs
# Chelmon = 173; Humphead = 66; Spotty = 139
src/16_fix_cds_headers.sh
```

Finally, write CDS sequences:
```
# Attempt to convert RefSeq ID to Ensembl Transcript ID for Ballan wrasse but not all headers exist; functions written in 17_fix_cds_headers.py if complete list found
# Also Sunfish seem irredeemable for now
src/17_get_cds.py
```
