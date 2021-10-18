#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Oct 13 13:40:20 2021

@author: Fred Jaya
"""
import argparse
import pandas as pd
import os
from Bio import SeqIO

def load_scos(sco_tsv):
    """ Load list of sequences per orthogroup """
    scos = pd.read_csv(sco_tsv, sep='\t')
    scos.set_index('Orthogroup', inplace=True)
    return scos

def load_species_fa(fasta_dir, species):
    """ Load .fasta file for a single species """
    fa_path = os.path.join(fasta_dir + species + '.fa')
    fa_dict = SeqIO.to_dict(SeqIO.parse(fa_path, "fasta"))
    return fa_dict

def load_ballan_headers(ballan_headers):
    ballan_headers = pd.read_csv(ballan_headers, sep='\t')
    ballan_headers.drop(['RefSeq peptide ID'], axis=1, inplace=True)
    ballan_headers.dropna(subset=['RefSeq peptide predicted ID'], inplace=True)
    ballan_headers.rename(columns={"RefSeq peptide predicted ID":"ballan"}, inplace=True)
    return ballan_headers

def replace_ballan_headers(scos, ballan_headers):
    """ First, remove versions from scos RefSeq IDs"""
    scos['ballan'] = scos.replace('\.\d$', '', regex=True)
    """ Join matching IDs then remove RefSeq ID columns """
    scos = scos.merge(ballan_headers, on='ballan', how='left')
    return scos
    
def write_og(scos, fasta_dir, out_dir):
    """ Iterate through each species and writes sequences for each
    orthogroup. WARNING: delete the output .fa before running
    as each sequence is appended"""
    for species in scos.columns:
        sco_sp = scos[species]
        fa_dict = load_species_fa(fasta_dir, species)
        
        for og, seq_name in sco_sp.items():
            out_file = os.path.join(out_dir + og + ".fa")
            print(species + " " + out_file)
            with open(out_file, "a") as writer:
                SeqIO.write(fa_dict[seq_name], writer, "fasta")
    return

if __name__ == '__main__':
    """ Set arguments """
    parser = argparse.ArgumentParser()
    parser.add_argument("sco_tsv")
    parser.add_argument("fasta_dir", help="Path to cds .fa with longest isoforms.")
    parser.add_argument("out_dir")
    parser.add_argument("ballan_headers", help="BioMart .tsv to convert to RefSeq ID Transcript ID")
    args = parser.parse_args()
    
    """ Main """
    scos = load_scos(args.sco_tsv)
    scos.rename(columns={"parrotfish_1L_noAbIn":"parrotfish"}, inplace=True)
    scos.drop(['sunfish'], axis=1, inplace=True)
    #ballan_headers = load_ballan_headers(args.ballan_headers)
    #scos = replace_ballan_headers(scos, ballan_headers)
    write_og(scos, args.fasta_dir, args.out_dir)
