######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/pulp.txt"
pulp = read.table(filename, header = TRUE)
str(pulp) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

pulp$day = factor(pulp$day)
pulp$temp = factor(pulp$temp)
pulp$method = factor(pulp$method)

fitlm = lm(y ~ day * temp * method, data = pulp)
anova(fitlm)

fitlm2 = lm(y ~ day + method + day:temp + temp + temp:method, data = pulp)
anova(fitlm2)

######################################################################
# ANOVA --- mixed effects   
######################################################################

fit.aov = aov(y ~ method * temp + Error(day/method), data = pulp)
summary(fit.aov)

library(lme4) 
fit.random = lmer(y ~ method * temp + (1|day) + (1|day:method), data = pulp)
summary(fit.random)

######################################################################
# THE END
######################################################################
