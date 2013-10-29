Concordance Typed and Imputed SNPs
===========
### Example input files
#### Impute output
```
impute.gen
impute.sample
```
#### Plink raw output *--recode* option
```
plink.raw
```
### Run
```
Rscript Concordance.R impute.gen impute.sample plink.raw rs17599629
```
### Output
Scatter plot - `rs17599629.png` file
Correlation summary for rs17599629
```
         SNP MatchingSamples MatchingSamplesExclNoCall Concordance
1 rs17599629            1267                       911   0.9223097
```
