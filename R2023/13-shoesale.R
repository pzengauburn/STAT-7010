######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/shoesale.txt"
shoesale = read.table(filename, header = TRUE)
str(shoesale) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

shoesale$A = factor(shoesale$A)
shoesale$B = factor(shoesale$B)
shoesale$maket = factor(shoesale$maket)

fit.aov = aov(y ~ A * B + A/maket, data = shoesale)
summary(fit.aov)

######################################################################
# repeated measures 
######################################################################


######################################################################
# THE END
######################################################################
