######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/wine.txt"
wine = read.table(filename, header = TRUE)
str(wine) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

wine$wine = factor(wine$wine)
wine$judge = factor(wine$judge)

fit.aov = aov(score ~ wine + judge, data = wine)
summary(fit.aov)

######################################################################
# repeated measues 
######################################################################

library(lme4)
fit = lmer(score ~ wine + (1|judge), data = wine)
summary(fit) 

######################################################################
# THE END
######################################################################
