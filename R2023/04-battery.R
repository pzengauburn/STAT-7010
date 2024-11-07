######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-18
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/battery.txt"
battery = read.table(filename, header = TRUE)
str(battery) 

######################################################################
# calculate means and interactions 
######################################################################

mean.y = mean(battery$life)
mean.material = aggregate(life ~ material, data = battery, mean)
mean.temp = aggregate(life ~ temp, data = battery, mean)

mean.trt = aggregate(life ~ temp + material, data = battery, mean)
mean.trt = reshape(mean.trt, idvar = "material", timevar = "temp", direction = "wide")

tau.material = mean.material$life - mean.y
beta.temp = mean.temp$life - mean.y

inter = sweep(sweep(mean.trt[, 2:4], 1, mean.material$life, "-"), 2, mean.temp$life, "-") + mean.y

######################################################################
# interaction plot  
######################################################################

mu = aggregate(life ~ temp + material, data = battery, mean)

mu.wide = reshape(mu, idvar = "material", timevar = "temp", direction = "wide")
matplot(mu.wide$material, mu.wide[, 2:4], type = "b",
        xlab = "material", ylab = "mean life")

mu.wide2 = reshape(mu, idvar = "temp", timevar = "material", direction = "wide")
matplot(mu.wide2$temp, mu.wide2[, 2:4], type = "b", 
        xlab = "temp", ylab = "mean life")

######################################################################
# interaction plot using emmeans
######################################################################

library(emmeans) 
with(battery, interaction.plot(material, temp, life))
with(battery, interaction.plot(temp, material, life))

######################################################################
# two-way ANOVA
######################################################################

battery$material = factor(battery$material)
battery$temp = factor(battery$temp)

fitlm = lm(life ~ material * temp, data = battery)
anova(fitlm)

fitlm2 = lm(life ~ material + temp + material:temp, data = battery)
anova(fitlm2)

######################################################################
# model diagonistics 
######################################################################

qqnorm(residuals(fitlm))
qqline(residuals(fitlm), col = "red")

plot(fitted(fitlm), residuals(fitlm))

par(mfrow = c(2, 2)) 
plot(fitlm) 

######################################################################
# multiple comparison 
######################################################################

fitaov = aov(life ~ material * temp, data = battery)
TukeyHSD(fitaov)

######################################################################
# multiple comparison - manual calculation 
######################################################################

a = 3; b = 3; n = 4; 
fitlm = lm(life ~ material * temp, data = battery) 
sigma = summary(fitlm)$sigma 
df = a * b * (n - 1) 
CD.tukey = qtukey(0.95, a * b, df) / sqrt(2) * sigma * sqrt(1/n + 1/n)

mean.1.15 = mean(with(battery, life[(material == 1) & (temp == 15)]))
mean.2.15 = mean(with(battery, life[(material == 2) & (temp == 15)]))
mean.2.15 - mean.1.15 + c(-1, 1) * CD.tukey 

######################################################################
# THE END
######################################################################
