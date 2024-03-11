#install.packages("gmm")
#install.packages("sandwich")
library(sandwich)
library(gmm)
vasg <- function(theta, data) {
  # pick up the individual parameters
  alpha <- theta[1]
  beta <- theta[2]
  sigma <- theta[3]
  gamma <- theta[4]
  
  # pick up the individual pieces of the data 
  rate <- data[, 1]
  lagged <- data[, 2]
  
  # get the dependent variable, the prediction, and the residual
  depend <- rate - lagged
  hat <- alpha + beta * lagged
  epsilon <- depend - hat
  
  # define the four moments
  # each column vector is a sample value that should average to 0
  # see equation 4 on page 1214 of Chan et al
  m1 <- epsilon
  m2 <- epsilon * lagged
  m3 <- epsilon^2 - (sigma)^2 * lagged^(2*gamma)
  m4 <- (epsilon^2 - (sigma)^2 * lagged^(2*gamma)) * lagged
  
  g <- cbind(m1, m2, m3, m4)
  return(g)
}

# Read in the data and limit the sample to Feb1978 through Dec2012
csv <- read.csv(file="~/../dropbox/GMM/ReformattedVasciekData.csv")
csv$Date <- as.Date(csv$Date,format="%m/%d/%Y")
csv <- subset(csv, Date >= as.Date("1997-02-01"))
csv <- subset(csv, Date <= as.Date("2017-12-31"))
summary(csv)

# Run a gression of the change in yield on the level of yields 
# to get starting values
csv$spread <- csv$CMPRATE - csv$LAGCMPRATE
model1 <- lm(spread ~ RATE, data=csv)
summary(model1)
parameters <- c(model1$coefficients, sd(residuals(model1)), 0)
names(parameters) <- c("Alpha", "Beta", "Sigma", "Gamma")
print(parameters)


# Use GMM to estimate the parameters
matrix <- cbind(csv$CMPRATE,csv$LAGCMPRATE)
model2 <- gmm(vasg,matrix,parameters, control = list(maxit = 10000, reltol = 1e-10))
summary(model2)


#making forecast visuals
fit <- fitted.gmm(model2)
gmm::plot.gmm(model2)
