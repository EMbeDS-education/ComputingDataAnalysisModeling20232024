# Monte Carlo simulation
# Laura Magazzini: laura.magazzini@santannapisa.it

# Dynamic panel data model
# OLS is upward biased
# WG(FE) is downward biased
# IV-Anderson & Hsiao (1981) to get a consistent estimator
# GMM-Arellano & Bond (1991) to get a consistent estimator

# Consider a simplified version of the DGP in Arellano & Bond (1991)

rm(list=ls())

library(plm)
library(stargazer)
library(AER)

# Data generating process

genPD <- function(NN=100, TT=5, bAR = 0.5, bx = 1){
  TTsim <- TT+10
  # sumulate TTsim observation for each unit and disregard the first 10
  id <- rep(1:NN, each = TTsim)
  tt <- rep(1:TTsim, times = NN)
  ci <- rep(rnorm(NN), each = TTsim)
  eit <- rnorm(NN*TTsim)
  x <- rnorm(NN*TTsim)
  y <- numeric(NN*TTsim)
  for (t in 2:TTsim){
    y[tt==t] <- bAR*y[tt==(t-1)]+bx*x[tt==t]+ci[tt==t]+eit[tt==t]
  }
  ddd <- data.frame(id,tt,y,x)
  ddd <- ddd[tt>10,]
  ddd$tt <- ddd$tt-10
  pdata.frame(ddd, index = c("id","tt"))
}

# One sample
PDF <- genPD()

# OLS is upward biased
ols <-  plm(y ~ x+lag(y), data = PDF, model = "pooling")
summary(ols)
coefci(ols)

# FE (WG) is downward biased
wg <- plm(y ~ x+lag(y), data = PDF, model = "within")
summary(wg)
coefci(wg)

# IV - Anderson & Hsiao
# use lag 2 of y as instrument in first differenced equation
# - consistent estimation
ivah <- plm(diff(y) ~ lag(diff(y))+diff(x) |
              lag(y,2)+diff(x) , data = PDF,
            model = "pooling")
summary(ivah)
coefci(ivah)

# Arellano & Bond - GMM estimation
# lag 2 only
ab1 <- pgmm(y ~ lag(y)+x | 
               lag(y, 2:2)+x, data = PDF,
             model = "onestep")
summary(ab1)

# All available lags
aball <- pgmm(y ~ lag(y)+x | 
               lag(y, 2:99)+x, data = PDF,
             model = "onestep")
summary(aball)


# Monte Carlo replication

nRepl <- 1000
ols1 <- numeric(nRepl)
olsx <- numeric(nRepl)
wg1 <- numeric(nRepl)
wgx <- numeric(nRepl)
ivah1 <- numeric(nRepl)
ivahx <- numeric(nRepl)
ab11 <- numeric(nRepl)
ab1x <- numeric(nRepl)
aball1 <- numeric(nRepl)
aballx <- numeric(nRepl)

set.seed(12345)
for (rr in 1:nRepl){
  # print(rr)
  # Generate the panel data set
  PDF <- genPD()

  # OLS estimation
  ols <- plm(y ~ x+lag(y), data = PDF, model = "pooling")
  ols1[rr] <- coef(ols)["lag(y)"]
  olsx[rr] <- coef(ols)["x"]
  
  # WG estimation
  wg <- plm(y ~ x+lag(y), data = PDF, model = "within")
  wg1[rr] <- coef(wg)["lag(y)"]
  wgx[rr] <- coef(wg)["x"]
  
  # IV estimation (Anderson & Hsiao)
  ivah <- plm(diff(y) ~ lag(diff(y))+diff(x) |
                lag(y,2)+diff(x) , data = PDF,
              model = "pooling")
  ivah1[rr] <- coef(ivah)["lag(diff(y))"]
  ivahx[rr] <- coef(ivah)["diff(x)"]
  
  # Arellano & Bond - GMM estimation
  # lag 2 only
  ab1 <- pgmm(y ~ lag(y)+x | 
                lag(y, 2:2)+x, data = PDF,
              model = "onestep")
  ab11[rr] <- coef(ab1)["lag(y)"]
  ab1x[rr] <- coef(ab1)["x"]
  
  # All available lags
  aball <- pgmm(y ~ lag(y)+x | 
                  lag(y, 2:99)+x, data = PDF,
                model = "onestep")
  aball1[rr] <- coef(aball)["lag(y)"]
  aballx[rr] <- coef(aball)["x"]
  
} 

# estimation of the coeff of lag(y)
MCresults1 <- data.frame(OLS = ols1, WG = wg1, IV = ivah1, AB1lag = ab11, AB = aball1)
stargazer(MCresults1, type="text")


# estimation of the coeff of x
MCresultsx <- data.frame(OLS = olsx, WG = wgx, IV = ivahx, AB1lag = ab1x, AB = aballx)
stargazer(MCresultsx, type="text")

