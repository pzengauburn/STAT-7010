######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-12
######################################################################

######################################################################
# draw O.C. Curve for one-sample t-test    
######################################################################

n = 19                             # = n1 + n2 - 1 
alpha = 0.05                       # significance level 
d = seq(0, 3, by = 0.1)            # effect size 
nc = d * sqrt(n) 
rlow  = qt(    alpha/2, df = n-1)
rhigh = qt(1 - alpha/2, df = n-1)
prob = pt(rhigh, df = n-1, ncp = nc) - pt(rlow, df = n-1, ncp = nc)

plot(d, prob, type = "l", ylim = c(0, 1), 
     xlab = "d", ylab = "Probability of accepting H0") 

######################################################################
# install package pwr if it not available   
######################################################################

install.packages("pwr")

######################################################################
# calculate power  
######################################################################

library(pwr)
# compute power for given n and d 
pwr.t.test(n = 10, d = 2, sig.level = 0.05, type = "two.sample", 
           alternative = "two.sided")

# compute n for given power and d
pwr.t.test(power = 0.95, d = 2, sig.level = 0.05, type = "two.sample", 
           alternative = "two.sided")

# compute d for given n and power 
pwr.t.test(n = 10, power = 0.95, sig.level = 0.05, type = "two.sample", 
           alternative = "two.sided")

######################################################################
# THE END
######################################################################
