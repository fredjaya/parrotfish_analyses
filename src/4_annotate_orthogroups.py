#!/usr/bin/env python3

"""
Heavily adapted from Thomas Roders' orthogroup tools
https://binfgitlab.unibe.ch/troder/orthofinder_tools/-/blob/master/orthogroup_to_gene_name.py
"""
import os
import pandas as pd
import argparse
from Bio import SeqIO
from collections import Counter

## Functions ##
def load_orthogroups(orthogroups_tsv):
    raw_ogs = pd.read_csv(orthogroups_tsv, sep='\t')
    raw_ogs.set_index('Orthogroup', inplace=True)
    raw_ogs = raw_ogs.applymap(lambda x: [] if pd.isnull(x) else x.split(', '))
    """ Drop species that contain no descriptions """
    raw_ogs.drop(['corkwing', 'sunfish'], axis=1, inplace=True)
    return raw_ogs

def remove_species_from_desc(description):
    if description.endswith(']'):
        return description.rsplit(' [', maxsplit=1)[0]
    else:
        return description
    
def extract_description(gene_name):
    description = gene_name.description.split(' ', maxsplit=1)
    
    if len(description) == 1:
        """ This is later removed from all fields to avoid najority being 
        No descriptions """
        return "No description"
    else:
        return remove_species_from_desc(description[1])
    
def get_geneId_to_name(fasta_dir, sequence):
    fasta_path = os.path.join(fasta_dir + sequence + '.fa')
    gene_list = SeqIO.parse(fasta_path, 'fasta')
    return {gene.id: extract_description(gene) for gene in gene_list}

def load_gene_names(raw_ogs, fasta_dir):
    sequences = raw_ogs.columns
    
    gene_names = raw_ogs.__deepcopy__()
    for seq in sequences:
        geneId_to_name = get_geneId_to_name(fasta_dir, seq)
        gene_names[seq] = gene_names[seq].apply(lambda ids: [geneId_to_name[id] for id in ids])
    return gene_names

def get_majority(gene_names):
    majority_df = pd.DataFrame(index=gene_names.index)
    majority_df[['Best Gene Name', 'Gene Name Occurrences']] = gene_names.apply(
            lambda row: pd.Series(count_genes(row)), axis=1)
    return majority_df

def exclude_no_description(names_to_count):        
    #print(str(names_to_count.most_common(2)[1]))
    if len(names_to_count) == 1:
        return names_to_count.most_common(1)[0][0], str(names_to_count)
    else:
        if names_to_count.most_common(2)[0][0] == "No description":
            return names_to_count.most_common(2)[1][0], str(names_to_count)
        else:
            return names_to_count.most_common(2)[0][0], str(names_to_count)

def count_genes(row):
    """ Ignores names with eAED in description, typically useless maker annotations """
    all_names = [name for cell in row for name in cell if "eAED" not in name]
    if len(all_names) == 0:
        return ['NO DESCRIPTIONS']
    else:
        names_to_count = Counter(all_names)
        return exclude_no_description(names_to_count)

## Main ##
if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument("orthogroups_tsv")
    parser.add_argument("fasta_dir")
    args = parser.parse_args()
    
    raw_ogs = load_orthogroups(args.orthogroups_tsv)
    gene_names = load_gene_names(raw_ogs, args.fasta_dir)
    majority_df = get_majority(gene_names)
    majority_df.to_csv("annotated_orthogroups.tsv", sep='\t')
