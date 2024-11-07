######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-12
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/ex.txt"
ex = read.table(filename, header = TRUE)
str(ex) 

######################################################################
# ANOVA, ignoring covariate 
######################################################################

ex$Af = factor(ex$A)
ex$Bf = factor(ex$B)
ex$Cf = factor(ex$C)

fitlm0 = lm(y ~ Af * Bf * Cf, data = ex)
summary(fitlm0)
anova(fitlm0)

fitlm1 = lm(y ~ A + B + C + A:B + A:C, data = ex)
summary(fitlm1)
anova(fitlm1)

par(mfrow = c(2, 2))
plot(fitlm1)

######################################################################
# ANOVA with covariate 
######################################################################

fitlm2 = lm(y ~ Af * Bf * Cf + x, data = ex)
summary(fitlm2)
anova(fitlm2)

fitlm3 = lm(y ~ A * B + x, data = ex)
summary(fitlm3)
anova(fitlm3)

par(mfrow = c(2, 2))
plot(fitlm3)

######################################################################
# THE END
######################################################################
