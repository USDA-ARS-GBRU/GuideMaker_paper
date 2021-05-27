# GuideMaker_paper

Scripts to parse timelogs from slurm and generate performance graphics



```python

### Usage
python timeparser.py -i slurm_avx2_logs/ -o avx2_out.csv
python timeparser.py -i slurm_nonavx2_logs/ -o nonavx2_out.csv

```


Plotting the output from `timeparser.py`  in R. This script will generate figures used in the paper.

```R

Rscript Plot.R 

```

## Plot

# ![alt text](https://github.com/USDA-ARS-GBRU/GuideMaker_paper/blob/master/figures/Figure%203.%20Performance%20of%20GuideMaker%20for%20SpCas9.png)


## Comparisions of performance with or without AVX2 instruction settings
# ![alt text](https://github.com/USDA-ARS-GBRU/GuideMaker_paper/blob/master/figures/Supplemental%20Figure%203.%20Performance%20of%20GuideMaker%20with%20AVX2%20settings.png)
