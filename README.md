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
Scatter plot PNG file - `rs17599629.png`.

![rs17599629.png](https://raw.github.com/zx8754/concordance/master/rs17599629.png)

Scatter plot data file - `rs17599629_PlotFile.txt`
```
head rs17599629_PlotFile.txt

IID Imputed Typed
Sample2501 0 0
Sample2536 0.001 0
Sample2537 0 0
Sample2538 0.997 1
Sample2539 0 0
Sample2540 0.684 1
Sample2541 0.997 1
Sample2542 0.992 1
Sample2543 1.093 1
```
Correlation summary for rs17599629:

- *MatchingSamples* - typed and imputed samples overlap.
- *MatchingSamplesExclNoCall* - typed and imputed samples overlap, excluding NoCalls.
- *Concordance* - correlation between imputed and typed SNP.

```
         SNP MatchingSamples MatchingSamplesExclNoCall Concordance
1 rs17599629            1267                       911   0.9223097
```
