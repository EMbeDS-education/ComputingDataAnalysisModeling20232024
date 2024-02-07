######################################################### 
###### Clustering - Classroom Exercises - 7/2/2024 ###### 
######################################################### 


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
# do not forget to install them first! e.g.,
# install.packages("cluster")
library(cluster)       # methods for Cluster analysis
library(factoextra)    # to extract and visualize the output of  multivariate analyses
library(utils)         # a general utility package
library(datasets)      # a variety of datasets



### Data
help(iris)
data("iris")
head(iris)
iris4 <- iris[,1:4]   # Excluding the "Species" label in column 5
iris4 <- scale(iris4) # Standardize (column-wise)

pairs(iris4, main="Iris Data (red=setosa,green=versicolor,blue=virginica)",
      pch=21, bg=c("red","green3","blue")[unclass(iris$Species)],
      oma=c(3,3,3,15))
par(xpd = TRUE)
legend("bottomright", fill = c("red","green3","blue"), legend = c( levels(iris$Species)))




### Agglomerative Hierarchical Clustering

#TO DO: create a dissimilarity matrix based on the Euclidean distance
eu_iris <- ???
as.matrix(eu_iris)[1:5,1:5] # distances between the first 5 observations


#TO DO: create the hierarchical structure, based on the 4 linkage methods
hc_single   <- ???
hc_complete <- ???
hc_average  <- ???
hc_centroid <- ???


#TO DO: use the function below to see the top 10 aggregations. 
# Which observations form the first cluster? 
head(hc_single$merge, 10) # see the first 10 aggregations

#TO DO: What was their distance?
#TIP: use as.matrix(eu_iris)[x,y] to look that the distance between x and y


#TO DO: report the dendrograms for the 4 linkage methods
???
???
???
???
???


#TO DO: cut the dendrogram in the case of 'complete' linkage for a desiderd 
# number of clusters k=2
cluster_k <- ???
cluster_k

???


#TO DO: Cut the dendrogram in the case of 'complete' linkage for a desiderd 
# height clHeight=4.5 (h=4.5). Plot the result
# How many clusters did you get?
clHeight <- 4.5
cluster_h <- ???
cluster_h

???





### K-Means Clustering

#TO DO: Perform K-means for k=3 with initial cluster assignments
# (nstart) equal to 1, 10, 30. 
#TIP: We want to minimize the total within-cluster sum of squares,
# which is reported in '..$tot.withinss'
set.seed(86)
km.2.1<- ???
km.2.10<-???
km.2.30<-???
???
???
???
  
  
#TO DO: Perform K-means for k=2 and k=3, both with nstart=10. 
#Perform a 'Silhouette widths' analysis
set.seed(86)
km.2 <- ???
km.3 <- ???

sil.2 <- ???
sil.3 <- ???

???
???




#TO DO: determine the number of clusters using 'Within cluster',
# 'Hartigan Index' and 'Average Silhouette' for both 
# Agglomerative Hierarchical and k-means


# Within cluster
???
???

  
# Hartigan Index
WSS_hc <- ???
harAHC <- NULL
for (i in 1:(length(WSS_hc)-1)) {
  harAHC[i] <- (nrow(iris4)-i-1)*(WSS_hc[i]-WSS_hc[i+1])/WSS_hc[i+1]
  Best.nc_hc<-which.max(harAHC)+1
}
plot(harAHC,type="l")
abline(v=Best.nc_hc, col="blue", lty=2)

WSS_km<- ??? 
harKM <- NULL
for (i in 1:(length(WSS_km)-1)) {
  harKM[i] <- (nrow(iris4)-i-1)*(WSS_km[i]-WSS_km[i+1])/WSS_km[i+1]
  Best.nc_km<-which.max(harKM)+1
}
plot(harKM,type="l")
abline(v=Best.nc_km, col="blue", lty=2)


# Average Silhouette
???

???

  
  
  





