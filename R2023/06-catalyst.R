######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/catalyst.txt"
catalyst = read.table(filename, header = TRUE)
str(catalyst) 

######################################################################
# ANOVA
######################################################################

catalyst$trt = factor(catalyst$trt)
catalyst$block = factor(catalyst$block)

fitlm1 = lm(resp ~ trt + block, data = catalyst)
anova(fitlm1)

fitlm2 = lm(resp ~ block + trt, data = catalyst)
anova(fitlm2)

######################################################################
# type III Sum of Squares
######################################################################

fitlm.block = lm(resp ~ block, data = catalyst)
fitlm.trt = lm(resp ~ trt, data = catalyst)
fitlm = lm(resp ~ block + trt, data = catalyst)

anova(fitlm.block, fitlm)
anova(fitlm.trt, fitlm)

######################################################################
# lsmeans 
######################################################################

library(emmeans)
fitlm1 = lm(resp ~ trt + block, data = catalyst) 
emm = emmeans(fitlm1, "trt")
emm

######################################################################
# contrast 
######################################################################

library(gmodels)
fitlm1 = lm(resp ~ trt + block, data = catalyst) 
fit.contrast(fitlm1, "trt", c(1, -1, 0, 0), conf.int = 0.95)
fit.contrast(fitlm1, "trt", c(0, 0, 1, -1), conf.int = 0.95)

# SS of contrast = t0^2 * MSE 
(-0.3580574 * summary(fitlm)$sigma)^2

######################################################################
# manual calculation 
######################################################################

a = 4; b = 4; k = 3; r = 3; lambda = 2; N = 12;

mat = with(catalyst, table(trt, block))  # incidence matrix 
sum(mat)     # N --- total number of observations 
rowSums(mat) # r --- each treatment appears in r block 
colSums(mat) # k --- each block contains k treatments 

ymean = mean(catalyst$resp)  # overall mean 

sum.block = aggregate(resp ~ block, catalyst, sum)   
sum.trt = aggregate(resp ~ trt, catalyst, sum)     
Q1 = 218 - (221 + 224 + 218) / 3

Q1 = sum.trt$resp[1] - sum(mat[1, ] * sum.block$resp) / k 
Q2 = sum.trt$resp[2] - sum(mat[2, ] * sum.block$resp) / k 
Q3 = sum.trt$resp[3] - sum(mat[3, ] * sum.block$resp) / k 
Q4 = sum.trt$resp[4] - sum(mat[4, ] * sum.block$resp) / k 
Q = c(Q1, Q2, Q3, Q4)

tau1 = k * Q1 / (lambda * a)
tau2 = k * Q2 / (lambda * a)
tau3 = k * Q3 / (lambda * a)
tau4 = k * Q4 / (lambda * a)
tau = c(tau1, tau2, tau3, tau4) 

mu = ymean + tau
mu.SE = summary(fitlm)$sigma * sqrt(k * (a - 1) / (lambda * a * a) + 1 / N)

SS.trt = k / (lambda * a) * sum(Q^2)     # from Q_i
SS.trt = (lambda * a) / k * sum(tau^2)   # from tau_i

contra1 = c(1, -1, 0, 0)
SS.1 = k / (a * lambda) * (sum(Q * contra1))^2 / sum(contra1^2)

contra2 = c(0, 0, 1, -1)
est.2 = k / (a * lambda) * sum(Q * contra2)

######################################################################
# THE END
######################################################################
