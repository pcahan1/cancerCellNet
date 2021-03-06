#' @title
#' Sub-class Query Transform
#'
#' @description
#' Transform the sub-class query expression data
#'
#' @param expDat query expression data
#' @param cgenes classification genes
#' @param xpairs classification gene pairs
#' @param classMatrix classification matrix of the query expression data from broad classifier
#' @return transformed sub-class query matrix
#'
#' @export
subClassQuery_transform<-function(expDat, cgenes, xpairs, classMatrix) {
   expValTrans = query_transform(expDat, xpairs)

   extraFeatures = classMatrix[, colnames(expValTrans)]
   if (all(colnames(expValTrans) == colnames(extraFeatures))) {
      cat("Finished with subclass pairTransform\n")
   }

   returnMatrix = rbind(expValTrans, extraFeatures)

   return(returnMatrix)
}
