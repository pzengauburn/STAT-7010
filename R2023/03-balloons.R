######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-17
######################################################################

######################################################################
# load data, descriptive statistics, plots  
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/balloons.txt" 
balloons = read.table(filename, header = TRUE)
str(balloons) 

# side-by-side boxplots 
boxplot(time ~ color, data = balloons)

# summary statistics 
aggregate(time ~ color, data = balloons, length) 
aggregate(time ~ color, data = balloons, mean) 
aggregate(time ~ color, data = balloons, sd) 
aggregate(time ~ color, data = balloons, function(x) {t.test(x)$conf.int}) 

aggregate(time ~ color, data = balloons, 
    function(a) { c(n = length(a), mean = mean(a), sd = sd(a), 
                    CI.lower = t.test(a)$conf.int[1],
                    CI.upper = t.test(a)$conf.int[2])} ) 

######################################################################
# one-way ANOVA 
######################################################################

# one-way ANOVA using lm() 
fitlm = lm(time ~ color, data = balloons)
anova(fitlm)

# one-way ANOVA using aov() 
fitaov = aov(time ~ color, data = balloons)
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

bartlett.test(time ~ color, data = balloons) 

######################################################################
# contrast 
######################################################################

library(gmodels)
balloons$color = factor(balloons$color)
levels(balloons$color)

fitlm = lm(time ~ color, data = balloons)
fit.contrast(fitlm, "color", c(0, -1, 0, 1), conf.int = 0.95)
fit.contrast(fitlm, "color", c(0.5, -0.5, 0.5, -0.5), conf.int = 0.95)
fit.contrast(fitlm, "color", c(1, 0, -1, 0), conf.int = 0.95)

######################################################################
# orthogonal contrast 
######################################################################

c1 = c(1, 0, -1, 0)
c2 = c(0, 1, 0, -1)
c3 = c(1, -1, 1, -1)
mu = aggregate(time ~ color, data = balloons, mean)$time 
ni = aggregate(time ~ color, data = balloons, length)$time

SS.c1 = sum(mu * c1)^2 / sum(c1^2/ni)
SS.c2 = sum(mu * c2)^2 / sum(c2^2/ni)
SS.c3 = sum(mu * c3)^2 / sum(c3^2/ni)

######################################################################
# use gmodels
######################################################################

library(gmodels)
cm = rbind("blue-pink" = c(1, 0, -1, 0), 
           "yellow-orange" = c(0, 1, 0, -1),
           "y-o versus p-b" = c(1, -1, 1, -1))
fitaov = aov(time ~ color, data = balloons, 
             contrasts = list(color = make.contrasts(cm)))
summary(fitaov)
summary(fitaov, split = list(color = list("blue-pink" = 1, "yellow-orange" = 2, "y-o versus p-b" = 3)))

######################################################################
# multiple comparison 
######################################################################

a = 4
n = 8
df = a * (n - 1)
sigma = summary(fitlm)$sigma

cd.lsd = qt(1 - 0.05/2, df) * sigma * sqrt(1/n + 1/n)
cd.bon = qt(1 - 0.05/a/(a-1), df) * sigma * sqrt(1/n + 1/n)
cd.scheffe = sqrt((a - 1) * qf(0.95, a - 1, df)) * sigma * sqrt(1/n + 1/n)
cd.tukey = qtukey(0.95, a, df) / sqrt(2) * sigma * sqrt(1/n + 1/n)

######################################################################
# pairwise difference 
######################################################################

with(balloons, pairwise.t.test(time, color, "none"))
with(balloons, pairwise.t.test(time, color, "bonferroni"))

fitaov = aov(time ~ color, data = balloons)
TukeyHSD(fitaov)

######################################################################
# pairwise difference using emmeans 
######################################################################

library(emmeans)
fitlm = lm(time ~ color, data = balloons)
emm = emmeans(fitlm, "color")
pairs(emm)
pwpm(emm)

######################################################################
# THE END
######################################################################
