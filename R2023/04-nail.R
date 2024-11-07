######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-25
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/nail.txt"
nail = read.table(filename, header = TRUE)
str(nail) 

######################################################################
# interaction plots  
######################################################################

library(emmeans) 
with(nail, interaction.plot(solvent, varnish, time))
with(nail, interaction.plot(varnish, solvent, time))

######################################################################
# anova 
######################################################################

nail$solvent = factor(nail$solvent)
nail$varnish = factor(nail$varnish)

fitaov = aov(time ~ solvent * varnish, data = nail) 
summary(fitaov) 

fitaov2 = aov(time ~ solvent + varnish, data = nail) 
summary(fitaov2) 

######################################################################
# multiple comparison 
######################################################################

library(emmeans)
emm = emmeans(fitaov2, "solvent")
pairs(emm)
pwpm(emm)

emm2 = emmeans(fitaov2, "varnish")
pairs(emm2)
pwpm(emm2)

######################################################################
# THE END
######################################################################
