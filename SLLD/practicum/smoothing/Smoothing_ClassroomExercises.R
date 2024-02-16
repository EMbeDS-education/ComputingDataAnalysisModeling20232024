######################################################## 
###### Smoothing - Classroom Exercises - 15/2/2024 ###### 
######################################################## 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(tidyverse) # for data manipulation and visualization
library(ggplot2) # for plots



### Data
# We will try to locally regress and smooth the median 
# duration of unemployment (uempmed) based on the
# economics dataset from ggplot2 package.
# We will focus on the latest 120 months (10 years from 
# 2005 to 2015)


data(economics)
help(economics)
head(economics)
dim(economics)

# We focus on the latest 120 months.
economics <- economics[(nrow(economics)-119):nrow(economics),]
dim(economics)

plot(economics$date, economics$uempmed)
lines(economics$date, economics$uempmed, col='grey60')


# Transform the dates into indexed from 1 (first measurement in 2005) to 120 (latest measurement in 2015).
economics$index <- 1:120


#TO DO: perform LOWESS using the lowess function
# by using the default value and 0.2
???


#TO DO: perform LOWESS through the loess command with span =
# 0.1, 0.25 and 5 and degree = 1 and 2. Comment the results
  
# span=0.10
loess1_10 <- ???
loess2_10 <- ???
???

# span=0.25
loess1_25 <- ???
loess2_25 <- ???
???

# span=0.5
loess1_50 <- ???
loess2_50 <- ???
???

### Kernel Smoothing

#TO DO: perform Kernel Smoothing with "box" and
# "normal" kernel, both with a bandwidth of size 3
window <- 3

box_smooth <- ???

norm_smooth <- ???
  
???
  
???


# It is still wiggly! We need to change the bandwidth.

#TO DO: perform the "normal" kernel with a bandwidth of size 6.

window <- 6 #6 month's time
norm_smooth <- ???
  
???



### Kernel Density Estimator

#Let’s simulate a new dataset, containing gender 
#(as M/F) and weight of 400 subjects living on an 
# undefined region of the universe.
set.seed(1234)
df <- data.frame(
  sex=factor(rep(c("F", "M"), each=200)),
  weight=round(c(rnorm(200, mean=55, sd=5),
                 rnorm(200, mean=65, sd=5)))
)
head(df)


#TO DO: produce a histogram and its density through ggplot
???
  

#TO DO: adjust the default density through the adjust argument.
# Set it at 1/2 and 2. 
???
  
???  
  

  
  
  
  