# parrotfish_analyses
Evolutionary analyses of the Parrotfish genome

## Downloading proteomes

## Longest isoforms

**Ensembl, RefSeq, and corkwing** proteomes filtered with OrthoFinder script `primary_transcript.py`

## OrthoFinder

## Annotate orthogroups

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
