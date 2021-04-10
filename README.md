# gtmask : Mask potentially erroneous genotype calls in genetic maps

This R package extends the package [ABHgenotypeR](https://github.com/StefanReuscher/ABHgenotypeR/) written by Reuscher and Furuta (2016).

This sets double recombinants to missing with `maskTransitionSites()` (e.g. in the sequence HHAABB, AA is replaced by missing data, NN), and sets potentially erroneous calls at the start and end of chromosomes to missing with `maskChromosomeEnds()` (e.g. in the chromosome start sequence of 5’-AAHH or end sequence BBAA-3’, both AAs are replaced by NN). The output is compatible for analysis with [R/qtl](https://github.com/kbroman/qtl) by Karl Broman.

## Installation

```
library(devtools)
Sys.setenv(R_REMOTES_NO_ERRORS_FROM_WARNINGS=TRUE)
install_github("johncarlosignacio/gtmask")
```

## Example

Perform imputation, correction, and masking.

```
library(gtmask)
j <- imputeByFlanks(abhgeno)
h <- correctUndercalledHets(j, 10)
k <- correctStretches(h, 7)
l <- maskTransitionSites(k, 4)
m <- maskChromosomeEnds(l, 4)
m
```
## Citation

Ignacio, J.C.I.; Zaidem, M.; Casal, C., Jr.; Dixit, S.; Kretzschmar, T.; Samaniego, J.M.; Mendioro, M.S.; Weigel, D.; Septiningsih, E.M. Genetic Mapping by Sequencing More Precisely Detects Loci Responsible for Anaerobic Germination Tolerance in Rice. *Plants* **2021**, 10, 705. https://doi.org/10.3390/plants10040705
