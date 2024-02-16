############################################################## 
###### Classification - Classroom Exercises - 14/2/2024 ###### 
############################################################## 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(tidyverse) # for data manipulation and visualization
library(caret) # for statistical learning techniques
library(MASS) # for AIC based stepwise regression
library(ggplot2) # for plots
library(klaR) # for LDA and QDA partition
library(readxl) # for reading xlsx files
library(klaR) # Miscellaneous functions for classification and visualization


### Data
# Today we are going to use the Titanic data set.
# It contains 1309 rows and 15 columns. Each row 
# represents a passenger and the columns describe 
# some of their attributes.

df <- read_excel("Titanic.xlsx")

# The type of some variables is not the optimal one 
# (e.g., gender as a numeric variable). We can change 
# these through the mutate function in dplyr.
df <- df %>%
  dplyr::mutate(across(c(pclass, survived,
                         Residence, body, Gender),factor))
head(df, 10)


# Now, we drop the columns having more than 50 percent
# of NAs, as well as the ones that will not be useful 
# for our analysis. We also drop all those rows without
# age information.

# selecting columns
df <- df %>%
  dplyr::select(-c(name,ticket, fare, cabin,
                   embarked, boat, body, home.dest))
# filtering out rows
df <- df %>% filter(!is.na(age))
# our "final" dataset
dim(df)

summary(df)




### Logistic Regression


#TO DO: split the data into training and testing sets
# with 75 and 25 percent of the points, respectively
set.seed(123)
training_samples <- ???
train <- ???
test <- ???


#TO DO: build a SIMPLE logistic regression model using
# sex as the only explanatory variable of the survival 
# status for each passenger.
simple_glm <- ???
summary(simple_glm)


#TO DO: report the predictive power of our model in terms of accuracy
#TIP: Since our response (Survival) is a binary variable,
# we need to round the probabilities which are predicted 
# by the logistic model.

# Test for accuracy: predict test data
predict_sex_survived_SIMP <- ???

# round up the predictions
predict_sex_survived_SIMP <- ???

# calculate accuracy
accuracyRed <- ???
accuracyRed


#TO DO: build the FULL/SATURATED model (i.e., the one 
# comprising all features)
glm_complete <- ???
summary(glm_complete)


#TO DO: report its predictive accuracy. 
# Has it improved?

# Test for accuracy: predict test data
predict_sex_survived_FULL <- ???

# round up the predictions
predict_sex_survived_FULL <- ???

# calculate accuracy
accuracySat <- ???
accuracySat


#TO DO: compare the confusion matrices of the SIMPLE
# and FULL models
ConfMat_SLR <- ???
  
ConfMat_SLR$table

ConfMat_FLR <- ???
  
ConfMat_FLR$table





### LDA and QDA
# Let us apply LDA and QDA to a multi label dataset 
# such as iris. We are going to use just the first 
# two columns with a gaussian noise.
iris2 <- iris[,c(1,2,5)]
species_name <- iris$Species
iris2[,1] <- iris2[,1] + rnorm(150, sd=0.025)
iris2[,2] <- iris2[,2] + rnorm(150, sd=0.025)
plot(iris2[,1:2], main='Iris.Sepal', xlab='Sepal.Length', ylab='Sepal.Width', pch=15)
points(iris2[1:50,], col=2, pch=15)
points(iris2[51:100,], col=4, pch=15)
points(iris2[101:150,], col=3, pch=15)
legend(min(iris[,1]), max(iris[,2]), legend=levels(species_name), fill=c(2,3,4))

# Once again we create a train set and a test set
set.seed(123)
training.samples <- species_name %>%
  createDataPartition(p = 0.8, list = FALSE)
train <- iris2[training.samples, ]
test <- iris2[-training.samples, ]

# It is generally recommended to standardize/normalize 
# continuous predictor before the analysis.
help(preProcess)
# Estimate preprocessing parameters
preproc.param <- train %>%
  preProcess(method = c("center", "scale"))
# Transform the data using the estimated parameters
train_transformed <- preproc.param %>% predict(train)
test_transformed <- preproc.param %>% predict(test)



#TO DO: run LDA and QDA using all variables
lda.iris <- ???
lda.iris

qda.iris <- ???
qda.iris


#TO DO: report the model accuracy on test data for
# both LDA and QDA
predmodel.test.lda <- ???
predmodel.test.qda <- ???

ConfMat_LDAtest <- ???
ConfMat_QDAtest <- ???

ConfMat_LDAtest$table
ConfMat_LDAtest$byClass[,1:2]

ConfMat_QDAtest$table
ConfMat_QDAtest$byClass[,1:2]


#TO DO: show the geometric division
???
  
???



### kNN

#TO DO: train the knn using Sepal.Length and Sepal.Width, for k = 1, 
# 2, 3, 10. Compare them through the 'accuracy'
set.seed(123)
knn_iris1 <- ???
  
knn_iris2 <- ???
  
knn_iris3 <- ???
  
knn_iris10 <- ???
  


predict_test_knn1 <- ???
ConfMat_knn1 <- ???
ConfMat_knn1$overall[1]

predict_test_knn2 <- ???
ConfMat_knn2 <- ???
ConfMat_knn2$overall[1]

predict_test_knn3 <- ???
ConfMat_knn3 <- ???
ConfMat_knn3$overall[1]

predict_test_knn10 <- ???
ConfMat_knn10 <- ???
ConfMat_knn10$overall[1]






