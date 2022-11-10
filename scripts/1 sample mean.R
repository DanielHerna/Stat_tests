rm(list = ls())

#-------------------------------------- Run all the libraries -----------------------------------------------------

library('dplyr')
library('mosaic')

#-------------------------------------- Only for normal data -----------------------------------------------------
#-------------------------------------- Parameters to change -----------------------------------------------------

M0<-40          #Hypothesized mean, value to compare
alpha=0.1       #Level of significance

#------------------------------ run this code, data must be nx2, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')
sample_size<-nrow(data)

M<-data[,2]

test<-t.test(M, mu = M0, conf.level = 1-alpha)
cat('with a p value of',round(test$p.value,6),if_else(test$p.value<alpha,'the mean is different from the hypothesized mean','the mean is not different from the hypothesized mean'),'\n')

cat('The margin of error is ',mean(M)-test$conf.int[1],'\n')
cat('The confidence interval of the proportion is from',round(test$conf.int[1],2), 'to',round(test$conf.int[2],2))

#-------------------------------------- Bootstrap for non-normal data ----------------------------------------------
#-------------------------------------- Parameters to change -------------------------------------------------------
rm(list = ls())

alpha=0.1       #Level of significance
iterations<-10000

#------------------------------ run this code, data must be dim nx2, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')

M<-mean(~data[,2],data=data) 
bootstrap_dist<-do(iterations)*mean(~data[,2],data=resample(data))

par(mfrow=c(1,2))

qqnorm(bootstrap_dist$mean); qqline(bootstrap_dist$mean, col = 2)
hist(bootstrap_dist$mean, main='Histogram of the mean')

dev.off()

range<-quantile(sort(bootstrap_dist$mean),c(alpha/2,1-alpha/2))
cat('The confidence interval for the proportion is from',round(range[1],4),'to',round(range[2],6),'\n')
cat('The margin of error is ',M-range[1])


