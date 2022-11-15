#' Stat functions for Conjointly
#' Started Nov 2022

library('dplyr')
library('mosaic')

onePopProp <- function(data = read.csv("1 sample proportion.csv"), CL = 0.10, iterations = 10000) {
 #' onePopProp takes in a data set of two columns with headers, "participant_id" and 0/1s
 #' Prints summary, nothing is returned
 #' 

  sample_size <- nrow(data)
  alpha <- 1 - CL
  
  # ---------- Traditional approach ----------
  proportion <- table(data[,2])
  proportion <- prop.table(proportion)
  p <- proportion['1']

  Z_score <- qnorm(p = alpha/2, lower.tail = FALSE)
  MOE <- Z_score*sqrt((p*(1-p)) / sample_size)
  paste0('The margin of error is ±', round(MOE, 4) * 100, '%')
  paste0('The confidence interval of the proportion is from ', round(p-MOE,4) * 100, '%', ' to ', round(p+MOE , 4) * 100, '%')
  
  # summary
  paste0(colnames(data)[2], "\n", 
         "n = ", sample_size, "\n",
         "p = ", round(p, 4) * 100, "%\n",
         "CL = ", round((1 - alpha) * 100,2), "%", "\n",
         "-------- Traditional -------- \n",
         "MOE = ±", round(MOE, 4) * 100, "%\n",
         "CI = ", round(p - MOE, 4) * 100, "%", " to ", round(p + MOE , 4) * 100, "%") %>% cat()
  
  # ---------- Bootstrap approach ----------
  bootstrap_dist <- do(iterations) * rflip(nrow(data), p)
  range <- quantile(sort(bootstrap_dist$prop), c(alpha/2, 1-alpha/2))

  paste0("\n-------- Bootstrap -------- \n",
         "MOE = ±", round(p-range[1], 4) * 100, "%\n",
         "CI = ", round(range[1], 4) * 100, "%", ' to ', round(range[2] , 4) * 100, "%\n",
         "(after ", format(iterations, nsmall=0, big.mark=",")," iterations)") %>% cat()
}