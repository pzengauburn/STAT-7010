######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/bloodflow.txt"
bloodflow = read.table(filename, header = TRUE)
str(bloodflow) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

bloodflow$A = factor(bloodflow$A)
bloodflow$B = factor(bloodflow$B)
bloodflow$person = factor(bloodflow$person)

fit.aov = aov(y ~ A * B + person, data = bloodflow)
summary(fit.aov)

######################################################################
# repeated measeures
######################################################################

library(lme4)
fit.random = lmer(y ~ A * B + (1|person), data = bloodflow)
summary(fit.random)

######################################################################
# THE END
######################################################################
