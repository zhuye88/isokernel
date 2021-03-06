# isokernel (R package for Isolation Kernel)

https://cran.r-project.org/web/packages/isokernel/index.html

@YE ZHU, Deakin University

### Install and load the package

```r
install.packages("isokernel")
```
```r
library(isokernel)
```
### Get features based on the kernel feature map 
```r
df <- iris
SIKFeatures <- IKFeature(df[,1:4],psi=4,t=200) # SIKFeatures is a sparse matrix. 
# By default, IKFeature returns a sparse matrix to save the memory as Sp=TRUE.

FIKFeatures <- IKFeature(df[,1:4],psi=4,t=200,Sp=FALSE) # FIKFeatures is a full matrix. 
# It is the same as using as.matrix(SIKFeatures).
```
### Calculate the pairwise Isolation kernel similarity
The similarity matrix is the inner products between all pairs of data in the feature space.  

```r
df <- iris
SimMatrix <- IKSimilarity(data=df[,1:4],psi=4,t=200)
```

### Calculate the Isolation kernel similarity between A and B

```r
A <- iris[1:10,1:4]
B <- iris[21:40,1:4]
S <- rbind(A,B)
t <- 200
FA <- IKFeature(A,S,psi=4,t=200) # Kernel space features for A
FB <- IKFeature(B,S,psi=4,t=200) # Kernel space features for B

SimAB <- FA%*%t(as.matrix(FB))/t  # dot product between all pairs of data in the feature space. 
# If an algorithm needs a full similarity matrix as an input, then use as.matrix(SimAB) to suit it. 
# To get a dissimilarity matrix, just simply use 1-SimAB.
```

**A demonstration of using Isolation Kernel for clustering in R is published: https://rpubs.com/zhuye88/IK**

# Description 
Different kernel methods have been developed to improve the performance of existing distance-based clustering algorithms such as kernel k-means and spectral clustering. Recently, the Isolation Kernel [1,2,3,4] has been proposed to be a more effective data-dependent similarity measure such that *two points in a sparse region are more similar than two points of equal inter-point distance in a dense region*. This measure is adaptive to local data distribution and has *more flexibility in capturing the characteristics of the local data distribution*. It has been shown promising performance on density and distance-based classification and clustering problems.

This R package uses Voronoi diagrams to split the data space and calculate Isolation kernel similarity [1]. Based on this implementation, the feature in the Isolation kernel space is the index of the cell in Voronoi diagrams. Each point is represented as a binary vector such that only the cell the point falling into is 1. The similarity matrix is the inner products between all pairs of data in the feature space.

IKFeature function will return the finite binary features based on the kernel feature map. IKSimilarity function calculates the similarity kernel measure. Therefore, we can use IKFeature for algorithms that require the features as an input (e.g., k-means), while use IKSimilarity for algorithms that require the similarity/dissimilarity matrix as an input (e.g., k-medoids).

Parameter *psi* is the number of cells in each Voronoi diagram, it should be large if there are more clusters or more complex structures in the data, but it must be less than the Sdata size. It could be [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]. Parameter *t* is the number of Voronoi diagrams, the higher t value, the more stable the result, but cost more time to run.

[1] Qin, X., Ting, K.M., Zhu, Y. and Lee, V.C., 2019, July. Nearest-neighbour-induced isolation similarity and its impact on density-based clustering. In Proceedings of the AAAI Conference on Artificial Intelligence (Vol. 33, pp. 4755-4762).

[2] Ting, K.M., Xu, B.C., Washio, T. and Zhou, Z.H., 2020, August. Isolation Distributional Kernel: A New Tool for Kernel based Anomaly Detection. In Proceedings of the 26th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining (pp. 198-206).

[3] Ting, K.M., Wells, J.R. and Washio, T., 2021. Isolation kernel: the X factor in efficient and effective large scale online kernel learning. Data Mining and Knowledge Discovery, pp.1-31.

[4] Ting, K.M., Zhu, Y. and Zhou, Z.H., 2018, July. Isolation kernel and its effect on SVM. In Proceedings of the 24th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining (pp. 2329-2337).

