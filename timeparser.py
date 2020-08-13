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
        description="timeparser.py: A script to reformat slurm log files.")
    parser.add_argument('--indir', '-i', type=str, required=True,
                        help='The error log produced from vsearch')

    parser.add_argument('--outfile', '-o', type=str, required=True,
                        help='A csv file of filename, seqs, unique seqs, and the fraction unique')
    return parser


# code used for itsxpress ms
def time_string_to_secs(time_string):
    """ Converts different time string formats to seconds.
    From http://lexfridman.com/python-robust-conversion-of-time-string-to-seconds-with-missing-values/
    """
    res = re.match('(\d\d?:)?(\d\d?:)?(\d\d?)(\.\d*)?$', time_string)
    # above regex should match all reasonable input. Instead of assert, can return None
    assert res is not None
    # some conditions to make sure that hours and minutes don't get confused:
    if res.group(1) is not None and res.group(2) is not None:
        hours = int(res.group(1)[:-1])
        mins = int(res.group(2)[:-1])
    elif res.group(1) is not None:
        assert res.group(2) is None
        hours = 0
        mins = int(res.group(1)[:-1])
    else:
        hours = 0
        mins = 0
    # the seconds are easy
    secs = 0 if res.group(3) is None else int(res.group(3))
    # have to keep microseconds as a string to not lose the leading zeros
    msecs_str = 0 if res.group(4) is None or res.group(
        4) == '.' else res.group(4)[1:]
    secs_int = hours * 3600 + mins * 60 + secs
    secs_float = float('{}.{}'.format(secs_int, msecs_str))
    return secs_float


def parse_sample_file(file):
    tlist = []
    with open(file, "r") as f:
        for line in f:
            if "Elapsed (wall clock) time (h:mm:ss or m:ss):" in line:
                seconds = time_string_to_secs(line.strip().split()[7])
                tlist.append(seconds)
            if "Percent of CPU this job got:" in line:
                cpu = line.strip().split()[6]
                tlist.append(cpu)
            if "Input Genome:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" in line:
                genome = line.strip().split()[2]
                tlist.append(genome)
            if "Threads used:>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" in line:
                ll = line.strip().split()[2]
                tlist.append(ll)
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
    datalist_flat = sum(datalist, [])
    chunks = [datalist_flat[x:x+4] for x in range(0, len(datalist_flat), 4)]
    labels = ["Genome", "threads", "CPU%", "process_sec"]
    df = pandas.DataFrame.from_records(chunks, columns=labels)
    print(df)
    df.to_csv(args.outfile, index=False)


if __name__ == "__main__":
    main()
