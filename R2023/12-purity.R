######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/purity.txt"
purity = read.table(filename, header = TRUE)
str(purity) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

purity$supplier = factor(purity$supplier)
purity$batch = factor(purity$batch)

fitlm = lm(purity ~ supplier + supplier/batch, data = purity)
anova(fitlm)

######################################################################
# ANOVA --- both random effects --- different from slides 
######################################################################

library(lme4) 
fit.random = lmer(purity ~ (1 | supplier/batch), data = purity)
summary(fit.random)

library(nlme)
fit.random2 = lme(purity ~ 1, random = ~1 | supplier/batch, data = purity)
summary(fit.random2)

######################################################################
# THE END
######################################################################
