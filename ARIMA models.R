csv <- read.csv(file="~/../dropbox/GMM/ReformattedVasciekData.csv")
csv$Date <- as.Date(csv$Date,format="%m/%d/%Y")
csv <- subset(csv, Date >= as.Date("1997-02-01"))
csv <- subset(csv, Date <= as.Date("2017-12-31"))
summary(csv)

#Getting the parameter estimates
timeseries <- csv$RATE
timeseries <- as.vector(timeseries)
plot(timeseries)

changestest <- c(csv$CMPRATE - csv$LAGCMPRATE)
changestest <- as.vector(changestest)
View(changestest)
plot(changestest)

#ARIMA-GARCH Process (heteroskedasticity condition)
testarima <- Arima(changestest, order = c(3,1,1), method = "ML")
arima(changestest, order = c(3,1, 1), method = "ML")
restestarima <- testarima$res
garch1 <- garch(restestarima,order = c(1,1), trace=T)
summary(garch1)

#ARMA-GARCH Model
library(fGarch)
armagarch <- garchFit(formula = ~arma(1,0)+garch(1,1), data = changestest, cond.dist = 'std', include.shape = FALSE)
summary(armagarch)
plot(armagarch)
1
2
3

#predicting values
predictedvalues <- data.frame(armagarch@fitted)
View(predictedvalues)
predict(armagarch, n.ahead = 4)
new2018 <- (c(0.09, 0.16, 0.14, 0.06))
predictionability <- predict(armagarch, n.ahead = 4, newdata = new2018)

