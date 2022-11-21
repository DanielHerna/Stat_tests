source("functions.R")

#### One Sample Proportion ####

onePopProp(data = read.csv("Test data/1 sample proportion.csv"), 
           CL = 0.90, 
           iterations = 10000)


# I can generate data based on n and p

n = 1000
p = .76
  
ids <- seq(1, n)
resps <- c(rep(1,p*n), rep(0,(1-p)*n))

data = tibble(Participant_id = ids,
              Variable = resps)

onePopProp(data = data, 
           CL = 0.90, 
           iterations = 10000)

#### Two Sample Proportion ####

# TBA