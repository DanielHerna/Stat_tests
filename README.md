# Stat testing Survey and conjoint results

## Survey data (Questions or other metrics such as response time)

### [TAB] 1-sample proportions

**Inputs**
- sample size
- proportion
- confidence level (defult = 0.90)
- For bootstrap: raw data: 1-column w/ header row

**Outputs** One for bootstrap, one for traditional
- Margin or Error
- Confidence interval plus/minus

### [TAB] 1-sample Means

**Inputs**
- Full data (default)
  - Raw column of value, from which we compute sample size, mean, and standard deviation
- confidence level (defult = 0.90)

**Outputs** One for bootstrap, one for traditional
- Margin or Error
- Confidence level

### [TAB] 2-sample: proportions compared between two segments

**Inputs**
- sample size for each of two segments
- proportions for each segment
- confidence level (defult = 0.90)

**Outputs**
- result of significance test
- p-value
- Margin or Error for each proportion
- Confidence level for each proportion
- (Maybe need to remove - might be confusing) required difference for significance

**Questions**
1. How will we test for and adjust for data that violate the test assumptions?
2. How do we conduct this type of test in reports currently?
3. Add visual to outputs?

### [TAB] 2-sample: means compared between two segments

**Inputs**
- Full data (default)
  - Raw columns of values, from which we compute sample size, mean, and standard deviation,
- Via statistics (optionally)
  - sample sizes for each segment
  - means
  - standard deviations
- confidence level (defult = 0.90)

**Outputs**
- result of significance test
- p-value
- Margin or Error for each mean
- Confidence level for each mean
- (Maybe need to remove - might be confusing) required difference for significance

**Questions**
1. How will we test for and adjust for data that violate the test assumptions? E.g. non-normal data. 
2. How important is adjusting for non-normal data, can we just ignore it for now, and still achieve something useful?
3. How do we conduct this type of test in reports currently?
4. Add visual to outputs?


### [TAB] Estimated sample size for diagnostics

**Inputs**

**Outputs**

### [TAB] (maybe) Claims score 

**Inputs**

**Outputs**

### [TAB] (maybe) Prefrence share simulation shares between two segments (or should this just be the same as 2-sample proportion test above?) 

**Inputs**

**Outputs**
