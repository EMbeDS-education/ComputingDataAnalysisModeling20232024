########################################################################## 
###### Supervised Dimension Reduction - Classroom Exercises - 13/3/2024 ###
##########################################################################


####################################################
### compile the required code when "TO DO:" appears
####################################################


### Libraries
library(tidyverse)  # data manipulation and visualization
library(plotly)     # plots in 3D
library(ggplot2)    # plots in 2D
library(ggpubr)     # to combine multiple ggplot objects (ggarrenge)
library(mvtnorm)    # to generate multivariate normal distribution
library(dr)         # SIR
library(factoextra) # PCA-related functions


### Data
# Let's first define a function to generate Gaussian data. 
# This function takes four arguments:
# - n: number of observations;
# - center: the mean vector
# - sigma: the covariance matrix
# - label: the cluster label

generateGaussianData <- function(n, center, sigma, label) {
  data = rmvnorm(n, center, sigma)
  data = data.frame(data)
  names(data) = c("x", "y", "z")
  data = data %>% mutate(class=factor(label))
  data
}


# Now let's simulate a dataset.
covmat <- matrix(c(1,0.88,0.88,0.88, 1,0.88,0.88,0.88, 1), 
                 nrow = 3, byrow=T)

# cluster 1
n = 200
center = c(2, 8, 6)
sigma = covmat
group1 = generateGaussianData(n, center, sigma, 1)

# cluster 2
n = 200
center = c(4, 8, 6)
sigma = covmat
group2 = generateGaussianData(n, center, sigma, 2)

# cluster 3
n = 200
center = c(6, 8, 6)
sigma = covmat
group3 = generateGaussianData(n, center, sigma, 3)

# all data
df = bind_rows(group1, group2, group3)

head(df)
summary(df)

#And plot our simulated data.


fig <- plot_ly(df, x = ~x, y = ~y, z = ~z, 
               color = ~class, colors = c('#b3e378', '#81e5f0', '#ed5391'))
fig <- fig %>% add_markers()
fig <- fig %>% layout(scene = list(xaxis = list(title = 'x'),
                                   yaxis = list(title = 'y'),
                                   zaxis = list(title = 'z')))
fig


### PCA vs LDA

## PCA

#TO DO: perform PCA and the corresponding biplot.
pc <- ???
get_eig(pc)

???
  

#TO DO: Is it possible to notice differences within the 
# three groups just by considering the first principal component?


## LDA

#TO DO: perform LDA and plot the projections on LD1 and LD2

lda.df <- ???
lda.df

# prediction on df to get projections
???
  
# projections with LDA classes
estclass <- ???
newdata2 <- ???
p1 <- ???

# projections with true classes
newdata <- ???
p2 <- ???


ggarrange(p1,p2,nrow=2)


### SIR

#TO DO: perform SIR (Sliced Inversion Regression) with 3 slices
dr_res <- ???
dr_res
plot(dr_res, col=df$class)


#TO DO: perform SIR on real data with continuos outcome with 3 and 6 slices
data(ais)
?ais
dr_res3 <- ???
plot(dr_res3, col=dr_res3$slice.info$slice.indicator)

dr_res6 <- ???
plot(dr_res6, col=dr_res6$slice.info$slice.indicator)







