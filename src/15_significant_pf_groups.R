library(dplyr)
library(tidyr)

cafe_change <- 
  read.table("cafe_results/Base_change.tab", sep='\t', header=T) %>%
  rename(Family.ID=FamilyID)

annotations <-
  read.table("annotated_orthogroups.tsv", header=T, sep='\t', fill=T) %>%
  rename(Family.ID=Orthogroup)

sig_pf <- 
  read.table("cafe_results/pf_significant.tre", sep=' ') %>%
  select(Family.ID=V4) %>%
  left_join(annotations, by='Family.ID') %>%
  left_join(cafe_change, by='Family.ID')

write.table(sig_pf, "sig_pf_groups.tsv", sep='\t', quote = F, row.names = F)