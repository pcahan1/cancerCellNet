% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/makeClassifier.R
\name{makeClassifier}
\alias{makeClassifier}
\title{Make Classifier}
\usage{
makeClassifier(
  expTrain,
  genes,
  groups,
  nRand = 50,
  ntrees = 2000,
  stratify = FALSE,
  sampsize = 40
)
}
\arguments{
\item{expTrain}{transformed training data from \code{\link{query_transform}}}

\item{genes}{vector of gene pairs from \code{\link{ptGetTop}} used as predictors}

\item{groups}{named vector of cells to cancer categories}

\item{nRand}{number of randomized profiles to make}

\item{ntrees}{number of trees to build}

\item{stratify}{whether to use stratified sampling or not}

\item{samplesize}{the samplesize for straified sampling}
}
\value{
Random Forest Classifier object
}
\description{
Create a random forest classifier with the transformed training data from \code{\link{query_transform}}.
}
