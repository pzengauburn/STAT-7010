######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/loom.txt"
loom = read.table(filename, header = TRUE)
str(loom) 

######################################################################
# ANOVA with fixed effects
######################################################################

loom$loom = factor(loom$loom)

fitaov = aov(strength ~ loom, data = loom)
summary(fitaov)

######################################################################
# ANOVA with random effect
######################################################################

library(lme4)
fit.random = lmer(strength ~ (1|loom), data = loom)
summary(fit.random)

######################################################################
# manual calculation 
######################################################################

a = 4   # number of levels 
n = 4   # number of replicates 
MSTr = 29.7292
MSE  =  1.8958

sigma2.tau = (MSTr - MSE) / n     # variance of tau 
sigma2 = MSE                      # variance of random errors 
sigma2.y = sigma2.tau + sigma2    # variance of y 
sigma2.tau / sigma2.y             # intraclass correlation 

SE.y = sqrt(MSTr / a / a)         # standard error of mu-hat (fixed effects)
y.bar = mean(loom$strength)       # estimate of mu 
y.bar + c(-1, 1) * qt(0.975, a - 1) * SE.y  # 95% confidence interval of mu 

######################################################################
# confidence interval 
######################################################################

# 95 confidence interval for sigma2 (variance of random errors)
SSE = MSE * a * (n-1)
SSE / c(qchisq(0.975, a * (n-1)), qchisq(0.025, a * (n-1)))

# 95% confidence interval for sigma2.tau / sigma2 
L = (MSTr / MSE / qf(0.975, a - 1, a * (n-1)) - 1) / n
U = (MSTr / MSE / qf(0.025, a - 1, a * (n-1)) - 1) / n

# 95% confidence interval for intraclass correlation coefficient sigma2.tau / sigma2.y 
F0 = MSTr / MSE 
(F0 - qf(0.975, a-1, a*(n-1))) / (F0 + (n-1) * qf(0.975, a-1, a*(n-1))) # = L / (L + 1)
(F0 - qf(0.025, a-1, a*(n-1))) / (F0 + (n-1) * qf(0.025, a-1, a*(n-1))) # = U / (U + 1)

######################################################################
# THE END
######################################################################
