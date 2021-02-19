#' gtmask: Mask potentially erroneous double recombinants in genotype maps
#'
#' Set double recombinants to missing with \code{maskTransitionSites()} (e.g. in
#' the sequence HHAABB, AA is replaced by missing data, NN), and set erroneous
#' calls at the start and end of chromosomes to missing with
#' \code{maskChromosomeEnds()} (e.g. in the chromosome start sequence of 5'-AAHH or
#' end sequence BBAA-3', both AAs are replaced by NN).
#'
#' @name gtmask-package
#' @aliases gtmask
#' @docType package
NULL
