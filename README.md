# GuideMaker_paper

Scripts to parse timelogs from slurm and generate performance graphics



```python

### Usage
python timeparser.py -i slurm_avx2_logs/ -o avx2_out.csv
python timeparser.py -i slurm_nonavx2_logs/ -o nonavx2_out.csv

```


Plotting the output from `timeparser.py`  in R. 

```bash

Rscript Plot.R 

```

## Plot

# ![alt text](https://github.com/USDA-ARS-GBRU/GuideMaker_paper/blob/master/figures/AVX2_Performance_Graph.png)
