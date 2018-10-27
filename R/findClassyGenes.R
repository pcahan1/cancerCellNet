#' Find candidate classifier-worthy genes
#'
#' Find classifier-worthy genes for each cancer category to train the classifier
#'
#' @param expDat a matrix of normalized expressiond data from \code{\link{trans_prop}}
#' @param sampTab a dataframe of the sample table
#' @param dLevel a string indicating the column name in sample table that contains the cancer category
#' @param topX an integer indicating the number of top classification genes to select for training
#' @param dThresh a number representing the detection threshold
#' @param alpha1 a number representing proportion of cells in which a gene must be considered detected (as defined in geneStats)
#' @param alpha2 a number representing lower proportion of cells for genes that must have higher expression level
#' @param mu a number represeting threshold for average expression level of genes passing the lower proportion criteria
#'
#' @return a list containing two lists: a list of classifier worthy genes named 'cgenes' and a list of cancer category named 'grps'
#'
#' @export
findClassyGenes<-function(expDat, sampTab, dLevel, topX=25, dThresh=0, alpha1=0.05, alpha2=.001, mu=2) {
  gsTrain<-sc_statTab(expDat, dThresh=dThresh)
  ggenes<-sc_filterGenes(gsTrain, alpha1=alpha1, alpha2=alpha2, mu=mu)
  grps<-as.vector(sampTab[,dLevel])
  names(grps)<-rownames(sampTab)
  xdiff<-gnrAll(expDat[ggenes,], grps)
  cgenes<-lapply(xdiff, getClassGenes, topX=topX)
  cgenes<-unique(unlist(cgenes))
  list(cgenes=cgenes, grps=grps)
}



#' @title
#' Find Genes that Pass Criteria
#' @description
#' Based on idea that reliably detected genes will either be detected in many cells, or highly expressed in a small number of cells or both
#' @param geneStats a matrix containing stats of genes generated from running \code{\link{sc_statTab}}
#' @param alpha1 a number representing proportion of cells in which a gene must be considered detected (as defined in geneStats)
#' @param alpha2 a number representing lower proportion of cells for genes that must have higher expression level
#' @param mu a number represeting threshold for average expression level of genes passing the lower proportion criteria
#' @return a vector of gene symbols
#' @export
#'
sc_filterGenes<-function(geneStats, alpha1=0.1, alpha2=0.01, mu=2){
  passing1<-rownames(geneStats[geneStats$alpha>alpha1,])
  notPassing<-setdiff(rownames(geneStats), passing1)
  geneStats<-geneStats[notPassing,]
  c(passing1, rownames(geneStats[which(geneStats$alpha>alpha2 & geneStats$mu>mu),]))
}

#' find genes higher in a cluster compared to all other cells
#' find genes higher in a cluster compared to all other cells
#' @param expDat a matrix of normalized gene expression taken from \code{\link(trans_prop)}
#' @param cellLabels a vector of all the named vector of cancer categories
#' @return list of dataFrames containing pval, cval and holm for each gene in each cancer category
#' @export
gnrAll<-function(expDat, cellLabels){

  myPatternG<-sc_sampR_to_pattern(as.character(cellLabels))
  specificSets<-lapply(myPatternG, sc_testPattern, expDat=expDat)
  cat("Done testing\n")

  #  grpOrder<-myGrpSort(cellLabels)

  #  specificSets[grpOrder]

  specificSets
}

#' Find Classy Genes
#'
#' Extract genes suitable for training classifier
#' @param diffRes a dataframe with pval, cval, holm, and rownames as the gene names
#' @param topX a number dicataing the number of genes to select for training classifier
#' @param bottom logic if true use the top x genes with - cvals
#'
#' @return a vector of genes that are good for training classifier for that category
#'
#' @export
getClassGenes<-function(diffRes, topX=25, bottom=TRUE) {
  #exclude NAs
  xi<-which(!is.na(diffRes$cval))
  diffRes<-diffRes[xi,] # exclude the NAs. Select the rows that does not have NAs

  diffRes<-diffRes[order(diffRes$cval, decreasing=TRUE),] #order based on classification value largest to lowest
  ans<-rownames(diffRes[1:topX,]) # get the top 20 genes

  if(bottom){
    ans<-append(ans, rownames( diffRes[nrow(diffRes) - ((topX-1):0),]))
  }
  ans
}