# load library
library(tidyverse)
library(ggsci)
library(ggplot2)
library(gridExtra)

source("summarySE.R")


## load data
data_avx2 <- read.csv("avx2_out.csv", header = TRUE, stringsAsFactors = FALSE)
data_avx2["Processor"] <- "AVX2"
data_avx2["log_time"] <- log(data_avx2$process_sec)


data_nonavx2 <- read.csv("nonavx2_out.csv", header = TRUE, stringsAsFactors = FALSE)
data_nonavx2["Processor"] <- "nonAVX2"
data_nonavx2["log_time"] <- log(data_nonavx2$process_sec)


# combine data
data <- bind_rows(data_avx2,data_nonavx2 )

##########
main_fig <- c("Escherichia.coli_str_K-12_substr_MG1655.gbk", "Pseudomonas_aeruginosa_PAO1_107.gbk", "Burkholderia_thailandensis_E264_ATCC_700388_133.gbk")

data_main <- data[data$Genome %in% main_fig, ] %>%
  filter(PAM =="NGG")

######### non log graph #############
sel_data <- data_main %>%
  select(Genome, PAM, threads, process_sec, Processor)

## Get summary stat
summarystat <- summarySE(sel_data, measurevar="process_sec", groupvars=c("Genome","PAM", "threads","Processor"))

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.5) # move them .05 to the left and right


# plot
p3 <- ggplot(summarystat, aes(x=threads, y=process_sec, colour=Genome, group=Genome)) + 
  geom_errorbar(aes(ymin=process_sec-sd, ymax=process_sec+sd), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=2, shape=21, fill="white") + # 21 is filled circle
  xlab("Processor cores") +
  ylab("Run time in seconds") +
  expand_limits(y=0) + # Expand y range
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.text = element_text(color = "black", size= 5),
        legend.position=c(0.45,0.70))# Position legend (left-right, top-bottom)



p4 <- p3 + facet_grid(. ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
                 axis.text.y = element_text(color = "black", size = 10, angle = 0),  
                 axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
                 axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))

p6 <- p5 + scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20, 24, 28, 32)) +
  scale_y_continuous(breaks = seq(0, 250, 25))


p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/AVX2_Performance_Graph_main.pdf", width = 8, height = 4, units = "in")
ggsave("figures/AVX2_Performance_Graph_main.png", width = 8, height = 4, units = "in")

dev.off()

print("Plot saved as AVX2_Performance_Graph.pdf")


##
file.remove("Rplots.pdf")

################## supplement_fig 1 #############


supp_fig_1 <- data[data$Genome %in% main_fig, ] %>%
  filter(PAM =="NNAGAAW" | PAM =="NGRRT" )


sel_supp_fig_1 <- supp_fig_1 %>%
  select(Genome, PAM, threads, process_sec, Processor)

## Get summary stat
summarystat_sel_supp_fig_1 <- summarySE(sel_supp_fig_1, measurevar="process_sec", groupvars=c("Genome","PAM", "threads","Processor"))

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.5) # move them .05 to the left and right


# plot
p3 <- ggplot(summarystat_sel_supp_fig_1, aes(x=threads, y=process_sec, colour=Genome, group=Genome)) + 
  geom_errorbar(aes(ymin=process_sec-sd, ymax=process_sec+sd), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=2, shape=21, fill="white") + # 21 is filled circle
  xlab("Processor cores") +
  ylab("Run time in seconds") +
  expand_limits(y=0) + # Expand y range
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.text = element_text(color = "black", size= 5),
        legend.position=c(0.40,0.20))# Position legend (left-right, top-bottom)



p4 <- p3 + facet_grid(PAM ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
                 axis.text.y = element_text(color = "black", size = 10, angle = 0),  
                 axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
                 axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))

p6 <- p5 + scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20, 24, 28, 32)) +
  scale_y_continuous(breaks = seq(0, 25, 5))


p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/supp_fig_1.pdf", width = 8, height = 4, units = "in")
ggsave("figures/supp_fig_1.png", width = 8, height = 4, units = "in")

dev.off()

print("Plot saved as supp_fig_1.pdf")


##
file.remove("Rplots.pdf")



################## supplement_fig 2 #############

supp_fig <- c("Aspergillus_fumigatus.gbk",
               "Arabidopsis_thaliana.gbk")
               

supp_fig_2 <- data[data$Genome %in% supp_fig, ]


sel_supp_fig_2 <- supp_fig_2 %>%
  select(Genome, PAM, threads, process_sec, Processor)

## Get summary stat
summarystat_sel_supp_fig_2 <- summarySE(sel_supp_fig_2, measurevar="process_sec", groupvars=c("Genome","PAM", "threads","Processor"))

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.5) # move them .05 to the left and right


# plot
p3 <- ggplot(summarystat_sel_supp_fig_2, aes(x=threads, y=process_sec, colour=Genome, group=Genome)) + 
  geom_errorbar(aes(ymin=process_sec-sd, ymax=process_sec+sd), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=2, shape=21, fill="white") + # 21 is filled circle
  xlab("Processor cores") +
  ylab("Run time in seconds") +
  expand_limits(y=0) + # Expand y range
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.text = element_text(color = "black", size= 5),
        legend.position=c(0.35,0.15))# Position legend (left-right, top-bottom)


p4 <- p3 + facet_grid(PAM ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
                 axis.text.y = element_text(color = "black", size = 10, angle = 0),  
                 axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
                 axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))

p6 <- p5 + scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20, 24, 28, 32)) +
  scale_y_continuous(breaks = seq(0, 2000, 500))


p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/supp_fig_2.pdf", width = 8, height = 4, units = "in")
ggsave("figures/supp_fig_2.png", width = 8, height = 4, units = "in")

dev.off()

print("Plot saved as supp_fig_2.pdf")


##
file.remove("Rplots.pdf")




