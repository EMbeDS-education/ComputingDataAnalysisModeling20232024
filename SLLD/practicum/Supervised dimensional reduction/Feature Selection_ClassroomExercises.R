############################################################# 
###### Feature Selection - Classroom Exercises - 7/3/2024 ###
#############################################################


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(caret) # statistical learning techniques
library(leaps) # BSS
library(glmnet)


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


### LASSO

#TO DO: perform Lasso regression and report the estimated
# coefficients for min lambda
x_var <- data.matrix(df[,-1]) # NOTE: glmnet requires a matrix structure
# getting the response variable
y_var <- df[,"SiriBF."]
set.seed(1)
cv_lasso <- ???
min_lasso <- ???
lasso_coefs <- coef(min_lasso)
lasso_coefs




###Best Subset Selection (Linear Regression)

#TO DO: performs best subset selection and print the logical matrix 
# indicating which elements are in each model
#TIP: The code shown in the slides considered the 10 simulated covariates, 
# but now we have 13...
regfit.full = ???
???
  
#TO DO: plot the r-squared for each model
???
  
#TO DO: run the following codes and comment 
# the results
reg.summary <- summary(regfit.full)
par(mfrow=c(2,2))
plot(reg.summary$rss ,xlab="Number of Variables ",ylab="RSS",type="l")
plot(reg.summary$adjr2 ,xlab="Number of Variables ", ylab="Adjusted RSq",type="l")
max_adjr2 <- which.max(reg.summary$adjr2)
abline(v=max_adjr2, col="red", lty=2)
points(max_adjr2,reg.summary$adjr2[max_adjr2], col="red",cex=2,pch=20)
plot(reg.summary$cp ,xlab="Number of Variables ",ylab="Cp", type='l')
min_cp <- which.min(reg.summary$cp )
points(min_cp, reg.summary$cp[min_cp],col="red",cex=2,pch=20)
abline(v=min_cp, col="red", lty=2)
plot(reg.summary$bic ,xlab="Number of Variables ",ylab="BIC",type='l')
min_bic <- which.min(reg.summary$bic)
points(min_bic,reg.summary$bic[min_bic],col="red",cex=2,pch=20)
abline(v=min_bic, col="red", lty=2)


#TO DO: plot two tables of models ordered by BIC and
# Adjusted r-squared
par(mfrow=c(1,1))
???
???



### Tuning strategies

#TO DO: split the observations into a training set and a test set 
# (of size 80 vs 20%). Apply the function regsubsets() on the 
# training set
set.seed(1)
train = ???
test = which(!(1:nrow(df) %in% train))

regfit.best <- ???
test.mat = ???


#TO DO: for each size i, use the following loop to extract the coefficients.
p = (ncol(df)-1) # number of predictors
mse <- rep(NA, p) # out-of-sample MSE
for(i in 1:p){
  coefi=coef(regfit.best,id=i)
  pred=test.mat[,names(coefi)]%*%coefi
  mse[i]=mean((df$SiriBF.[test]-pred)^2)
}
plot(mse, type='b')
abline(v=which.min(mse), col="red", lty=2)
legend(x = "topright",
       legend = "min test-MSPE",
       lty = 2,
       col = "red")



#TO DO: run the following codes to perform cross validation.
# Comment the results.
k = 10
set.seed(123)
# folds
folds <- createFolds(1:nrow(df), k = 10, list = TRUE, returnTrain = T)
fold <- matrix(NA, nrow(df), k)
for (i in 1:k) {
  fold[, i] <- (1:nrow(df) %in% folds[[i]])
}
head(fold, 10)


# initialize an empty matrix to contain test errors
cv.errors=matrix(NA, k, # num of folds
                 p, # num of variables
                 dimnames=list(NULL, paste(1:p)))




predict.regsubsets = function (object, newdata, id, ...){
  form = as.formula(object$call[[2]])
  mat = model.matrix(form,newdata)
  coefi = coef(object ,id=id)
  xvars = names(coefi)
  mat[,xvars] %*% coefi
}
# loop for each fold
for(j in 1:k){
  best.fit = regsubsets(SiriBF. ~ . , data=df[fold[,j], ], nvmax = p)
  # for each best model
  for (i in 1:p){
    pred = predict.regsubsets(best.fit, df[!fold[,j], ], id = i)
    cv.errors[j, i] = mean((df$SiriBF.[!fold[,j]] - pred)^2)
  }
}


mean_mse <- colMeans(cv.errors)
plot(mean_mse, type='b')
abline(v=which.min(mean_mse), col="red", lty=2)
legend(x = "topright",
       legend = "min CV-MSPE",
       lty = 2,
       col = "red")



coef(regfit.best, which.min(mse))
reg.best <- regsubsets (SiriBF. ~ ., data=df, nvmax=p)
coef(reg.best, which.min(mean_mse))

