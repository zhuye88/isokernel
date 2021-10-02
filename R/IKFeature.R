#' @importFrom RANN
#' @importFrom Matrix
#' @useDynLib isokernel, .registration=TRUE

#' @title Build Isolation Kernel feature vector representations via the feature map
#' for a given dataset.
#' @description Isolation kernel is a data dependent kernel measure that is
#' adaptive to local data distribution and has more flexibility in capturing
#' the characteristics of the local data distribution. It has been shown promising
#' performance on density and distance-based classification and clustering problems.
#'
#' This version uses Voronoi diagrams to split the data space and calculate Isolation
#' kernel Similarity, following the paper: Qin, X., Ting, K.M., Zhu, Y. and Lee,
#' V.C., 2019, July. Nearest-neighbour-induced isolation similarity and its impact
#' on density-based clustering. In Proceedings of the AAAI Conference on Artificial
#' Intelligence (Vol. 33, pp. 4755-4762). Based on this implementation, the feature
#' in the Isolation kernel space is the index of the cell in Voronoi diagrams. Each
#' point is represented as a binary vector such that only the cell the point falling
#' into is 1.
#'
#'
#'
#' @param data A dataset used for applying Isolation kernel function. The data is a
#' n by d matrix, where n is the data size, d is the dimensionality.
#' @param Sdata The dataset use for generating Voronoi diagrams, it can be the same
#' as the input data.
#' @param psi The number of cells in each Voronoi diagram, it should be large
#' if there are more clusters or more complex structures in the data.
#' It could be [2, 4, 8, 16, 32, 64, 128, 256, 512, 1024].
#' @param t The number of Voronoi diagrams, the higher the more stable the result.
#' @param Sp Indicating whether return the features as a sparse matrix.
#'
#' @return The finite binary features based on the kernel feature map. The features
#' are organised as a n by psi*t matrix.
#'
#' @examples
#' library(isokernel)
#' df <- matrix(1:50, nrow = 5, ncol = 10)
#' IKFeatures <- IKFeature(data=df,psi=4,t=200)
#'
#' @export

IKFeature <- function(data, Sdata=data, psi = 64, t = 200, Sp=TRUE) {

  sizeS <- nrow(Sdata)
  sizeN <- nrow(data)
  Feature <- matrix(, nrow = sizeN, ncol = 0)
  for (i in 1:t) {
    subIndex <- sample(1:sizeS, psi, replace = FALSE, prob = NULL)
    tdata <- Sdata[subIndex, ]
    NN <- RANN::nn2(tdata, data, k = 1) # find the nearest negibour
    OneFeature <- matrix(0, nrow = sizeN, ncol = psi)
    OneFeature <- Matrix::Matrix(OneFeature, sparse=Sp)
    ind <- cbind(1:sizeN,NN$nn.idx)
    OneFeature[ind] <- 1 # update non-zero values
    Feature<- cbind(Feature, OneFeature)
  }
  if (Sp == TRUE){
    Feature # binary feature matrix based on Isolation kernel
  }else{
    as.matrix(Feature) # return full matrix
  }
}
