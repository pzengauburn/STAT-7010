######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-12
######################################################################

######################################################################
# load data  
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/balloons.txt" 
balloons = read.table(filename, header = TRUE)
str(balloons) 

######################################################################
# ANOVA  
######################################################################

fitlm0 = lm(time ~ color, data = balloons)
anova(fitlm0)

plot(balloons$order, residuals(fitlm0))

######################################################################
# ANOVA with x 
######################################################################

balloons$x = balloons$order - 16.5 
# set y as the reference level 
balloons$color = factor(balloons$color, c("y", "o", "p", "b"))
fitlm = lm(time ~ color + x, data = balloons)
summary(fitlm)
anova(fitlm)

plot(balloons$order, residuals(fitlm))

######################################################################
# contrast  
######################################################################

library(gmodels) 
levels(balloons$color)     # "y" "o" "p" "b" 
fitlm = lm(time ~ color + x, data = balloons)
fit.contrast(fitlm, "color", c(0, 0, -1, 1), conf.int = 0.95)          # color b-p
fit.contrast(fitlm, "color", c(1, -1, 0, 0), conf.int = 0.95)          # color y-o
fit.contrast(fitlm, "color", c(0.5, 0.5, -0.5, -0.5), conf.int = 0.95) # color yo-bp

######################################################################
# THE END
######################################################################
