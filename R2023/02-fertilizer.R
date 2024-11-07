######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-12
######################################################################

######################################################################
# select a random order 
######################################################################

trt = c(rep("A", 5), rep("B", 6))
sample(trt, replace = FALSE) 

######################################################################
# data analysis - summary 
######################################################################

trt = c("A", "A", "B", "B", "A", "B", "B", "B", "A", "A", "B") 
yields = c(29.9, 11.4, 26.6, 23.7, 25.3, 28.5, 14.2, 17.9, 16.5, 21.1, 24.3) 
fertilizer = data.frame(trt = trt, yields = yields) 

# descriptive statistics 
aggregate(yields ~ trt, data = fertilizer, summary) 
aggregate(yields ~ trt, data = fertilizer, length) 
aggregate(yields ~ trt, data = fertilizer, sd) 

# side-by-side boxplot 
boxplot(yields ~ trt, data = fertilizer)

######################################################################
# manual calculation
######################################################################

meanA = mean( fertilizer$yields[fertilizer$trt == "A"] )
meanB = mean( fertilizer$yields[fertilizer$trt == "B"] )
sdA = sd( fertilizer$yields[fertilizer$trt == "A"] )
sdB = sd( fertilizer$yields[fertilizer$trt == "B"] )
nA = length( fertilizer$yields[fertilizer$trt == "A"] )
nB = length( fertilizer$yields[fertilizer$trt == "B"] )

sd.pool = sqrt( ((nA - 1) * sdA^2  + (nB - 1) * sdB^2) / (nA + nB - 2) )
t0 = (meanB - meanA) / ( sd.pool * sqrt(1/nA + 1/nB) )
p.value = pt(t0, df = 9, lower = FALSE)

SE = sd.pool * sqrt(1/nA + 1/nB) 
CI.lower = meanB - meanA - qt(0.975, df = 9) * SE
CI.upper = meanB - meanA + qt(0.975, df = 9) * SE

######################################################################
# two-sample t-test 
######################################################################

# test the equality of variances
var.test(yields ~ trt, data = fertilizer)

# two-sample t-test (assuming equal variance)
t.test(yields ~ trt, data = fertilizer, alternative = "less", var.equal = TRUE)

######################################################################
# permutation test 
######################################################################

# permutation test 
trtA = fertilizer$yields[fertilizer$trt == "A"]
trtB = fertilizer$yields[fertilizer$trt == "B"]
diff.data = mean(trtB) - mean(trtA)

allchoice = combn(1:11, 5)
diff.perm = numeric(ncol(allchoice))
for(i in 1:ncol(allchoice))
{
   trtA = fertilizer$yields[ allchoice[, i]]
   trtB = fertilizer$yields[-allchoice[, i]]
   diff.perm[i] = mean(trtB) - mean(trtA)
}

hist(diff.perm, 40, main = "Difference of Means", xlab = "")
abline(v = diff.data, col = "red")

sum(diff.perm >= diff.data)
mean(diff.perm >= diff.data)   # p-value = 0.3333

######################################################################
# THE END
######################################################################
