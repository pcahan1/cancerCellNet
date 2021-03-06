% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ccn_classAssess.R
\name{cn_clPerf}
\alias{cn_clPerf}
\title{run cn_clPerf across thresholds}
\usage{
cn_clPerf(
  vect,
  sampTab,
  dLevel,
  classification,
  thresh,
  dLevelSID = "sample_id"
)
}
\arguments{
\item{vect}{named vector}

\item{sampTab}{sample table}

\item{dLevel}{description level}

\item{classification}{classification matrix}

\item{thresh}{seq of pval cutoffs}

\item{dLevelSID}{column to indicate sample id}
}
\value{
vector of TP FN FP TN
}
\description{
run cn_clPerf across thresholds
}
