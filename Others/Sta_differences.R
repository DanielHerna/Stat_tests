rm(list = ls())

library(dplyr)
library(ggplot2)
library(ggpubr)

### Set parameters and data set
data<-read.csv('DataNormal.csv')
significance<-0.05

### Some Data set-up and exploration

data1<-na.omit(data[,1])
data1<-as.data.frame(data1)

qqnorm(data1[,1])
ggqqplot(data1[,1])
shapiro.test(data1[,1])
ks.test(data1[,1],"pnorm")

ggplot(data1,aes(data1))+
  geom_histogram()

New<-na.omit(data$New)
data_new<-as.data.frame(New)

qqnorm(data_new$New)
shapiro.test(data_new$New)
ks.test(data_new$New,"pnorm")

### First Q - Difference in means

# The two populations must be normal or approximately normal

Dif_mean<-t.test(x = na.omit(data$Current),y = na.omit(data$New),conf.level = 1-significance)

if_else(Dif_mean$p.value>significance,
        paste0('With a P-value of ',round(Dif_mean$p.value,4),' the means are not stadistically diferent. Alpha at ',significance),
        paste0('With a P-value of ',round(Dif_mean$p.value,4),' the means are stadistically diferent. Alpha at ',significance))

### Second Q - Expected sample size




### Third Q - Difference in scores
# Assumptions
# The two populations must be normal or approximately normal
# The two samples must be randomly sampled from the two populations
# The two proportions must be independent

Dif_scores <- prop.test(x = c(length(data_current), length(data_new)),
                       n = c(length(na.omit(data$Current)),length(na.omit(data$New))),
                       conf.level = 1-significance)

if_else(Dif_scores$p.value>significance,
        paste0('With a P-value of ',round(Dif_scores$p.value,4),' differences are not stadistically diferent. Alpha at ',significance),
        paste0('With a P-value of ',round(Dif_scores$p.value,4),' differences are stadistically diferent. Alpha at ',significance))

### Fourth Q - Required difference

# Z-score = (P1 - P2)/SQRT[P*(1-P)]*SQRT[(1/N1) + (1/N2)]
# Z-score = (P1 - P2)/SQRT[P*(1-P)]*SQRT[(1/N1) + (1/N2)]
# see excel

T2B_current
T2B_new

Z_score<-qnorm(.95)
pnorm(1.644854)

# with E1: P1=0.847583643 & P2=0.793058395
# with E1: P1=0.873090649 & P2=0.818565401
# Difference should be at least 0.054525248 (5.4525248%)

# How this value change depending on N and proportion (Visualize)
# Marginal error T2B score, Same calculation for the mean.
# Sections and Easy to use, create a document explaining. 
# Other stats test, anova test.


