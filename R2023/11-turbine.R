######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/turbine.txt"
turbine = read.table(filename, header = TRUE)
str(turbine) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

turbine$temp = factor(turbine$temp)
turbine$operator = factor(turbine$operator)
turbine$gauge = factor(turbine$gauge)

fitlm = lm(y ~ temp * operator * gauge, data = turbine)
anova(fitlm)

######################################################################
# ANOVA --- mixed effects 
######################################################################

library(lme4) 
fit.mixed = lmer(y ~ temp + (1|operator)  + (1|gauge)  + (1|operator:gauge) + 
                     (1|temp:operator) + (1|temp:gauge) + (1|temp:operator:gauge), data = turbine)
summary(fit.mixed)

######################################################################
# THE END
######################################################################
