#this time round
changes <- csv$CMPRATE-csv$LAGCMPRATE
breaks <- c(0,1,2,3,4,5,7)
length(breaks)
bins <- cut(csv$CMPRATE, breaks = breaks, include.lowest = T, right = FALSE)
summary(bins)
dframe <- data.frame(changes, bins)
boxplot(dframe$changes~dframe$bins, xlab = "Level (%)", ylab = "Changes", main = "Conditional Elasticity of Treasury Bill Rate", col="lightblue" )
