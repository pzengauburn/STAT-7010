######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-18
######################################################################

######################################################################
# calculate power  
######################################################################

library(pwr)

mu = c(11, 12, 15, 18, 19)
a = length(mu)
tau = mu - mean(mu) 
sigma = 3

effect.size = sqrt(sum(tau^2) / a) / sigma
pwr.anova.test(k = 5, n = 4, f = effect.size, sig.level = 0.01) 

pwr.anova.test(k = 5, n = c(3, 4, 5, 6, 7), f = effect.size, sig.level = 0.01) 

######################################################################
# what matters is the effect size  
######################################################################

tau = c(-4, -3, 0, 3, 4)
a = length(tau) 
sigma = 3

effect.size = sqrt(sum(tau^2) / a) / sigma
pwr.anova.test(k = 5, n = 3:7, f = effect.size, sig.level = 0.01) 

tau = c(-4/3, -1, 0, 1, 4/3)
a = length(tau) 
sigma = 1

######################################################################
# alternate approach 
######################################################################

a = 5
D = 8 
sigma = 3

effect.size = D / sqrt(2 * a) / sigma
pwr.anova.test(k = 5, n = 3:7, f = effect.size, sig.level = 0.01) 

######################################################################
# THE END
######################################################################
