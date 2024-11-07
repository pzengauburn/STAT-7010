######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-02-16
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/hardness.txt"
hardness = read.table(filename, header = TRUE)
str(hardness) 

######################################################################
# ANOVA 
######################################################################

hardness$type = factor(hardness$type)
hardness$coupon = factor(hardness$coupon)

fitlm = lm(hardness ~ type + coupon, data = hardness)
anova(fitlm)

######################################################################
# multiple comparison 
######################################################################

fitaov = aov(hardness ~ type + coupon, data = hardness)
TukeyHSD(fitaov)

library(emmeans)
emm = emmeans(fitlm, "type")
pairs(emm)
pwpm(emm)

######################################################################
# tukey  
######################################################################

a = nlevels(hardness$type)
b = nlevels(hardness$coupon)
df = (a - 1) * (b - 1)

sigma = summary(fitlm)$sigma
cd.tukey = qtukey(0.95, a, df) / sqrt(2) * sigma * sqrt(1/b + 1/b)

######################################################################
# check model assumptions
######################################################################

plot(fitted(fitlm), residuals(fitlm))

qqnorm(residuals(fitlm))
qqline(residuals(fitlm), col = "red")

shapiro.test(residuals(fitlm))

par(mfrow = c(2, 2))
plot(fitlm)

######################################################################
# check for addivitity  
######################################################################

with(hardness, interaction.plot(type, coupon, hardness))
with(hardness, interaction.plot(coupon, type, hardness))

library(dae)
fitaov = aov(hardness ~ type + coupon, data = hardness)
tukey.1df(fitaov, data = hardness, error.term = "type:coupon")

######################################################################
# Tukey's 1df test for non-addivitity  
######################################################################

fitlm1 = lm(hardness ~ type + coupon, data = hardness)
hardness$q = fitted(fitaov)^2
fitlm2 = lm(hardness ~ type + coupon + q, data = hardness)
anova(fitlm1, fitlm2)

######################################################################
# THE END
######################################################################
