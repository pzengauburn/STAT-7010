######################################################################
# STAT 7010 - Experimental Statistics II 
# Peng Zeng (Auburn University)
# 2023-01-25
######################################################################

filename = "http://www.auburn.edu/~zengpen/teaching/STAT-7010/datasets/syrup.txt"
syrup = read.table(filename, header = TRUE)
str(syrup) 

######################################################################
# interaction plot 
######################################################################

library(emmeans)
with(syrup, interaction.plot(speed, nozzle, loss))
with(syrup, interaction.plot(pressure, nozzle, loss))
with(syrup, interaction.plot(pressure, speed, loss))

######################################################################
# anova  
######################################################################

syrup$nozzle = factor(syrup$nozzle)
syrup$speed = factor(syrup$speed)
syrup$pressure = factor(syrup$pressure)

fitaov = aov(loss ~ nozzle * speed * pressure, data = syrup)
summary(fitaov)

fitaov2 = aov(loss ~ (nozzle + speed + pressure)^2, data = syrup)
summary(fitaov2)

######################################################################
# contour 
######################################################################

syrup = read.table(filename, header = TRUE)
str(syrup) 

grid.speed = seq(100, 140, by = 0.1)
grid.pressure = seq(10, 20, by = 0.05) 
df = expand.grid("speed" = grid.speed, "pressure" = grid.pressure)

fitlm1 = lm(loss ~ speed * pressure + I(speed^2) + I(pressure^2), data = syrup, subset = (nozzle == 1))
yhat1 = predict(fitlm1, df)
contour(grid.speed, grid.pressure, matrix(yhat1, nrow = length(grid.speed)))

fitlm2 = lm(loss ~ speed * pressure + I(speed^2) + I(pressure^2), data = syrup, subset = (nozzle == 2))
yhat2 = predict(fitlm2, df)
contour(grid.speed, grid.pressure, matrix(yhat2, nrow = length(grid.speed)))

fitlm3 = lm(loss ~ speed * pressure + I(speed^2) + I(pressure^2), data = syrup, subset = (nozzle == 3))
yhat3 = predict(fitlm3, df)
contour(grid.speed, grid.pressure, matrix(yhat3, nrow = length(grid.speed)))

######################################################################
# THE END
######################################################################
