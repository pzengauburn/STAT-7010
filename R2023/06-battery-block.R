######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/batteryblock.txt"
batteryblock = read.table(filename, header = TRUE)
str(batteryblock) 

######################################################################
# ANOVA 
######################################################################

batteryblock$material = factor(batteryblock$material)
batteryblock$temp = factor(batteryblock$temp)
batteryblock$operator = factor(batteryblock$operator)

fitlm = lm(life ~ operator + material * temp, data = batteryblock)
anova(fitlm)

######################################################################
# THE END
######################################################################
