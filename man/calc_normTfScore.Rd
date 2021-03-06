% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/grn_tfScores.R
\name{calc_normTfScore}
\alias{calc_normTfScore}
\title{Calculate the TF normalization constant
Calculate the TF score given all the parameters}
\usage{
calc_normTfScore(
  tf,
  targs,
  sampleID,
  netGenes,
  weights,
  grnTable,
  correlationFactor = 1
)
}
\arguments{
\item{tf}{TF}

\item{targs}{a list of targets for TF}

\item{sampleID}{the sample ID}

\item{netGenes}{genes selected for building the subnetwork}

\item{weights}{a vector of weights for each gene}

\item{grnTable}{the grn table with correlation values and signs}

\item{correlationFactor}{the weight of correlation between}
}
\description{
Calculate the TF normalization constant
Calculate the TF score given all the parameters
}
