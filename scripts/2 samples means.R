rm(list = ls())

#-------------------------------------- Run all the libraries -----------------------------------------------------

library('dplyr')
library('mosaic')

#-------------------------------------- Only for normal data -----------------------------------------------------
#-------------------------------------- Parameters to change -----------------------------------------------------

alpha<-0.1

#------------------------------ run this code, data must be nx4, ID and the numerical variable --------------------

data<-read.csv(file.choose(),sep = ',')

segment_1<-data[,3]*data[,2]
segment_2<-data[,4]*data[,2]

segment_1<-segment_1[segment_1>0]
segment_2<-segment_2[segment_2>0]

sample_size1<-length(segment_1)
sample_size2<-length(segment_2)

M1<-mean(segment_1)
M2<-mean(segment_2)

test<-t.test(segment_1, segment_2, conf.int = 1-alpha) 

if_else(test$p.value<alpha,paste0('The difference oscillate between ',min(round(abs(test$conf.int[1]),4)*100,round(abs(test$conf.int[2]),4)*100),'% and ',max(round(abs(test$conf.int[1]),4)*100,round(abs(test$conf.int[2]),4)*100),'%'),'The difference of means is equal to 0')
cat('With a p value of',round(test$p.value,6),if_else(test$p.value<alpha,'means are statistically different','means are not statistically different'),'\n')

Z_score<-qnorm(p=alpha/2, lower.tail=FALSE)

# compute ME and CI for each mean

ME1<-Z_score*(sd(segment_1)/sqrt(sample_size1))
cat('The mean for segment one is ',round(M1,4), '\n')
cat('The confidence interval of mean for segment one is from',round(M1-ME1,4), 'to', round(M1+ME1,4),'\n')
cat('The margin of error of the segment one is',round(ME1,4),'\n')

ME2<-Z_score*(sd(segment_2)/sqrt(sample_size2))
cat('The mean for segment two is ',round(M2,4), '\n')
cat('The confidence interval of mean for segment two is from',round(M2-ME2,4), 'to', round(M2+ME2,4),'\n')
cat('The margin of error of the segment two is',round(ME2,4),'\n')

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

segment1<-segment1[segment1>0]
segment2<-segment2[segment2>0]

mean_1<-mean(segment1)
mean_2<-mean(segment2)
t_test<-abs(mean_1-mean_2)

boot_mean_segment1<-matrix(sample(segment1, size=max(length(segment1),length(segment2))*iterations,replace = TRUE), nrow=max(length(segment1),length(segment2)), ncol=iterations)
boot_mean_segment2<-matrix(sample(segment2, size=max(length(segment1),length(segment2))*iterations,replace = TRUE), nrow=max(length(segment1),length(segment2)), ncol=iterations)

diff_means<-abs(boot_mean_segment1-boot_mean_segment2)
diff_means_vector<-c(diff_means)

p_value<-mean(diff_means_vector>=t_test)

cat('With a P-value of', p_value,if_else(p_value>alpha,'Means are not statistically different','Means are statistically different'),'\n')

# interval of confidence

set_segment1<-data.frame(participant_id=data[,1]*data[,3],var=data[,2]*data[,3])
set_segment1<-set_segment1[apply(set_segment1,1, function(x) all(x!=0)),]

bootstrap_dist<-do(iterations)*mean(~var,data=resample(set_segment1))

par(mfrow=c(1,2))
qqnorm(bootstrap_dist$mean); qqline(bootstrap_dist$mean, col = 2)
hist(bootstrap_dist$mean, main='Histogram of the mean sample 1')

range<-quantile(sort(bootstrap_dist$mean),c(alpha/2,1-alpha/2))
cat('observed',mean_1,'\n')
cat('The confidence interval for the proportion is from',round(range[1],4),'to',round(range[2],6),'\n')
cat('The margin of error is ',mean_1-range[1])

dev.off()


set_segment2<-data.frame(participant_id=data[,1]*data[,4],var=data[,2]*data[,4])
set_segment2<-set_segment2[apply(set_segment2,1, function(x) all(x!=0)),]

bootstrap_dist<-do(iterations)*mean(~var,data=resample(set_segment2))

par(mfrow=c(1,2))
qqnorm(bootstrap_dist$mean); qqline(bootstrap_dist$mean, col = 2)
hist(bootstrap_dist$mean, main='Histogram of the mean sample 2')

range<-quantile(sort(bootstrap_dist$mean),c(alpha/2,1-alpha/2))
cat('observed',mean_1,'\n')
cat('The confidence interval for the proportion is from',round(range[1],4),'to',round(range[2],6),'\n')
cat('The margin of error is ',mean_1-range[1])

dev.off()







