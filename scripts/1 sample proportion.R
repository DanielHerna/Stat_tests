rm(list = ls())

#-------------------------------------- Run all the libraries -----------------------------------------------------

library('dplyr')
library('mosaic')

#-------------------------------------- Only for normal data -----------------------------------------------------
#-------------------------------------- Parameters to change -----------------------------------------------------

p0<-0.6          #Hypothesized propotion, value to compare
alpha=0.1        #Level of significance

#------------------------------ run this code, data must be dim nx2, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')
sample_size<-nrow(data)

proportion<-table(data[,2])
proportion<-prop.table(proportion)
p<-proportion['1']

os_test<-prop.test(x=p, n=sample_size, p=p0, alternative="two.sided", conf.level = 1-alpha)
cat('with a p value of',round(os_test$p.value,6),if_else(os_test$p.value<alpha,'the proportion is different from the hypothesis','the proportion is not different from the hypothesis'),'\n')

Z_score<-qnorm(p=alpha/2, lower.tail=FALSE)
ME<-Z_score*sqrt((p*(1-p))/sample_size)
cat('The margin of error is ',round(ME,4)*100,'%\n')
cat('The confidence interval of the proportion is from',round(p-ME,4)*100,'%', 'to', round(p+ME,4)*100,'%')

#-------------------------------------- Bootstrap for non-normal data ----------------------------------------------
#-------------------------------------- Parameters to change -----------------------------------------------------
rm(list = ls())

alpha<-0.1
iterations<-10000

#------------------------------ run this code, data must be dim nx2, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')

proportion<-tally(~data[,2],data=data,format='prop')[2]
bootstrap_dist<-do(iterations)*rflip(nrow(data),proportion)

par(mfrow=c(1,2))

qqnorm(bootstrap_dist$prop); qqline(bootstrap_dist$prop, col = 2)
hist(bootstrap_dist$prop,main='Histogram of the proportion')

range<-quantile(sort(bootstrap_dist$prop),c(alpha/2,1-alpha/2))
cat('The observed proportion is',round(proportion,6)*100,'%\n')
cat('The confidence interval for the proportion is from',round(range[1],6)*100,'% to',round(range[2],6)*100,'%\n')
cat('The margin of error is',round(proportion-range[1],6)*100,'%')

dev.off()


















