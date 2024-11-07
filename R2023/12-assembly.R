######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/assembly.txt"
assembly = read.table(filename, header = TRUE)
str(assembly) 

######################################################################
# ANOVA --- fixed effects 
######################################################################

assembly$layout = factor(assembly$layout)
assembly$fixure = factor(assembly$fixture)
assembly$operator = factor(assembly$operator)

fit.aov = aov(time ~ layout * fixture + layout/operator + layout/fixture:operator, 
              data = assembly)
summary(fit.aov)

######################################################################
# THE END
######################################################################
