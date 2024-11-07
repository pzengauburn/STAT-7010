######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/propellant.txt"
propellant = read.table(filename, header = TRUE)
str(propellant) 

######################################################################
# Latin square  
######################################################################

propellant$material = factor(propellant$material)
propellant$operator = factor(propellant$operator)
propellant$trt = factor(propellant$trt)

fitlm = lm(resp ~ trt + material + operator, data = propellant)
anova(fitlm)

fitaov = aov(resp ~ trt + material + operator, data = propellant)
TukeyHSD(fitaov)

######################################################################
# check model assumptions
######################################################################

par(mfrow = c(2, 2))
plot(fitlm)

######################################################################
# Graeco-Latin square  
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/propellant2.txt"
propellant2 = read.table(filename, header = TRUE)
str(propellant2) 

propellant2$material = factor(propellant2$material)
propellant2$operator = factor(propellant2$operator)
propellant2$trt = factor(propellant2$trt)
propellant2$assembly = factor(propellant2$assembly)

fitlm2 = lm(resp ~ trt + material + operator + assembly, data = propellant2)
anova(fitlm2)

fitaov2 = aov(resp ~ trt + material + operator + assembly, data = propellant2)
TukeyHSD(fitaov2)

######################################################################
# THE END
######################################################################
