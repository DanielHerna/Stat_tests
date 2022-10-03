### WHTA THE CODE DOES ###
### BE MORE SPECIFIC ###
### BE MORE user friendly ###
### Example file - unit test (Important) Like the TRUF juice examples ###
### Use the unit test as a QA ###

rm(list=ls())

library(dplyr)
library(ggpubr)

##### Set up parameters #####

significance<-0.05
{

  set.seed(1914)
  sim_data<-rnorm(n=1000)
  sim_data2<-rnorm(n=1000,mean = 500,sd = 20)
}

data<-data.frame(sim_data,sim_data2)

##### Normality test #####

ggqqplot(data = data[,1],title = "Q-Q plot first variable")
ggqqplot(data = data[,2],title = "Q-Q plot second variable")

# Null hypothesis for shapiro and Kolmogorov test: Data is normally distributed

shapiro=shapiro.test(data[,1])
Kolmogorov=ks.test(x=data[,1], y = data[,2])

if_else(shapiro$p.value<significance & Kolmogorov$p.value<significance,
        'Data is NOT normally distributed','Data is normally distributed')

###### Case 1. Normal Data ######

##### Difference in means - t test only normal data

# Null hypothesis for t-test: Means are the same - unknow population sd 

Dif_mean<-t.test(x = na.omit(data[,1]),y = na.omit(data[,2]),conf.level = 1-significance)

if_else(Dif_mean$p.value>significance,
        paste0('With a P-value of ',round(Dif_mean$p.value,4),' the means are not stadistically diferent. Alpha at ',significance),
        paste0('With a P-value of ',round(Dif_mean$p.value,4),' the means are stadistically diferent. Alpha at ',significance))

Dif_mean$estimate
Dif_mean$conf.int

SE <- sqrt((var(data[,1])/length(data[,1]))+(var(data[,2])/length(data[,2])))
crit_val <- qt(p=significance/2, df=Dif_mean$parameter, lower.tail=FALSE)
margin_error <- crit_val*SE

# If means are equal: Required difference, changing X1

t_crit <- qt(significance/2,df = Dif_mean$parameter,lower.tail = FALSE)

X1<-(t_crit*sqrt((var(data[,1])/length(data[,1])) + ((var(data[,2]))/length(data[,2]))))+mean(data[,2])
X1

# If means are equal: Required difference, changing X2

X2<- ((mean(data[,1]) - (t_crit*sqrt((var(data[,1])/length(data[,1])) + ((var(data[,2]))/length(data[,2]))))))
X2

##### Expected sample size - diagnostics

set.seed(1918)

resp <- 500
options <- 10
stimulus <- 2

exp <- function(respondents,options,stimulus){
  
  exposures<-respondents*stimulus/options
}

exposures <- round(exp(resp,options,stimulus),0)

diag_data <- rnorm(exposures)
length(diag_data)
metric <- mean(diag_data) # mean, scores, this could be replace with any value

crit_val <- qt(p=significance/2, df=exposures-1, lower.tail=FALSE)
margin_of_error <- crit_val * sqrt(var(diag_data)/length(diag_data))

CI <- c(metric-margin_of_error,metric+margin_of_error)
CI

resp_up<-2000
diag_data_up <- rnorm(resp_up)
margin_of_error_up <- crit_val * sqrt(var(diag_data_up)/resp_up)
metric_up <- mean(diag_data_up)

CI_up <- c(metric_up-margin_of_error_up,metric_up+margin_of_error_up)
CI_up

# T2B of 65% with a margin error of 0.04 means that the t2B varies from 61% to 69%

##### Difference in scores, proportions etc.

data<-read.csv('test2.csv')

dataA<-na.omit(data[,1])
dataA<-data.frame(dataA)

dataB<-na.omit(data[,2])
dataB<-data.frame(dataB)

dataA_t2b<-dataA%>%filter(dataA>3)
dataB_t2b<-dataB%>%filter(dataB>3)

Dif_scores <- prop.test(x = c(nrow(dataA_t2b), nrow(dataB_t2b)),
                        n = c(nrow(dataA),nrow(dataB)),
                        conf.level = 1-significance)

# include line 

Dif_scores$conf.int
ME <- (Dif_scores$estimate[1]-Dif_scores$estimate[2])-Dif_scores$conf.int[2]

##### Fourth Q - Required difference

Z_score<-qnorm(1-significance)

pnorm(q = 0)

# function: 

# Z-score = (P1 - P2)/SQRT[P*(1-P)]*SQRT[(1/N1) + (1/N2)]
# Z-score = (P1 - P2)/SQRT[P*(1-P)]*SQRT[(1/N1) + (1/N2)]
# see excel

# with E1: P1=0.847583643 & P2=0.793058395
# with E1: P1=0.873090649 & P2=0.818565401
# Difference should be at least 0.054525248 (5.4525248%)

##### TODO (Discuss with Kirill and Juan) #####
# Sections and Easy to use, create a document explaining. 
# Other stats test, anova test. (t and z seems to be enough for normal data.)
# For non normal data use bootstrap (TODO) and non parametric techniques: 

# Mann-WhitneyU = t test
# Wilcoxon signed rank = paired t test
# Kruskal-Wallis tests = one-w Anova




