######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-25
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/bottling.txt"
bottling = read.table(filename, header = TRUE)
str(bottling) 

######################################################################
# interaction plots 
######################################################################

library(emmeans)
with(bottling, interaction.plot(percent, pressure, dev))
with(bottling, interaction.plot(percent, speed, dev))
with(bottling, interaction.plot(speed, pressure, dev))

######################################################################
# anova 
######################################################################

bottling$percent = factor(bottling$percent)
bottling$pressure = factor(bottling$pressure)
bottling$speed = factor(bottling$speed)

fitaov = aov(dev ~ percent * pressure * speed, data = bottling)
summary(fitaov)

fitaov2 = aov(dev ~ percent * pressure + speed, data = bottling)
summary(fitaov2)

fitaov3 = aov(dev ~ (percent + pressure + speed)^2, data = bottling)
summary(fitaov3)

######################################################################
# THE END
######################################################################
