#' Masking of double recombinations at chromosome ends
#'
#' Sets double recombination calls at the start and end of chromosomes to missing, e.g. in the chromosome start sequence of 5'-AAHH or end sequence BBAA-3', both AAs are replaced by NN.
#'
#' @param inputGenos ABH genotype file to mask.
#' @param maxHapLength Max length (in number of markers) of double recombination haplotype to set to missing. Default is 1.
#' @keywords mask
#' @export
#' @examples
#' data(abhgeno)
#' g <- maskChromosomeEnds(abhgeno, 4)
#' g
#'
#' @importFrom ABHgenotypeR reportGenos

maskChromosomeEnds <- function (inputGenos, maxHapLength = 1)
{
  geno_raw <- inputGenos$ABHmatrix
  geno_correctedHets <- matrix(0, nrow = nrow(geno_raw), ncol = ncol(geno_raw))
  patExprH <- NULL
  for (x in c("ABH","BAH","HAB")) {
    for (i in 1:maxHapLength) {
      patExprH <- c(patExprH, paste("^([", substring(x,2,3),
                                    "N]{", i,
                                    "})(?=", substring(x,1,1),
                                    ")", sep = ""),
                    paste("(?<=", substring(x,1,1),
                          ")([", substring(x,2,3),
                          "N]{", i, "})$", sep = ""))
    }
  }
  replExprH <- NULL
  for (x in c("ABH","BAH","HAB")) {
    for (i in 1:maxHapLength) {
      replExprH <- c(replExprH,
                     paste(rep("N", i), sep = "", collapse = ""),
                     paste(rep("N", i), sep = "", collapse = ""))
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
                                                        inputGenos$chrom ==
                                                          chrom_count],
                                     collapse = ""),
                           pattern = patExprH[HapLen], replacement = replExprH[HapLen],
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
