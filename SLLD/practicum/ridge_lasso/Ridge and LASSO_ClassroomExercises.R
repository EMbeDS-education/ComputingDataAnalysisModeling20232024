######################################################### 
###### Ridge & LASSO - Classroom Exercises - 6/3/2024 ###
######################################################### 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
# do not forget to install them first! e.g.,
# install.packages("cluster")
library(glmnet) # ridge and lasso for GLMs
library(tidyverse) # data manipulation and visualization
library(caret) # statistical learning techniques
library(ggplot2) # plots
library(corrplot) # correlation matrix plotting



### Data
# We will use the Body Fat dataset (which is available in 
# the Datasets folder of our course).
# The data concerns a sample of 252 men, and contains 
# 15 variables

df <- read.table('BODY_FAT.TXT', header=TRUE)
names(df)

# We want to predict “SiriBF.” using the other features, 
# aside from “Density”. So we drop the “Density” column.

df <- df[,-1]


# We will perform ridge/lasso penalization through the 
# glmnet package. Let us identify predictors 
# and response variable getting the predictors

x_var <- data.matrix(df[,-1]) # NOTE: glmnet requires a matrix structure
# getting the response variable
y_var <- df[,"SiriBF."]


### Ridge
#TO DO: perform ridge regression and plot the regularization path 
ridge <- ???
plot(ridge, xvar="lambda")


#TO DO: performs a k-fold cross-validation and returns 
# the minimum and the largest value of lambda such that
# error is within 1 standard error of the minimum
cv_ridge <- ???
cv_ridge



### LASSO
#TO DO: perform LASSO regression and plot how the 
# regression coefficients change by modifying lambda. 
# The plot must contain the name of the variables 
# and the values of the min and the 1se lambda
lasso <- ???

set.seed(12345)
cv_lasso <- ???
plot(cv_lasso)

lbs_fun <- function(fit, offset_x=1, ...) {
  L <- length(fit$lambda)
  x <- log(fit$lambda[L])+ offset_x
  y <- fit$beta[, L]
  labs <- names(y)
  text(x, y, labels=labs, cex=0.75, ...)
}
plot(lasso, xvar = "lambda", label=T)
lbs_fun(lasso)
abline(v=log(cv_lasso$lambda.min), col = "red", lty=2)
abline(v=log(cv_lasso$lambda.1se), col="blue", lty=2)
legend(x = "bottomright",
       legend = c("lambda min", "lambda 1se"),
       lty = c(2, 2),
       col = c("red", "blue"))


#TO DO: compare the estimated coefficients for min and
# 1se lambda
min_lasso <- ???
se_lasso <- ???
lasso_mat <- cbind(coef(min_lasso), coef(se_lasso))
colnames(lasso_mat) <- c("min", "1se")
lasso_mat



### Digging in the irrepresentability condition

# As you have seen before, the variance-covariance 
# matrix can tell us whether LASSO will work (at least
# asymptotically) on the data at our disposal. Let’s 
# have a look at an example.


set.seed(12345) # Seed for replication
library(mvtnorm) # Sampling from a multivariate Normal
library(clusterGeneration) # Random matrix generation
p = 10 # = Number of Candidate Variables
k = 5 # = Number of Relevant Variables
n = 500 # = Number of observations
betas = (-1)^(1:k) # = Values for beta
sigma1 = genPositiveDefMat(p,"unifcorrmat")$Sigma # sigma1 violates irc
sigma2 = sigma1 # sigma2 satisfies irc
sigma2[(k+1):p,1:k]=0 # removing correlation among active and nonactive variables
sigma2[1:k,(k+1):p]=0
# Verify irrepresentable condition
irc1 = sort(abs(sigma1[(k+1):p,1:k] %*% solve(sigma1[1:k,1:k]) %*% sign(betas)))
irc2 = sort(abs(sigma2[(k+1):p,1:k] %*% solve(sigma2[1:k,1:k]) %*% sign(betas)))
c(max(irc1),max(irc2))
# = Have a look at the correlation matrices
par(mfrow=c(1,2))
corrplot(cov2cor(sigma1))
corrplot(cov2cor(sigma2))


X1 = rmvnorm(n,sigma = sigma1) # Variables violating IRC
X2 = rmvnorm(n,sigma = sigma2) # Variables satisfying IRC
e = rnorm(n) # Error from Standard Normal
y1 = X1[,1:k]%*%betas+e # Generate y for design 1
y2 = X2[,1:k]%*%betas+e # Generate y for design 2


#TO DO: for both data, perform LASSO selcting lambda with
# cross validation (both min and 1se) and with BIC

# use this code to install the HDeconometrics package 
#install.packages("remotes")
#remotes::install_github("gabrielrvsc/HDeconometrics")
library(HDeconometrics)

set.seed(123)
lasso1 = ???
cv_lasso1 = ???
lasso2 = ???
cv_lasso2 = ???

min_lasso1 <- ???
se_lasso1 <- ???
lasso_BIC1 <- ???
min_lasso2 <- ???
se_lasso2 <- ???
lasso_BIC2 <- ???


lasso_mat <- cbind(coef(min_lasso1), coef(se_lasso1), lasso_BIC1$coefficients,
                   coef(min_lasso2), coef(se_lasso2), lasso_BIC2$coefficients)
colnames(lasso_mat) <- c("x1_min", "x1_1se", "x1_bic",
                         "x2_min", "x2_1se", "x2_bic")
lasso_mat



