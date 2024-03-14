############################################################## 
###### Feature Screening - Classroom Exercises - 14/3/2024 ###
##############################################################


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
# auto-install SIS if needed
if(!require(SIS)){install.packages("SIS", dep=T); library(SIS)}
library(glmnet) # elastic net for GLMs
library(mvtnorm) # to generate multivariate normal distributions
library(corrplot) # correlation plot
library(tidyverse) # data manipulation and visualization
library(caret) # classification learning (confusion matrix)


### Data
# We will simulate some Gaussian data for an example with continuous response.

# We will also analyze Leukemia data (with a binary response) that are provided 
# in the SIS package: - leukemia.test: Gene expression 7129 genes from 34 
# patients with acute leukemias (20 in class Acute Lymphoblastic
# Leukemia and 14 in class Acute Myeloid Leukemia). - leukemia.train: Gene
# expression of 7129 genes from 38 patients with acute leukemias (27 in class 
# Acute Lymphoblastic Leukemia and 11 in class Acute Myeloid Leukemia).




### Simulated data: stronger collinearity

# Let’s generate some data as before, but with stronger collinearity. 
# Namely, the covariance matrix has a power decay structure with rho=0.6

set.seed(1)
n <- 100 # obs
p <- 2000 # predictors
pnot <- 5 # relevant predictors
# signal to noise ratio SNR = var(Xb)/var(err) -- similar to Rˆ2 but unbounded
SNR <- 3 # => Rˆ2 approx 0.8
# regression coefficients
b <- rep(0, p)
b[1:pnot] <- 0.5
# create a random matrix X (mean zero and autoregressive correlation)
rho <- 0.6
mu <- rep(0, p)
sigma <- matrix(NA, p, p)
for (i in 1:p) {
  for (j in 1:p) {
    sigma[i,j] <- rho^abs(i-j)
  }
}
X<- rmvnorm(n, mu, sigma)
# strongest correlations
corx <- cor(X)
corxtri <- corx[upper.tri(cor(X))]
scorx <- sort(corxtri)
head(scorx)

tail(scorx)

plot(1:(p*(p-1)/2), scorx, type="l")
abline(h=0, col="red", lty=2)


hist(scorx)

# plot correlations in X (just take 50 predictors at random)
randp <- sample(1:p, 50)
corrplot(corx[randp,randp], tl.pos='n', type="upper", diag=F)

# true predictions
truepred <- X %*% b
# variance of the error term according to the SNR
varerr <- var(truepred)/SNR
# generate the error
err <- rnorm(n)*sqrt(varerr)
# create the response
y <- truepred + err



#Define the num of features retained by SIS/ISIS
q <- round(n / log(n))
q

# maximum num of iterations for ISIS
maxit <- 10




#TO DO: run vanilla SIS and report the selected features 
# for both SIS and SIS+LASSO
model1 = ???


# SIS selected features
model1$sis.ix0
# SIS+LASSO selected features
model1$ix



#TO DO: run vanilla ISIS and report the selected features
# for both ISIS and ISIS+LASSO
model2 = ???

# ISIS selected features
model2$sis.ix0
# ISIS+LASSO selected features
model2$ix



#TO DO: Compare them with LASSO fit.
# First, plot the overall path
modelLasso = ???
plot(modelLasso, xvar="lambda")

# Second, select the tuning parameter through CV
set.seed(1)
modelLassoCV = ???
plot(modelLassoCV)

# Third, extract the associated features
modelLasso = ???
  
Lassocoef <- which(coef(modelLasso) != 0)
Lassocoef

# compare them with SIS+LASSO
???
  
# compare them with ISIS+LASSO
???



### Logistic regression

set.seed(12345)
data("leukemia.train", package = "SIS")
data("leukemia.test", package = "SIS")

# Let’s construct our response variable and the design matrix.
y1 <- leukemia.train[, dim(leukemia.train)[2]]
x1 <- as.matrix(leukemia.train[, -dim(leukemia.train)[2]])
x2 <- as.matrix(leukemia.test[, -dim(leukemia.test)[2]])
y2 <- leukemia.test[, dim(leukemia.test)[2]]


# We further combine the training and test samples and then perform 
# a 50%–50% random splitting of the observed data into new training 
# and test data for which the number of cases remains balanced across 
# these new samples (i.e. balanced sample splitting). In this manner, 
# the balanced training and test samples are of size 36.
x <- rbind(x1, x2)
y <- c(y1, y2)
n <- dim(x)[1]
aux <- 1:n
ind.train1 <- sample(aux[y == 0], 23, replace = FALSE)
ind.train2 <- sample(aux[y == 1], 13, replace = FALSE)
ind.train <- c(ind.train1, ind.train2)
ind.test1 <- setdiff(aux[y == 0], ind.train1)
ind.test2 <- setdiff(aux[y == 1], ind.train2)
ind.test <- c(ind.test1, ind.test2)

# Before variable screening and classification, we also standardize 
# each predictor to zero mean and unit variance:
y.train <- y[ind.train]
y.test <- y[ind.test]
x.train <- scale(x[ind.train, ])
x.test <- scale(x[ind.test, ])



#TO DO: perform both vanilla SIS and ISIS with 10-folds cross validation and 
# 100 recruited predictors. The random seed for cross validation must be 9.
# For ISIS, the maximum number of iterations must be 2

# Report the selected features

# vanilla SIS
model1 = ???

# SIS selected features
model1$sis.ix0
# SIS+LASSO selected features
model1$ix

#TO DO: perform vanilla ISIS and report the selected features
# both for ISIS and for ISIS+LASSO
model2 = ???

# ISIS selected features
model2$sis.ix0
# ISIS+LASSO selected features
model2$ix


#TO DO: Perform classical LASSO without standardizazion
modelLasso = ???

# Report the overall path:
plot(modelLasso, xvar="lambda")

#TO DO: select the tuning parameter:
set.seed(1)
modelLassoCV = ???
  
plot(modelLassoCV)


#TO DO: Extract the associated features
modelLasso = ???
Lassocoef <- which(coef(modelLasso) != 0)

# compare them with SIS
???
  
# compare them with ISIS
???


  

# Let’s now compare predictive power:

# Make predictions on the testing data
print(paste0("Lasso selected features: ", length(Lassocoef)))

predLasso <- modelLasso %>% predict(x.test, type='class') %>% as.factor()
confusionMatrix(predLasso, as.factor(y.test))

print(paste0("SIS selected features: ", length(model1$ix)))

predSIS <- model1 %>% SIS:::predict.SIS(x.test, type='class') %>% as.factor()
confusionMatrix(predSIS, as.factor(y.test))

print(paste0("ISIS selected features: ", length(model2$ix)))

predISIS <- model2 %>% SIS:::predict.SIS(x.test, type='class') %>% as.factor()
confusionMatrix(predISIS, as.factor(y.test))

# Let’s have a look at correlation in the predictors:
set.seed(1)
# just take 50 predictors at random
randp <- sample(1:ncol(x.train), 50)
corrplot(cor(x.train)[randp,randp], tl.pos='n', type="upper", diag=F)

