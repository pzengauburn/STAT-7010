######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

######################################################################
# same rows and same columns 
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/latin1.txt"
latin1 = read.table(filename, header = TRUE)
str(latin1) 

latin1$rep = factor(latin1$rep)
latin1$row = factor(latin1$row)
latin1$col = factor(latin1$col)
latin1$trt = factor(latin1$trt)

fitlm1 = lm(resp ~ rep + row + col + trt, data = latin1)
anova(fitlm1)

######################################################################
# new rows and same columns 
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/latin2.txt"
latin2 = read.table(filename, header = TRUE)
str(latin2) 

latin2$rep = factor(latin2$rep)
latin2$row = factor(latin2$row)
latin2$col = factor(latin2$col)
latin2$trt = factor(latin2$trt)

fitlm2 = lm(resp ~ rep + row + col + trt, data = latin2)
anova(fitlm2)

fitlm2x = lm(resp ~ row + col + trt, data = latin2)
anova(fitlm2x)

######################################################################
# new rows and new columns 
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/latin3.txt"
latin3 = read.table(filename, header = TRUE)
str(latin3) 

latin3$rep = factor(latin3$rep)
latin3$row = factor(latin3$row)
latin3$col = factor(latin3$col)
latin3$trt = factor(latin3$trt)

fitlm3 = lm(resp ~ rep + row + col + trt, data = latin3)
anova(fitlm3)

######################################################################
# THE END
######################################################################
