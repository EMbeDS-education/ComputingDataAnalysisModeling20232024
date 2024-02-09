######################################################### 
###### PCA - Classroom Exercises - 8/2/2024 ###### 
######################################################### 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(mvtnorm)    # for the toy simulated example
library(factoextra) # contains also decathlon data
library(scales)     # to create ggplot-like figures in base R (color transparency)
library(ellipse)    # to add elliptical confidence regions in base R plots
library(corrplot)   # correlation plots



### Data
# We are going to perform PCA to the first 10 columns of the 
# 'decathlon2'' data set to analyze athletes performance.
help(decathlon2)
head(decathlon2)


decathlon2<- decathlon2[, 1:10] # select only the first 10 columns
head(decathlon2)
dim(decathlon2)
summary(decathlon2)
corrplot(cor(decathlon2))



#TO DO: Scale the data and perform PCA 
PCA.dec <- ???
str(PCA.dec)


#TO DO: Select the number of components
#TIP: Use the appropriate function to find an 'elbow' on the
# cumulative PVE
???

#TO DO: How many PCs are needed to account 
# for 80% percent of the variance?
#TIP: Use the appropriate function to plot the cumulative PVE
???


#TO DO: Plot the first two PCs by using the correlation circle
# and comment on the results
???
  
  

#TO DO: Run the biplot of individuals and variables,
# and comment on the results
???








