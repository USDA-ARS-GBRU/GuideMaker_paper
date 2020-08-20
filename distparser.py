#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Aug 10 12:21:27 2020

@author: ravinpoudel
"""

import pandas
import os
import numpy as np
import argparse
import re
import glob


def myparser():
    """Creates parser object
    """
    parser = argparse.ArgumentParser(
        description="distparser.py: A script to reformat slurm log files for dist profile.")
    parser.add_argument('--indir', '-i', type=str, required=True,
                        help='The error log produced from vsearch')

    parser.add_argument('--outfile', '-o', type=str, required=True,
                        help='A csv file')
    return parser


def parse_sample_file(file):
    tlist = []
    with open(file, "r") as f:
        for line in f:
            if "Input Genome:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" in line:
                genome = line.strip().split()[2]
                tlist.append(genome)
            if "Threads used:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" in line:
                ll = line.strip().split()[2]
                tlist.append(ll)
            if "Dist used:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" in line:
                dist = line.strip().split()[2]
                tlist.append(dist)
            if "Total PAM sites considered:" in line:
                tpam = int(line.strip().split()[-1])
                tlist.append(tpam)
            if "Guide RNA candidates found:" in line:
                cpam = int(line.strip().split()[-1])
                tlist.append(cpam)   
            if "Total number of CDS/locus_tag in the genome:" in line:
                tc = line.strip().split()[-1]
                tlist.append(tc)
            if "Total number of CDS/locus_tag in the targets file:" in line:
                tt = line.strip().split()[-1]
                tlist.append(tt)
            if "Number of locus missded by targets:" in line:
                ml = line.strip().split()[-1]
                tlist.append(ml)
            if "Percentage of locus missded by targets:" in line:
                pml = line.strip().split()[-1]
                tlist.append(pml)
            if "Coverage of genome by targets:" in line:
                ct = line.strip().split()[-1]
                tlist.append(ct)
            if "Average number of targets per locus tag:" in line:
                lpt = line.strip().split()[-1]
                tlist.append(lpt)
            if "Standard Deviation:" in line:
                sd = line.strip().split()[-1]
                tlist.append(sd)
            if "Median number of targers per locus tag:" in line:
                medl = line.strip().split()[-1]
                tlist.append(medl)
            if "Minimum number of target:" in line:
                mint = line.strip().split()[-1]
                tlist.append(mint)
            if "Maximum number of target:" in line:
                maxt = line.strip().split()[-1]
                tlist.append(maxt)
            if "|AGG |" in line:
                agg = int(line.strip().split("|")[-2])
                tlist.append(agg)
            if "|CGG |" in line:
                cgg = int(line.strip().split("|")[-2])
                tlist.append(cgg)
            if "|GGG |" in line:
                ggg = int(line.strip().split("|")[-2])
                tlist.append(ggg)
            if "|TGG |" in line:
                tgg = int(line.strip().split("|")[-2])
                tlist.append(tgg)      
    return tlist


# code modify from itsXpress
def main(args=None):
    """Parse data files in directory
    """
    parser = myparser()
    if not args:
        args = parser.parse_args()
    datalist = []
    for file in glob.glob(os.path.join(os.path.join(args.indir, "*.out"))):
        try:
            datalist.append(parse_sample_file(file))
        except Exception as e:
            print(e)
            continue
    labels = ["Genome", "threads", "dist","total_PAM_sites","n_candidate_PAM","total_locus","target_locus","missed_locus","missed_locus%",
    "target_coverage%","mean_target","std_target","median_target","min_target","max_target","n_agg",
    "n_cgg","n_ggg","n_tgg"]
    datalist_flat = sum(datalist, [])
    chunks = [datalist_flat[x:x+len(labels)] for x in range(0, len(datalist_flat), len(labels))]
    df = pandas.DataFrame.from_records(chunks, columns=labels)
    p_pamc = round(df['n_candidate_PAM']/df['total_PAM_sites'] * 100, 2)
    df.insert(5, "percent_PAM_consider", p_pamc, True) 
    print(df)
    df.to_csv(args.outfile, index=False)


if __name__ == "__main__":
    main()
