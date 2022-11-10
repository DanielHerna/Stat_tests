rm(list = ls())

#-------------------------------------- Run all the libraries -----------------------------------------------------

library('dplyr')
library('mosaic')

#-------------------------------------- Only for normal data -----------------------------------------------------
#-------------------------------------- Parameters to change -----------------------------------------------------

alpha<-0.1

#------------------------------ run this code, data must be nx4, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')

group_1<-data[,3]
group_2<-data[,4]

sample_size1=length(group_1)
sample_size2=length(group_2)

p1<-tally(~data[,3],data=data, format='prop')[2]
p2<-tally(~data[,4],data=data, format='prop')[2]

test<-t.test(group_1, group_2, conf.level=1-alpha)

cat('With a p value of',round(test$p.value,6),if_else(test$p.value<alpha,'proportions are statistically different','proportions are not statistically different'),'\n')
if_else(test$p.value<alpha,paste0('The difference oscillate between ',min(round(abs(test$conf.int[1]),4)*100,round(abs(test$conf.int[2]),4)*100),'% and ',max(round(abs(test$conf.int[1]),4)*100,round(abs(test$conf.int[2]),4)*100),'%'),'The difference is equal to 0')
Z_score<-qnorm(p=alpha/2, lower.tail=FALSE)

# compute ME and CI for each proportion
ME1<-Z_score*sqrt((p1*(1-p1))/sample_size1)
cat('The margin of error of proportion one is',round(ME1,4)*100,'%\n')
cat('The confidence interval of the proportion one is from',round(p1-ME1,4)*100,'%', 'to', round(p1+ME1,4)*100,'%\n')

ME2<-Z_score*sqrt((p2*(1-p2))/sample_size2)
cat('The margin of error of proportion two is',round(ME2,4)*100,'%\n')
cat('The confidence interval of the proportion two is from',round(p2-ME2,4)*100,'%', 'to', round(p2+ME2,4)*100,'%\n')

#-------------------------------------- Bootstrap for non-normal data ----------------------------------------------
#-------------------------------------- Parameters to change -------------------------------------------------------
rm(list = ls())

alpha=0.1             #Level of significance
iterations<-10000

#------------------------------ run this code, data must be dim nx4, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')

segment1<-data[,2]*data[,3]
segment2<-data[,2]*data[,4]

data$segment1<-segment1
data$segment2<-segment2

prop_1<-tally(~segment1,data=data,format='prop')[2]
prop_2<-tally(~segment2,data=data,format='prop')[2]
t_test<-abs(prop_1-prop_2)

bootstrap_dist_1<-do(iterations)*rflip(nrow(data),prop_1)
bootstrap_dist_2<-do(iterations)*rflip(nrow(data),prop_2)

diff_prop<-abs(bootstrap_dist_1$prop-bootstrap_dist_2$prop)
p_value<-mean(diff_prop>=t_test)

cat('The observed difference in proportions is',t_test,'\n')
cat('With a P-value of', p_value,'\n')
if_else(p_value>alpha,'Proportions are not statistically different','Proportions are statistically different')

# confidence intervals for each proportion

bootstrap_dist_1<-do(iterations)*rflip(nrow(data),prop_1)
bootstrap_dist_2<-do(iterations)*rflip(nrow(data),prop_2)

par(mfrow=c(1,2))

qqnorm(bootstrap_dist_1$prop,main='qq plot proportion 1'); qqline(bootstrap_dist_1$prop, col = 2)
qqnorm(bootstrap_dist_1$prop,main='qq plot proportion 2'); qqline(bootstrap_dist_1$prop, col = 2)

range<-quantile(sort(bootstrap_dist_1$prop),c(alpha/2,1-alpha/2))
cat('The confidence interval for the proportion one is from',round(range[1],6)*100,'% to',round(range[2],6)*100,'%\n')
cat('The margin of error is',round(prop_1-range[1],6)*100,'%')

range<-quantile(sort(bootstrap_dist_2$prop),c(alpha/2,1-alpha/2))
cat('The confidence interval for the proportion two is from',round(range[1],6)*100,'% to',round(range[2],6)*100,'%\n')
cat('The margin of error is',round(prop_2-range[1],6)*100,'%')

dev.off()
