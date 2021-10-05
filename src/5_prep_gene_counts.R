library(dplyr)
library(tidyr)

gene_counts <- read.table("Results_Sep29/Orthogroups/Orthogroups.GeneCount.tsv", sep='\t', header=T)
annotated_ogs <- read.table("annotated_orthogroups.tsv", quote="", sep='\t', header=T, fill=T)

cafe_input <- 
  annotated_ogs %>%
  select(Desc = Best.Gene.Name, Orthogroup) %>%
  full_join(gene_counts, by = 'Orthogroup') %>%
  rename(`Family ID` = Orthogroup) %>%
  select(-Total)