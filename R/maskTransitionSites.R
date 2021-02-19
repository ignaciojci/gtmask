#' Masking of double recombinations at homozygous-heterozygous transition sites
#'
#' Sets short double recombination calls to missing, e.g. in the sequence HHAABB, AA is replaced by missing data, NN.
#'
#' @param inputGenos ABH genotype file to mask.
#' @param maxHapLength Max length (in number of markers) of double recombination haplotype to set to missing. Default is 1.
#' @export
#' @examples
#'
#' # replaces double recombination transitions up to 4 marker lengths
#' data(abhgeno)
#' g <- maskTransitionSites(abhgeno, 4)
#' g
#'
#' @importFrom ABHgenotypeR reportGenos

maskTransitionSites <- function (inputGenos, maxHapLength = 1)
{
  geno_raw <- inputGenos$ABHmatrix
  geno_correctedHets <- matrix(0, nrow = nrow(geno_raw), ncol = ncol(geno_raw))
  patExprH <- NULL
  for (x in c("HAB","HBA","ABH","BAH")) {
    for (i in 1:maxHapLength) {
      patExprH <- c(patExprH,
                    paste("(", substring(x,1,1),
                          ")([", substring(x,2,2),
                          "N]{", i, "})(?=",
                          substring(x,3,3),")", sep = ""))
    }
  }
  replExprH <- NULL
  for (x in c("HAB","HBA","ABH","BAH")) {
    for (i in 1:maxHapLength) {
      replExprH <- c(replExprH,
                     paste("\\1", paste(rep("N", i),sep = "", collapse = ""),
                           sep = "", collapse = ""))
    }
  }

  for (chrom_count in unique(inputGenos$chrom)) {
    geno_temp <- geno_raw[, inputGenos$chrom == chrom_count]
    for (row_count in 1:nrow(geno_correctedHets)) {
      for (HapLen in 1:length(patExprH)) {
        if (HapLen == 1) {
          geno_correctedHets[row_count, inputGenos$chrom == chrom_count] <-
            substring(gsub(x = paste(geno_temp[row_count,], collapse = ""),
                           pattern = patExprH[HapLen],
                           replacement = replExprH[HapLen], perl = TRUE),
                      1:ncol(geno_temp), 1:ncol(geno_temp))
        }
        else {
          geno_correctedHets[row_count, inputGenos$chrom == chrom_count] <-
            substring(gsub(x = paste(geno_correctedHets[row_count,
                                                        inputGenos$chrom == chrom_count],
                                     collapse = ""),
                           pattern = patExprH[HapLen],
                           replacement = replExprH[HapLen],
                           perl = TRUE), 1:ncol(geno_temp), 1:ncol(geno_temp))
        }
      }
    }
  }
  outputGenos <- inputGenos
  outputGenos$ABHmatrix <- geno_correctedHets
  dimnames(outputGenos$ABHmatrix) <- list(individual_names = inputGenos$individual_names,
                                          marker_names = inputGenos$marker_names)
  reportGenos(inputGenos)
  cat(paste("\n"))
  reportGenos(outputGenos)
  outputGenos
}
