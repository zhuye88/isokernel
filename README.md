# isokernel
Different kernel methods have been developed to improve the performance of existing distance-based clustering algorithms such as kernel k-means and spectral clustering. Recently, the Isolation Kernel [1,2,3,4] has been proposed to be a more effective data-dependent similarity measure such that *two points in a sparse region are more similar than two points of equal inter-point distance in a dense region*. This measure is adaptive to local data distribution and has *more flexibility in capturing the characteristics of the local data distribution*. It has been shown promising performance on density and distance-based classification and clustering problems.

This R package uses Voronoi diagrams to split the data space and calculate Isolation kernel similarity. Based on this implementation, the feature in the Isolation kernel space is the index of the cell in Voronoi diagrams. Each point is represented as a binary vector such that only the cell the point falling into is 1. The similarity matrix is the inner products between all pairs of data in the feature space.

IKFeature function will return the finite binary features based on the kernel feature map. IKSimilarity function calculates the similarity kernel measure. Therefore, we can use IKFeature for algorithms that require the features as an input (e.g., k-means), while use IKSimilarity for algorithms that require the similarity/dissimilarity matrix as an input (e.g., k-medoids).

[1] Qin, X., Ting, K.M., Zhu, Y. and Lee, V.C., 2019, July. Nearest-neighbour-induced isolation similarity and its impact on density-based clustering. In Proceedings of the AAAI Conference on Artificial Intelligence (Vol. 33, pp. 4755-4762).

[2] Ting, K.M., Xu, B.C., Washio, T. and Zhou, Z.H., 2020, August. Isolation Distributional Kernel: A New Tool for Kernel based Anomaly Detection. In Proceedings of the 26th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining (pp. 198-206).

[3] Ting, K.M., Wells, J.R. and Washio, T., 2021. Isolation kernel: the X factor in efficient and effective large scale online kernel learning. Data Mining and Knowledge Discovery, pp.1-31.

[4] Ting, K.M., Zhu, Y. and Zhou, Z.H., 2018, July. Isolation kernel and its effect on SVM. In Proceedings of the 24th ACM SIGKDD International Conference on Knowledge Discovery & Data Mining (pp. 2329-2337).
