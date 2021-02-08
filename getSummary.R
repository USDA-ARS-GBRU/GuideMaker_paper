options(tidyverse.quiet = TRUE)
library(tidyverse)
library(knitr)

args <- commandArgs(trailingOnly = TRUE)

# read in log - this is in actual the number of locus_tag or locus
genome_locus_count <- readLines("logfile.txt") %>%
  .[[grep('Total number of CDS/locus in the input genome',.)]] %>%
  strsplit(., " ") %>%
  unlist() %>%
  tail(1) %>%
  as.numeric()

# read in the target output from GuideMaker
targets <- read.csv("targets.csv", header = TRUE, stringsAsFactors = FALSE)

## get only the targets within a gene coordinates i.e. feature distance = 0
targets = targets %>%
  filter(`Feature.distance`== 0 )

# Count number of locus tag in the output
target_locus_count <- targets %>% pull(locus_tag) %>% unique() %>% length()


# Missing locus
missing_locus = genome_locus_count - target_locus_count
missing_locus_percentage <- round(missing_locus / genome_locus_count * 100, 2)

# genome coverage
genome_coverage = round(target_locus_count / genome_locus_count * 100, 2)

getSummary <- function(x){
  average = round(mean(x), 2)
  sdev = round(sd(x), 2)
  middle = median(x)
  low = min(x)
  high = max(x)
  message (
    "######### Printing summary of targets and genome ###########", "\n",
    "Total number of CDS/locus_tag in the genome: ", genome_locus_count, "\n",
    "Total number of CDS/locus_tag in the targets file: ", target_locus_count, "\n",
    "Number of locus missded by targets: ", missing_locus, "\n",
    "Percentage of locus missded by targets: ", missing_locus_percentage,"%", "\n",
    "Coverage of genome by targets: ", genome_coverage,"%", "\n" ,
    "Average number of targets per locus tag: ", average, "\n",
    "Standard Deviation: ", sdev, "\n",
    "Median number of targers per locus tag: ", middle, "\n",
    "Minimum number of target: ", low, "\n",
    "Maximum number of target: ", high, "\n")
}
   


# Average number of guide per locus
targets %>% group_by(locus_tag) %>% tally() %>% pull (n) %>% getSummary()

# Summary of targets by PAM
byPAM <- targets %>% group_by(PAM) %>% tally() 

message("Number of targets by PAM type:")
kable(byPAM)

