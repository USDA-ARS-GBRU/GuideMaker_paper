# load library
library(tidyverse)
library(ggsci)
library(ggplot2)
library(gridExtra)

source("summarySE.R")


## load data
data_avx2 <- read.csv("avx2_out.csv", header = TRUE, stringsAsFactors = FALSE)
data_avx2["Processor"] <- "AVX2"
data_nonavx2 <- read.csv("nonavx2_out.csv", header = TRUE, stringsAsFactors = FALSE)
data_nonavx2["Processor"] <- "nonAVX2"

# combine data
data <- bind_rows(data_avx2,data_nonavx2 )

sel_data <- data %>%
  select(Genome, threads, process_sec, Processor)

## Get summary stat
summarystat <- summarySE(sel_data, measurevar="process_sec", groupvars=c("Genome", "threads","Processor"))

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.1) # move them .05 to the left and right


# plot
p3 <- ggplot(summarystat, aes(x=threads, y=process_sec, colour=Genome, group=Genome)) + 
  geom_errorbar(aes(ymin=process_sec-sd, ymax=process_sec+sd), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=3, shape=21, fill="white") + # 21 is filled circle
  xlab("Processor cores") +
  ylab("Run time in seconds") +
  expand_limits(y=0) + # Expand y range
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.position=c(0.48,0.82)) # Position legend (left-right, top-bottom)

 
p4 <- p3 + facet_grid(. ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
           axis.text.y = element_text(color = "black", size = 10, angle = 0),  
           axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
           axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))

p5 

# Save the plot
ggsave("figures/AVX2_Performance_Graph.pdf", width = 10, height = 6, units = "in")
ggsave("figures/AVX2_Performance_Graph.png", width = 10, height = 6, units = "in")

dev.off()

print("Plot saved as AVX2_Performance_Graph.pdf")


##
file.remove("Rplots.pdf")
