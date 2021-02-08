# GuideMaker_paper

Scripts to parse timelogs from slurm and generate performance graphics



```python

### Usage
python timeparser.py -i slurm_avx2_logs/ -o avx2_out.csv
python timeparser.py -i slurm_nonavx2_logs/ -o nonavx2_out.csv

```


Plotting the output from `timeparser.py`  in R. 

```R

Rscript Plot.R 

```

## Plot

# ![alt text](https://github.com/USDA-ARS-GBRU/GuideMaker_paper/blob/master/figures/AVX2_Performance_Graph.png)





```python
### Usage
python distparser.py -i dist_profile_logs/ -o dist_profile.csv

```

|Genome                           |Escherichia.coli (K12)|FIELD3    |FIELD4   |FIELD5     |FIELD6     |FIELD7     |Pseudomonas aeruginosa (PA01)|FIELD9     |FIELD10    |FIELD11    |FIELD12    |FIELD13    |Burkholderia thailandensis(E264)|FIELD15    |FIELD16    |FIELD17    |FIELD18    |FIELD19    |
|---------------------------------|----------------------|----------|---------|-----------|-----------|-----------|-----------------------------|-----------|-----------|-----------|-----------|-----------|--------------------------------|-----------|-----------|-----------|-----------|-----------|
|Total PAM sites in genome        |542072                |          |         |           |           |           |1171798                      |           |           |           |           |           |923228                          |           |           |           |           |           |
|Number of locus in genome        |4357                  |4357      |4357     |4357       |4357       |4357       |5584                         |5584       |5584       |5584       |5584       |5584       |5633                            |5633       |5633       |5633       |5633       |5633       |
|Hamming Distance                 |0                     |1         |2        |3          |4          |5          |0                            |1          |2          |3          |4          |5          |0                               |1          |2          |3          |4          |5          |
|Candidate PAM consider (N)       |169082                |169082    |168901   |168401     |165005     |144356     |161535                       |161535     |161126     |157822     |136024     |88006      |128778                          |128778     |128395     |125263     |107299     |71605      |
|Candidate PAM consider (%)       |31.1917974            |31.1917974|31.158407|31.06616833|30.43968329|26.63041072|13.78522578                  |13.78522578|13.75032215|13.46836229|11.60814407|7.510338813|13.94866707                     |13.94866707|13.90718219|13.56793771|11.62215617|7.755938945|
|Locus targeted by guides (N)     |4289                  |4289      |4286     |4285       |4285       |4282       |5568                         |5568       |5563       |5565       |5566       |5562       |5505                            |5505       |5500       |5498       |5497       |5460       |
|Number of missed locus (N)       |68                    |68        |71       |72         |72         |75         |16                           |16         |21         |19         |18         |22         |128                             |128        |133        |135        |136        |173        |
|Missed locus (%)                 |0.0156                |0.0156    |0.0163   |0.0165     |0.0165     |0.0172     |0.0029                       |0.0029     |0.0038     |0.0034     |0.0032     |0.0039     |0.0227                          |0.0227     |0.0236     |0.024      |0.0241     |0.0307     |
|Locus covered by guides locus (%)|0.9844                |0.9844    |0.9837   |0.9835     |0.9835     |0.9828     |0.9971                       |0.9971     |0.9962     |0.9966     |0.9968     |0.9961     |0.9773                          |0.9773     |0.9764     |0.976      |0.9759     |0.9693     |
|Guides per locus (Mean)          |39.42                 |39.42     |39.41    |39.3       |38.51      |33.71      |29.01                        |29.01      |28.96      |28.36      |24.44      |15.82      |23.39                           |23.39      |23.34      |22.78      |19.52      |13.11      |
|Guides per locus (sd)            |12.36                 |12.36     |12.36    |12.35      |12.13      |10.75      |8.64                         |8.64       |8.63       |8.67       |8.54       |7.51       |9.49                            |9.49       |9.48       |9.5        |9.36       |8.12       |
|Guides per locus (Median)        |42                    |42        |42       |41         |41         |35         |29                           |29         |28         |28         |24         |15         |22                              |22         |22         |22         |18         |12         |
|Guides per locus (Minimum)       |1                     |1         |1        |1          |1          |1          |1                            |1          |2          |1          |1          |1          |1                               |1          |1          |1          |1          |1          |
|Guides per locus (Maximum)       |82                    |82        |82       |82         |81         |71         |76                           |76         |76         |75         |74         |58         |65                              |65         |65         |65         |63         |59         |
|Number of guides for PAM (AGG)   |29850                 |29850     |29821    |29730      |29116      |25436      |28564                        |28564      |28484      |27832      |23487      |14350      |16856                           |16856      |16807      |16414      |14182      |9524       |
|Number of guides for PAM (CGG)   |53964                 |53964     |53900    |53753      |52658      |46196      |66273                        |66273      |66099      |64787      |56150      |36518      |68843                           |68843      |68630      |66759      |56380      |36560      |
|Number of guides for PAM (GGG)   |30284                 |30284     |30254    |30177      |29622      |26230      |32068                        |32068      |32003      |31410      |27356      |18228      |23428                           |23428      |23369      |22852      |19716      |13355      |
|Number of guides for PAM (TGG)   |54984                 |54984     |54926    |54741      |53609      |46494      |34630                        |34630      |34540      |33793      |29031      |18910      |19651                           |19651      |19589      |19238      |17021      |12166      |






### Note
Following parameters are used for analyzing performace of `GuideMaker`. Only the test paramters have been modified accordingly while other paramter remains the same. For instance, while profiling the output as a function of different `-dist ` [1, 2, 3, 4, 5] values, dist value was modified. Similarly, we profiled performace of `Guidemaker` with different `threads` values [1, 2, 4, 8, 16, and 32] on three genomes:
  - Escherichia.coli_str_K-12_substr_MG1655.gbk
  - Pseudomonas_aeruginosa_PAO1_107.gbk
  - Burkholderia_thailandensis_E264_ATCC_700388_133.gbk

```bash

guidemaker -i $inputgenome \
  --pamseq NGG  --outdir TEST --pam_orientation 5prime \
  --guidelength 20 --strand both --lcp 10 --dist 3 --before 100 \
  --into  100 --knum 10 --controls 10  --log $logfile --threads $THREADS


```










