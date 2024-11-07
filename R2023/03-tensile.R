######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-17
######################################################################

######################################################################
# randomization 
######################################################################

pct = rep(c(15, 20, 25, 30, 35), 5)
sample(pct, replace = FALSE)

######################################################################
# load data, descriptive statistics, plots  
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/tensile.txt" 
tensile = read.table(filename, header = TRUE)
str(tensile) 

# side-by-side boxplots 
boxplot(strength ~ percent, data = tensile)

# summary statistics 
aggregate(strength ~ percent, data = tensile, length) 
aggregate(strength ~ percent, data = tensile, mean) 
aggregate(strength ~ percent, data = tensile, sd) 
aggregate(strength ~ percent, data = tensile, function(x) {t.test(x)$conf.int}) 

aggregate(strength ~ percent, data = tensile, 
    function(a) { c(n = length(a), mean = mean(a), sd = sd(a), 
                    CI.lower = t.test(a)$conf.int[1],
                    CI.upper = t.test(a)$conf.int[2])} ) 

######################################################################
# pooled standard deviation  
######################################################################

levelmeans = aggregate(strength ~ percent, data = tensile, mean)
levelsize = aggregate(strength ~ percent, data = tensile, length) 
DF = sum(levelsize$strength) - length(levelsize$strength)
levelvar  = aggregate(strength ~ percent, data = tensile, var) 
sqrt(sum((levelsize$strength - 1) * levelvar$strength) / DF)

######################################################################
# one-way ANOVA 
######################################################################

tensile$percent = factor(tensile$percent)

# one-way ANOVA using lm() 
fitlm = lm(strength ~ percent, data = tensile)
anova(fitlm)

# one-way ANOVA using aov() 
fitaov = aov(strength ~ percent, data = tensile)
summary(fitaov)

######################################################################
# model diagnostics 
######################################################################

library(MASS)

qqnorm(residuals(fitlm))
qqline(residuals(fitlm), col = "red")

plot(fitted(fitlm), residuals(fitlm))
plot(fitted(fitlm), studres(fitlm))

par(mfrow = c(2, 2)) 
plot(fitlm) 

######################################################################
# Bartlett's test for homogeneity of variances 
######################################################################

bartlett.test(strength ~ percent, data = tensile) 

######################################################################
# boxcox
######################################################################

library(MASS)
boxcox(strength ~ as.factor(percent), data = tensile, lambda = seq(-2, 2, by = 0.1))

######################################################################
# Kruskal-Wallis rank sum test 
######################################################################

kruskal.test(strength ~ percent, data = tensile) 

######################################################################
# contrast 
######################################################################

library(gmodels)
levels(tensile$percent)
fitlm = lm(strength ~ percent, data = tensile)
fit.contrast(fitlm, "percent", c(0, 0, 0, 1, -1), conf.int = 0.95)
fit.contrast(fitlm, "percent", c(1, 0, 1, -1, -1), conf.int = 0.95)
fit.contrast(fitlm, "percent", c(1, 0, -1, 0, 0), conf.int = 0.95)
fit.contrast(fitlm, "percent", c(1, -4, 1, 1, 1), conf.int = 0.95)

fit.contrast(fitlm, "percent", c(-2, -1, 0, 1, 2), conf.int = 0.95)    # linear 
fit.contrast(fitlm, "percent", c(2, -1, -2, -1, 2), conf.int = 0.95)   # quadratic 
fit.contrast(fitlm, "percent", c(-1, 2, 0, -2, 1), conf.int = 0.95)    # cubic 
fit.contrast(fitlm, "percent", c(1, -4, 6, -4, 1), conf.int = 0.95)    # quartic 

######################################################################
# use gmodels
######################################################################

library(gmodels)
tensile$percent = factor(tensile$percent)
levels(tensile$percent)
fitaov = aov(strength ~ percent, data = tensile, 
             contrasts = list(percent = make.contrasts(t(contr.poly(5)))))

summary(fitaov)
summary(fitaov, split = list(percent = list("linear" = 1, "quadratic" = 2, "cubic" = 3, "quartic" = 4)))

######################################################################
# contrast using emmeans
######################################################################

library(emmeans)
fitlm = lm(strength ~ percent, data = tensile)
emm = emmeans(fitlm, "percent")
ply = contrast(emm, "poly")
ply 

######################################################################
# orthogonal contrast 
######################################################################

c1 = c(-2, -1, 0, 1, 2) 
c2 = c(2, -1, -2, -1, 2)
c3 = c(-1, 2, 0, -2, 1)
c4 = c(1, -4, 6, -4, 1)

mu = aggregate(strength ~ percent, data = tensile, mean)$strength 
ni = aggregate(strength ~ percent, data = tensile, length)$strength 

SS.c1 = sum(mu * c1)^2 / sum(c1^2/ni)
SS.c2 = sum(mu * c2)^2 / sum(c2^2/ni)
SS.c3 = sum(mu * c3)^2 / sum(c3^2/ni)
SS.c4 = sum(mu * c4)^2 / sum(c4^2/ni)

######################################################################
# pairwise difference 
######################################################################

with(tensile, pairwise.t.test(strength, percent, "none"))
with(tensile, pairwise.t.test(strength, percent, "bonferroni"))

fitaov = aov(strength ~ percent, data = tensile)
TukeyHSD(fitaov)

######################################################################
# pairwise comparison using emmeans
######################################################################

library(emmeans)
fitlm = lm(strength ~ percent, data = tensile)
emm = emmeans(fitlm, "percent")
pairs(emm)
pwpm(emm)

######################################################################
# THE END
######################################################################
