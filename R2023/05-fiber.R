######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-12
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/fiber.txt"
fiber = read.table(filename, header = TRUE)
str(fiber) 

######################################################################
# ANOVA, ignoring x 
######################################################################

fiber$machine = factor(fiber$machine)
fitlm0 = lm(y ~ machine, data = fiber)
anova(fitlm0)

######################################################################
# ANOVA with x 
######################################################################

fitlm = lm(y ~ machine + x, data = fiber)
anova(fitlm)

fitlm2 = lm(y ~ x + machine, data = fiber)
anova(fitlm2)

######################################################################
# testing machine
######################################################################

fit.x = lm(y ~ x, data = fiber)
anova(fit.x, fitlm)

######################################################################
# ANOVA on x,  to check independence of treatments and covariates
######################################################################

fitlm3 = lm(x ~ machine, data = fiber)
anova(fitlm3)

######################################################################
# model diagnoistic 
######################################################################

par(mfrow = c(2, 2))
plot(fitlm)

######################################################################
# THE END
######################################################################
