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
data$Genome <- gsub('Pseudomonas_aeruginosa_PAO1_107.gbk', 'Pseudomonas aeruginosa', data$Genome)
data$Genome <- gsub('Burkholderia_thailandensis_E264_ATCC_700388_133.gbk', 'Burkholderia thailandensis', data$Genome)
data$Genome <- gsub('Escherichia.coli_str_K-12_substr_MG1655.gbk', 'Escherichia coli', data$Genome)
data$Genome <- gsub('Aspergillus_fumigatus.gbk', 'Aspergillus fumigatus', data$Genome)
data$Genome <- gsub('Arabidopsis_thaliana.gbk', 'Arabidopsis thaliana', data$Genome)

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
pd <- position_dodge(0.05) # move them .05 to the left and right


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
  scale_y_continuous(breaks = seq(0, 300, 50))


p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/Figure 3. Performance of GuideMaker for SpCas9.pdf", width = 8, height = 4, units = "in")
ggsave("figures/Figure 3. Performance of GuideMaker for SpCas9.png", width = 8, height = 4, units = "in")

dev.off()

print("Figure 3. Performance of GuideMaker for SpCas9.pdf")


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
pd <- position_dodge(0.05) # move them .05 to the left and right


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
  scale_y_continuous(breaks = seq(0, 50, 10))


p6 + theme(legend.key.size = unit(0, 'lines'))

# Save the plot
ggsave("figures/Supplemental Figure 1. Performance of GuideMaker for SaCas9 and StCas9.pdf", width = 8, height = 4, units = "in")
ggsave("figures/Supplemental Figure 1. Performance of GuideMaker for SaCas9 and StCas9.png", width = 8, height = 4, units = "in")

dev.off()

print("Supplemental Figure 1. Performance of GuideMaker for SaCas9 and StCas9.pdf")


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
pd <- position_dodge(0.05) # move them .05 to the left and right


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
ggsave("figures/Supplemental Figure 2. Performance of GuideMaker for SpCas9, SaCas9 and StCas9.pdf", width = 8, height = 4, units = "in")
ggsave("figures/Supplemental Figure 2. Performance of GuideMaker for SpCas9, SaCas9 and StCas9.png", width = 8, height = 4, units = "in")

dev.off()

print("Supplemental Figure 2. Performance of GuideMaker for SpCas9, SaCas9 and StCas9.pdf")


##
file.remove("Rplots.pdf")



########### Memory Usage Plots####################
library(tidyverse)
sel_data <- data %>%
  select(Genome, PAM, threads, MemoryUsage, Processor)
sel_data["MemoryUsage"] <- round(sel_data$MemoryUsage/1e6, 1)
## Get summary stat
summarystat <- summarySE(sel_data, measurevar="MemoryUsage", groupvars=c("Genome","PAM", "threads","Processor"))
write.csv(summarystat,"memory_usage.csv")

# The errorbars overlapped, so use position_dodge to move them horizontally
pd <- position_dodge(0.5) # move them .05 to the left and right


# plot
p3 <- ggplot(summarystat, aes(x=threads, y=MemoryUsage, colour=Genome, group=Genome)) + 
  geom_errorbar(aes(ymin=MemoryUsage-sd, ymax=MemoryUsage+sd), colour="black", width=.1, position=pd) +
  geom_line(position=pd) +
  geom_point(position=pd, size=2, shape=21, fill="white") + # 21 is filled circle
  xlab("Processor cores") +
  ylab("Memory Usage in GB") +
  expand_limits(y=0) + # Expand y range
  theme_bw() +
  theme(legend.justification=c(1,0),
        legend.text = element_text(color = "black", size= 5),
        legend.title=element_text(size=8),
        legend.position=c(0.45,0.10))# Position legend (left-right, top-bottom)


p4 <- p3 + facet_grid(PAM ~ Processor)

## Fixing axis text size
p5 <- p4 + theme(axis.text.x = element_text(color = "black", size = 10, angle = 0),
                 axis.text.y = element_text(color = "black", size = 10, angle = 0),  
                 axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
                 axis.title.y = element_text(color = "black", size = 12, angle = 90, face="bold")) +
  theme(legend.title = element_text(face = "bold"))


p6 <- p5 + scale_x_continuous(breaks = c(0, 4, 8, 12, 16, 20, 24, 28, 32))
p7 <- p6 + coord_cartesian(ylim = c(min(sel_data$MemoryUsage)- (0.2 * min(sel_data$MemoryUsage)), max(sel_data$MemoryUsage)))
p8 <- p7 + theme(legend.key.size = unit(0, 'lines'))
p8
# Save the plot
ggsave("figures/Supplemental Figure 4. Memory usage of GuideMaker for SpCas9, SaCas9, and StCas9.pdf", width = 8, height = 4, units = "in")
ggsave("figures/Supplemental Figure 4. Memory usage of GuideMaker for SpCas9, SaCas9, and StCas9.png", width = 8, height = 4, units = "in")

dev.off()

print("Supplemental Figure 3. Performance of GuideMaker with AVX2 settings.pdf")


##
file.remove("Rplots.pdf")


################## supplement_fig 3 #############
######improvement over AVX2 #########

impdata <- data %>%
  select(Genome, PAM, threads, process_sec, Processor)

## Get summary stat
summarystat <- summarySE(impdata, measurevar="process_sec", groupvars=c("Genome","PAM", "threads","Processor"))
write.csv(summarystat,"ProcessTime.csv")

Gain = impdata %>%
  select(PAM, threads,  Processor, process_sec, Genome) %>%
  group_by(PAM, threads,  Processor, Genome) %>%
  summarise_at(vars(process_sec),list(SumProcessTime = sum, MeanRuntime = mean, SdRuntime=sd)) %>%
  mutate(xx = (SdRuntime/MeanRuntime)^2) %>%
  select(PAM, threads, Genome, Processor, xx) %>%
  spread(Processor,xx) %>%
  mutate(yy = AVX2 + nonAVX2) %>%
  mutate(zz = sqrt(yy))



Gain2 = impdata %>%
  select(PAM, threads,  Processor, process_sec, Genome) %>%
  group_by(PAM, threads,  Processor, Genome) %>%
  summarise_at(vars(process_sec),list(MeanRuntime = mean)) %>%
  spread(Processor,MeanRuntime) %>%
  mutate(MeanRatio = AVX2/nonAVX2) 


Gain3 <- left_join(Gain, Gain2, by =c("PAM", "threads", "Genome")) %>%
  mutate(UQ = MeanRatio * zz)


Gain4 <- impdata %>%
group_by(PAM, threads,  Processor, Genome) %>%
summarise_at(vars(process_sec),list(SumProcessTime = sum)) %>%
arrange(Processor) %>%
spread(Processor,SumProcessTime) %>%
mutate(`Improvement%` = (nonAVX2-AVX2)/nonAVX2 * 100)


Gain5 <- left_join(Gain3, Gain4, by =c("PAM", "threads", "Genome"))
Gain5$threads <- as.factor(Gain5$threads)



# Default bar plot
p<- ggplot(Gain5, aes(x=threads, y=`Improvement%`, fill=as.factor(threads))) + 
  geom_bar(stat="identity", color="black", 
           position=position_dodge()) +
  geom_errorbar(aes(ymin=`Improvement%` - UQ, ymax= `Improvement%`+UQ), width=.2,
                position=position_dodge(.9)) +  theme_bw() + facet_grid(Genome ~ PAM)


p2 <-  p + scale_fill_lancet() +
  xlab("Processor cores") +
  ylab("Improvement % with AVX2") +
  theme(legend.position = "none")

p3 <- p2 + theme(strip.text.y = element_text(size = 6, colour = "black"), 
                 strip.text.x = element_text(size = 12, colour = "black", face="bold"),
                 axis.title.x = element_text(color = "black", size = 12, angle = 0, face="bold"),
                 axis.title.y = element_text(color = "black", size = 12, face="bold"),
                 axis.text.y = element_text(color = "black", size = 10, angle = 0),
                 axis.text.x = element_text(color = "black", size = 10, angle = 0))
p3

ggsave("figures/Supplemental Figure 3. Performance of GuideMaker with AVX2 settings.pdf", width = 8, height = 6, units = "in")
ggsave("figures/Supplemental Figure 3. Performance of GuideMaker with AVX2 settings.png", width = 8, height = 6, units = "in")


dev.off()

print("Supplemental Figure 3. Performance of GuideMaker with AVX2 settings.pdf")


##
file.remove("Rplots.pdf")
