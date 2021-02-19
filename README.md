# gtmask : Mask double recombinations calls in genetic maps

This R package extends the package [ABHgenotypeR](https://github.com/StefanReuscher/ABHgenotypeR/) written by Reuscher and Furuta (2016).

This sets double recombinants to missing with `maskTransitionSites()` (e.g. in the sequence HHAABB, AA is replaced by missing data, NN), and sets double recombinant calls at the start and end of chromosomes to missing with `maskChromosomeEnds()` (e.g. in the chromosome start sequence of 5’-AAHH or end sequence BBAA-3’, both AAs are replaced by NN).

## Installation

```
library(devtools)
install_github("jcignacio/gtmask")
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
