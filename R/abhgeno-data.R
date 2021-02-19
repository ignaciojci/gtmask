#' Rice F2 genotype data
#'
#' Genotypic data from a QTL mapping experiment
#' Rice, with data on 200 F2 lines (IR64 x ASD1) and 3436 SNP markers.
#'
#' @docType data
#'
#' @usage data(abhgeno)
#'
#' @format An object of class \code{"list"}; imported with \code{readABHgenotypes} from \code{ABHgenotypeR}.
#'
#' @keywords datasets
#'
#' @examples
#' data(abhgeno)
#' j <- imputeByFlanks(abhgeno)
#' h <- correctUndercalledHets(j, 10)
#' k <- correctStretches(h, 7)
#' l <- maskTransitionSites(k, 4)
#' m <- maskChromosomeEnds(l, 4)
"abhgeno"
