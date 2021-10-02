#' @importFrom RANN
#' @importFrom Matrix
#' @useDynLib isokernel, .registration=TRUE

#' @title Calculate pairwise Isolation Kernel Similarity for a given dataset
#' @description Isolation kernel is a data dependent kernel measure that is
#' adaptive to local data distribution and has more flexibility in capturing
#' the characteristics of the local data distribution. It has been shown promising
#' performance on density and distance-based classification and clustering problems.
#'
#' This version uses Voronoi diagrams to split the data space and calculate Isolation
#' kernel Similarity, following the paper: Qin, X., Ting, K.M., Zhu, Y. and Lee,
#' V.C., 2019, July. Nearest-neighbour-induced isolation similarity and its impact
#' on density-based clustering. In Proceedings of the AAAI Conference on Artificial
#' Intelligence (Vol. 33, pp. 4755-4762). Based on this implementation, the higher
#' the probability of two data points (x and y) falling into the same cell of a Voronoi
#' diagram, the more the similar between the two points. Therefore, Isolation kernel
#' is adaptive to the local density, i.e., two points are less likely to fall into
#' the same cell unless they are very close in a dense region, because more cells are
#' generated in the dense region than in the sparse region.
#'
#'
#' @param data A dataset used for applying Isolation kernel function. The data is a
#' n by d matrix, where n is the data size, d is the dimensionality.
#' @param Sdata The dataset use for generating Voronoi diagrams, it can be the same
#' as the input data.
#' @param psi The number of cells in each Voronoi diagram, it should be large
#' if there are more clusters or more complex structures in the data.
#' It could be [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024].
#' @param t The number of Voronoi diagrams, the higher the more stable the result
#'
#' @return A n by n similarity matrix based on Isolation kernel. The similarity matrix
#' is the inner products between all pairs of data in the feature space. The feature
#' vectors in the Isolation kernel space are built by IKFeature function.
#'
#' @examples
#' ### 1. calculate the pairwise Isolation kernel similarity in the iris dataset
#' library(isokernel)
#' df <- iris
#' SimMatrix <- IKSimilarity(data=df[,1:4],psi=4,t=200)
#'
#' @examples
#' ### 2. calculate the Isolation kernel similarity between A and B
#' library(isokernel)
#' A <- iris[1:10,1:4]
#' B <- iris[21:40,1:4]
#' S <- rbind(A,B)
#' t <- 200
#' FA <- IKFeature(A,S,psi=4,t=200) # Kernel space features for A
#' FB <- IKFeature(B,S,psi=4,t=200) # Kernel space features for B
#' SimAB <- FA%*%t(as.matrix(FB))/t  # dot product on FA and FB

#' @export
#'
IKSimilarity <- function(data, Sdata=data, psi = 64, t = 200) {

  Feature<-IKFeature(data, Sdata, psi, t)
  SimMatrix <- Feature%*%t(as.matrix(Feature))/t # the similarity matrix based on Isolation kernel

}
