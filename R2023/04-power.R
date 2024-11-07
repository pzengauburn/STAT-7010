######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-25 
######################################################################

######################################################################
# calculate power  
######################################################################

library(pwr)

mu = matrix(c(14, 16, 21, 10, 15, 16), nrow = 2, byrow = TRUE)
a = 2; b = 3; n = 10; 
sigma = 5 

# power for testing variety 

mean.variety = rowMeans(mu)
tau = mean.variety - mean(mean.variety)

df1 = a - 1
df2 = a * b * (n-1)
effect.size = sqrt(sum(tau^2) / a) / sigma
pf(qf(0.95, df1, df2), df1, df2, ncp = effect.size^2 * a * b * n, lower.tail = FALSE)

# power for testing exposure 

mean.exposure = colMeans(mu)
beta = mean.exposure - mean(mean.exposure)

df1 = b - 1
df2 = a * b * (n-1)
effect.size = sqrt(sum(beta^2) / b) / sigma
pf(qf(0.95, df1, df2), df1, df2, ncp = effect.size^2 * a * b * n, lower.tail = FALSE)

# power for testing interactions 

tau.beta = sweep(sweep(mu, 1, mean.variety, "-"), 2, mean.exposure, "-") + mean(mu)
df1 = (a - 1) * (b - 1)
df2 = a * b * (n - 1)
effect.size = sqrt(sum(tau.beta^2) / a / b) / sigma 
pf(qf(0.95, df1, df2), df1, df2, ncp = effect.size^2 * a * b * n, lower.tail = FALSE)

######################################################################
# calculate power - alternative approach  
######################################################################

n = c(2, 3, 4) 
a = 3; b = 3; sigma = 25;  D = 40
df1 = b - 1
df2 = a * b * (n - 1)
effect.size = D / sigma / sqrt(2 * b)
pf(qf(0.95, df1, df2), df1, df2, ncp = effect.size^2 * a * b * n, lower.tail = FALSE)

######################################################################
# THE END
######################################################################
