######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-25
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/toollife.txt"
tool.life = read.table(filename, header = TRUE)
str(tool.life) 

######################################################################
# interaction plot 
######################################################################

library(emmeans)
with(tool.life, interaction.plot(angle, speed, life))
with(tool.life, interaction.plot(speed, angle, life))

######################################################################
# anova 
######################################################################

tool.life$angle = factor(tool.life$angle) 
tool.life$speed = factor(tool.life$speed) 

fitlm = lm(life ~ angle * speed, data = tool.life) 
anova(fitlm) 

######################################################################
# anova 
######################################################################

library(gmodels) 
cm = rbind("linear" = c(-1, 0, 1), "quadratic" = c(1, -2, 1))
fitaov = aov(life ~ angle * speed, data = tool.life,
             contrasts = list(angle = make.contrasts(cm), 
                              speed = make.contrasts(cm)))
summary(fitaov)
summary(fitaov, split = list(angle = list("linear" = 1, "quadratic" = 2), 
                             speed = list("linear" = 1, "quadratic" = 2)))

######################################################################
# THE END
######################################################################
