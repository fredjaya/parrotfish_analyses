# parrotfish_analyses
Evolutionary analyses of the Parrotfish genome

## Dependencies
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

### Longest isoforms

**Ensembl, RefSeq, and corkwing** proteomes filtered with OrthoFinder script `primary_transcript.py`

## OrthoFinder

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

Finally, annotate orthogroups:
```
python3 src/4_annotate_orthogroups.py \
	~/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/Results_Sep29/Orthogroups/Orthogroups.tsv \
	~/Dropbox/parrotfish/02_working/2110_orthofinder_noAbInit/headers/
```

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

Run IQ-TREE and BEAST:
```
src/9_iqtree.sh
src/10_beast.sh
```

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

```
# 423/14995 (2.9%) orthogroups with a signficantly fast evolving branch
grep -c '*' Base_asr.tre

# 211 orthogroups with significant changes on PF branch
grep -Ec '<2>\* Base_asr.tre'

# Subset orthogroups where PF branch == significant
grep -c '<2>\*' Base_asr.tre > pf_significant.tre
```


