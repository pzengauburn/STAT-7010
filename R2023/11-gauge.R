######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/gauge.txt"
gauge = read.table(filename, header = TRUE)
str(gauge) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

gauge$part = factor(gauge$part)
gauge$operator = factor(gauge$operator)

fitlm = lm(resp ~ part * operator, data = gauge)
anova(fitlm)

######################################################################
# ANOVA --- random effects 
######################################################################

library(lme4)
fit.random = lmer(resp ~ (1|part) + (1|operator) + (1|part:operator), data = gauge)
summary(fit.random)

######################################################################
# refined ANOVA --- random effects 
######################################################################

fit.random2 = lmer(resp ~ (1|part) + (1|operator), data = gauge)
summary(fit.random2)

######################################################################
# ANOVA --- mixed effects (random part, fixed operator)
######################################################################

fit.mixed = lmer(resp ~ operator + (1|part) + (1|part:operator), data = gauge)
summary(fit.mixed)

######################################################################
# THE END
######################################################################
