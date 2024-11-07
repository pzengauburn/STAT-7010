######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-25
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/impurity.txt"
impurity = read.table(filename, header = TRUE)
str(impurity) 

######################################################################
# interaction plot 
######################################################################

library(emmeans)
with(impurity, interaction.plot(pressure, temp, y))
with(impurity, interaction.plot(temp, pressure, y))

######################################################################
# anova with no error 
######################################################################

impurity$pressure = factor(impurity$pressure)
impurity$temp = factor(impurity$temp)

fitaov = aov(y ~ pressure * temp, data = impurity)

######################################################################
# tukey's one-degree freedom test 
######################################################################

library(dae)
fitaov0 = aov(y ~ pressure + temp, data = impurity)
tukey.1df(fitaov0, data = impurity, error.term = "pressure:temp")

######################################################################
# THE END
######################################################################
