######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/cupcake.csv"
cupcake = read.csv(filename)
str(cupcake) 

cupcake$rep = factor(cupcake$rep)

######################################################################
# completely randomized design 
######################################################################

fit1 = lm(volume ~ recipe * temp, data = cupcake)
anova(fit1)

######################################################################
# completely randomized block design 
######################################################################

fit2 = lm(volume ~ recipe * temp + rep, data = cupcake)
anova(fit2)

######################################################################
# split-plot design I 
######################################################################

cupcake$oven = paste0(cupcake$temp, cupcake$rep)

fit3 = lm(volume ~ recipe * temp + oven, data = cupcake)
anova(fit3)

######################################################################
# split-plot design II 
######################################################################

fit4 = lm(volume ~ recipe * temp + rep + oven, data = cupcake)
anova(fit4)

######################################################################
# strip-plot design 
######################################################################

cupcake$batch = paste0(cupcake$recipe, cupcake$rep)

fit5 = lm(volume ~ recipe * temp + rep + oven + batch, data = cupcake)
anova(fit5)

######################################################################
# THE END
######################################################################
