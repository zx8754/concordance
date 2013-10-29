Concordance Typed and Imputed SNPs
===========
### Example input files
#### Impute output
```
impute.gen
impute.sample
```
#### Plink raw output *--recodeA* option
```
plink.raw
```
### Run
```
Rscript concordance.R impute.gen impute.sample plink.raw rs17599629
```
### Output
Scatter plot - `rs17599629.png` file.

![rs17599629.png](https://raw.github.com/zx8754/concordance/master/rs17599629.png)


Correlation summary for rs17599629
```
         SNP MatchingSamples MatchingSamplesExclNoCall Concordance
1 rs17599629            1267                       911   0.9223097
```
