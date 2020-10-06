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


######### non log graph #############
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
        legend.text = element_text(color = "black", size= 5),
        legend.position=c(0.48,0.60))# Position legend (left-right, top-bottom)
  

 
p4 <- p3 + facet_grid(. ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
           axis.text.y = element_text(color = "black", size = 10, angle = 0),  
           axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
           axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))

p6 <- p5 + scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20, 24, 28, 32)) +
  scale_y_continuous(breaks = seq(0, 3500, 100))
  

p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/AVX2_Performance_Graph.pdf", width = 10, height = 6, units = "in")
ggsave("figures/AVX2_Performance_Graph.png", width = 10, height = 6, units = "in")

dev.off()

print("Plot saved as AVX2_Performance_Graph.pdf")


##
file.remove("Rplots.pdf")

################## log graph #############
sel_data <- data %>%
  select(Genome,Processor, log_time, threads)

## Get summary stat
summarystat <- summarySE(sel_data, measurevar="log_time", groupvars=c("Genome", "threads","Processor"))

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.1) # move them .05 to the left and right


# plot
p3 <- ggplot(summarystat, aes(x=threads, y=log_time, colour=Genome, group=Genome)) + 
  geom_errorbar(aes(ymin=log_time-sd, ymax=log_time+sd), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=3, shape=21, fill="white") + # 21 is filled circle
  xlab("Processor cores") +
  ylab("Run time in seconds (log)") +
  expand_limits(y=0) + # Expand y range
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.text = element_text(color = "black", size= 5),
        legend.position=c(0.45,0.20))# Position legend (left-right, top-bottom)


p4 <- p3 + facet_grid(. ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
                 axis.text.y = element_text(color = "black", size = 10, angle = 0),  
                 axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
                 axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))

p6 <- p5 + scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20, 24, 28, 32)) +
  scale_y_continuous(breaks = seq(0, 8, 1))

p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/AVX2_Performance_Graph_log.pdf", width = 10, height = 6, units = "in")
ggsave("figures/AVX2_Performance_Graph_log.png", width = 10, height = 6, units = "in")

dev.off()

print("Plot saved as AVX2_Performance_Graph_log.pdf")


##
file.remove("Rplots.pdf")




# #######fold change in the run time
# 
# AVX2_1 <- summarystat %>%
#   filter (threads==1 & Processor =="AVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# AVX2_2 <-summarystat %>%
#   filter (threads==2 & Processor =="AVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# AVX2_4 <-summarystat %>%
#   filter (threads==4 & Processor =="AVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# AVX2_8 <-summarystat %>%
#   filter (threads==8 & Processor =="AVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# AVX2_16 <-summarystat %>%
#   filter (threads==16 & Processor =="AVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# AVX2_32 <-summarystat %>%
#   filter (threads==32 & Processor =="AVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# ########### non AVX2 ###########
# 
# nonAVX2_1 <- summarystat %>%
#   filter (threads==1 & Processor =="nonAVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# nonAVX2_2 <-summarystat %>%
#   filter (threads==2 & Processor =="nonAVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# nonAVX2_4 <-summarystat %>%
#   filter (threads==4 & Processor =="nonAVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# nonAVX2_8 <-summarystat %>%
#   filter (threads==8 & Processor =="nonAVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# nonAVX2_16 <-summarystat %>%
#   filter (threads==16 & Processor =="nonAVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# nonAVX2_32 <-summarystat %>%
#   filter (threads==32 & Processor =="nonAVX2") %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# #######
# 
# 
# 
# AVX2_ratio_1_2_4_8_16 <- c(AVX2_1/AVX2_2, AVX2_2/AVX2_4, AVX2_4/AVX2_16,AVX2_16/AVX2_32)
# AVX2_ratio_1_2_4_8_16
# 
# nonAVX2_ratio_1_2_4_8_16 <- c(nonAVX2_1/nonAVX2_2, nonAVX2_2/nonAVX2_4, nonAVX2_4/nonAVX2_16,nonAVX2_16/nonAVX2_32)
# nonAVX2_ratio_1_2_4_8_16
# 
# 
# data.frame(processors=c(1, 2, 4, 8, 16, 32), 
#            Mean_run_time_AVX2 = c(AVX2_1, AVX2_2, AVX2_4, AVX2_8, AVX2_16, AVX2_32),
#            Mean_run_time_nonAVX2 = c(nonAVX2_1, nonAVX2_2, nonAVX2_4, nonAVX2_8, nonAVX2_16, nonAVX2_32))
# 
# 
# 
# 
# 
# #########
# processor_1 <- summarystat %>%
#   filter (threads==1 ) %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# processor_2 <-summarystat %>%
#   filter (threads==2 ) %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# processor_4 <-summarystat %>%
#   filter (threads==4 ) %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# processor_8 <-summarystat %>%
#   filter (threads==8 ) %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# processor_16 <-summarystat %>%
#   filter (threads==16 ) %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# processor_32 <-summarystat %>%
#   filter (threads==32 ) %>%
#   summarize(mean=mean(process_sec)) %>% pull()
# 
# 
# ratio_1_2_4_8_16 <- c(processor_1/processor_2,
#                               processor_2/ processor_4,
#                               processor_4/ processor_8,
#                               processor_8/ processor_16,
#                       processor_16/ processor_32)
# 
# 
# ratio_1_2_4_8_16 
# 
# 
# 
# 
# require(vcd)
# require(MASS)
# 
# # data generation
# ps <- summarystat %>%
#   pull(process_sec)
#   
# # estimate the parameters
# fit1 <- fitdistr(ps, "exponential") 
# 
# # plot a graph
# hist(ps, freq = FALSE, breaks = 5, xlim = c(0, quantile(ps, 0.99)))
# curve(dexp(x, rate = fit1$estimate), from = 0, col = "red", add = TRUE)
  
  
  
  
  
  
  
  
  
  

  