######################################################## 
###### Resampling - Classroom Exercises - 22/2/2024 #### 
######################################################## 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(tidyverse)  # data manipulation and visualization
library(boot)       # bootstrapping
library(coin)       # permutation tests
library(ggplot2)    # plots

### Data
# Today we will simulate our dataset! :)
# We generate a sample of size 30 from a binomial distribution 
# with parameters (15,0.71).
set.seed(123)
N <- 15
x <- rbinom(n=30,       # sample size
            size=N,    # num. of trials
            prob=0.71)  # prob. of success per trial
summary(x)


#TO DO: use the boot function to perform a non-parametric and a 
# parametric Bootstrap with 2000 samples to estimate the 90th percentile. 
# Compare the results

# non-parametric
sampleperc <- ???
B = 2000
set.seed(123)
b_NonPar = ???
print(b_NonPar)


# parametric
p_hat <- ???
p_hat

set.seed(123)
p.rg <- function(data, mle, N=15) {
  out <- rbinom(length(data), 
                size = N, 
                prob = mle)
  out
}
b_Par <- ???
b_Par


# notice how close this is to our previous computation
results <- rbind.data.frame(data.frame("mean" = b_NonPar$t0,   # mean(b$t)
                                       "SD" = sd(b_NonPar$t)), 
                            data.frame("mean" = b_Par$t0,   # mean(b$t)
                                       "SD" = sd(b_Par$t))) # for some reason you must compute it again
rownames(results)[1] <- "NonPar"
rownames(results)[2] <- "Par"
results




# We now generate a dataset divided into treatment (1) and control group (0).
set.seed(1)
n <- 100
tr <- rbinom(n, 1, 0.5) 
y <- 1 + tr + rnorm(n, 0, 3)
means <- by(y, tr, mean)
diff0 <- diff(means)
diff0


#TO DO: obtain 2000 permutation of the data without replacement 
# and calculate the difference between means. Plot the histogram
set.seed(123)
nperm = 2000
dist <- ???
  
???

#TO DO: use the distribution to obtain a p-value for our mean-difference 
# (both one and two tailed test)
???
???

# We now simulate a time series from an AR(1) model
set.seed(1)
z <- arima.sim(n = 200, list(ar = 0.9))

#TO DO: perform Time Series Bootstrap. 
#Note, you have to decide the value of l after seeing the 
# aucorelation function. Remember, l is the fixed block 
# length used in generating the replicate time series,

acf(z)

ar.fun <- function(fun) {
  ar.fit <- ar(fun, order.max = 1)
  c(ar.fit$ar[1])
}
prova <- ???
prova$t0
ar.fun(z)
prova$t[1:5]
sd(prova$t)

