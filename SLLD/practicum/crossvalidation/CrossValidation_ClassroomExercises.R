################################################################ 
###### Cross Validation - Classroom Exercises - 21/2/2024 ###### 
################################################################ 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(tidyverse)  # data manipulation and visualization
library(caret)      # statistical learning techniques
library(ggplot2)    # plots
library(dslabs)     # digit recognition data
library(datasets)



### Data
# We will use the **polls_2008** dataset, which is part of the
# dslabs package. It contains data from 131 pollsters 
# for the popular vote between Obama and McCain in the 2008 
# presidential election. The variables are:

# day. Days until election day. Negative numbers are reported so 
# that days can increase up to 0, which is election day.

# margin. Average difference between Obama and McCain for that day


data("polls_2008")
polls_2008 <- data.frame(polls_2008)
polls_2008$day <- 1:nrow(polls_2008) # transform day in positive numbers
plot(polls_2008$day, polls_2008$margin)


#TO DO: perform LOOCV to test loess at degree = 1, 2; and consider a 
# sequence of length 20 from 0.05 to 1 for span
degree_list <- list()
span_values <- ???
for(deg in 1:2){ #polynomial degree
  err <- list()
  for(k in 1:length(span_values)){ #smoothness
    score <- list()
    for(i in 1:(nrow(polls_2008))){
      training = polls_2008[-i,]
      model = loess(margin ~ day, data = training, span = span_values[k],
                    degree=deg) 
      validation = polls_2008[i,]
      pred = na.omit(predict(model, validation))
      # error of ith fold
      score[[i]] = (validation$margin - pred)^2
    }
    # returns a vector with the average error for a given degree & span
    err[[k]] <- mean(unlist(score),na.rm=TRUE) 
  }
  degree_list[[deg]] <- err
}

# prepare dataframe for ggplot
spans <- rep(span_values,2)
degrees <- rep(c(1,2), each = length(span_values))
err <- unlist(degree_list)
df_toplot <- as.data.frame(cbind(spans,degrees,err))

#TO DO: comment the results
plt <- ggplot(df_toplot, aes(x=spans, y=err, group=factor(degrees))) + 
  geom_point() + geom_line(aes(col=factor(degrees)))
plt


#TO DO: display the parameters corresponding to the minimum error.
best <- ???
best


#TO DO: plot the resulting smoothed curve.
res <- ??? 
plot(polls_2008$day, polls_2008$margin)
lines(predict(res), col='blue')






#TO DO: Perform k-fold CV for k=3 by considering the same values of 
# degree and span as previously
set.seed(123)
flds <- ???

degree_list <- list()
for(deg in 1:2){ #polynomial degree
  err <- list()
  for(k in 1:length(span_values)){ #smoothness
    score <- list()
    for(i in 1:length(flds)){
      validation <- polls_2008[unlist(flds[i]),]
      training <- polls_2008[unlist(flds[-i]),]
      model = loess(margin ~ day, data = training, span = span_values[k],
                    degree=deg) 
      pred = na.omit(predict(model, validation))
      # error of ith fold
      score[[i]] = (validation$margin - pred)^2
    }
    err[[k]] <- mean(unlist(score))
  }
  degree_list[[deg]] <- unlist(err)
}


# prepare dataframe for ggplot
spans <- rep(span_values,2)
degrees <- rep(c(1,2), each = length(span_values))
err <- unlist(degree_list)
df_toplot <- as.data.frame(cbind(spans,degrees,err))

#TO DO: comment the results
plt <- ggplot(df_toplot, aes(x=spans, y=err, group=factor(degrees))) + 
  geom_point() + geom_line(aes(col=factor(degrees)))
plt


#TO DO: display the parameters corresponding to the minimum error.
best <- ???
best


#TO DO: plot the resulting smoothed curve.
res <- ??? 
plot(polls_2008$day, polls_2008$margin)
lines(predict(res), col='blue')





#TO DO: perform Temporal Block "Cross" Validation by considering the same values
# of degree and span as previously. Use a rolling window of size 100 and horizon $h=1$.

flds <- ???



degree_list <- list()
for(deg in 1:2){ #polynomial degree
  err <- list()
  for(k in 1:length(span_values)){ #smoothness
    score <- list()
    for(i in 1:length(flds$test)){
      validation <- polls_2008[unlist(flds$test[i]),]
      training <- polls_2008[unlist(flds$train[-i]),]
      model = loess(margin ~ day, data = training, span = span_values[k],
                    degree=deg) 
      pred = na.omit(predict(model, validation))
      # error of ith fold
      score[[i]] = (validation$margin - pred)^2
    }
    err[[k]] <- mean(unlist(score))
  }
  degree_list[[deg]] <- unlist(err)
}


# prepare dataframe for ggplot
spans <- rep(span_values,2)
degrees <- rep(c(1,2), each = length(span_values))
err <- unlist(degree_list)
df_toplot <- as.data.frame(cbind(spans,degrees,err))


#TO DO: comment the results
plt <- ggplot(df_toplot, aes(x=spans, y=err, group=factor(degrees))) + 
  geom_point() + geom_line(aes(col=factor(degrees)))
plt


#TO DO: display the parameters corresponding to the minimum error.
best <- ???
best


#TO DO: plot the resulting smoothed curve.
res <- ???
plot(polls_2008$day, polls_2008$margin)
lines(predict(res), col='blue')












