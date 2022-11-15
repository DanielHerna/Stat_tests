source("functions.R")

# One Sample Proportion

onePopProp(data = read.csv("Test data/1 sample proportion.csv"), 
           CL = 0.90, 
           iterations = 10000)

