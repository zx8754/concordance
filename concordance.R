# About -------------------------------------------------------------------
# Author: Tokhir Dadaev
# Date: 20/10/2013
# Concordance Typed and Imputed SNPs

# Input Arguments ---------------------------------------------------------
args<-commandArgs(TRUE)
if(length(args)!=4) {
  print(paste0("Note: gen/sample files - standard IMPUTE output files."))
  print(paste0("      plink raw file - plink output with '--recode' option."))
  print(paste0("Example: Rscript Concordance.R impute.gen impute.sample plink.raw rs12345"))
  stop("Provide 4 arguments")
}

file_impute_gen <- args[1]
file_impute_sample <- args[2]
file_plink_raw_typed <- args[3]
snp <- args[4]

paste0("Input imputed gen file ",file_impute_gen)
paste0("Input imputed sample file ",file_impute_sample)
paste0("Input typed raw file ",file_plink_raw_typed)
paste0("Concordance is calculated for SNP ",snp)

# Data Prep ---------------------------------------------------------------

#read Taqman typed - plink RAW file format, use --recodeA option
plink <- read.table(file_plink_raw_typed, header=T,as.is=T)
plink <- plink[,c(-1,-3:-6)]
#remove underscore, to match impute SNP names
colnames(plink) <- gsub(pattern="_.",replacement="",colnames(plink))

#read cambridge impute
impute_sample <- read.table(file_impute_sample,
                            header=T, quote="\"",as.is=T)
impute_sample <- impute_sample[-1,]
impute_gen <- read.table(file_impute_gen, quote="\"",as.is=T)

#Convert posterior to dosage
impute_gen12 <- impute_gen[,c(2:5)]
impute_gen12 <- cbind(impute_gen12,
                      sapply(seq(6,4145,3),
                             function(x) 
                               impute_gen[,x]*0+
                               impute_gen[,x+1]*1+
                               impute_gen[,x+2]*2))
colnames(impute_gen12) <- c("SNP","BP","A1","A2",impute_sample$ID_1)

#transpose
impute <- as.data.frame(t(impute_gen12[,-1:-4]))
colnames(impute) <- impute_gen12$SNP
impute$IID <- rownames(impute)

# Concordance -------------------------------------------------------------

#Check if SNP exists
if(sum(grepl(snp,colnames(impute)))!=1)
  stop("SNP is not found in imputed file.")
if(sum(grepl(snp,colnames(plink)))!=1)
  stop("SNP is not found in typed file.")

#Match by IID and subset SNP
d <- merge(impute[ ,c("IID",snp)], plink[ ,c("IID",snp)], by="IID")
colnames(d) <- c("IID","Imputed","Typed")
cnt_matching_samples <- nrow(d)

#Keep only complete.cases
d <- d[complete.cases(d),]
cnt_matching_samples_exclNA <- nrow(d)

#Correlation
corr <- cor(d$Imputed,d$Typed)

#BaseRPlot
png(paste0(snp,".png"))
plot(d$Imputed,d$Typed,
     pch=19,col="grey30",bty="n",xlim=c(0,2),ylim=c(0,2),
     xlab="Imputed",ylab="Typed",main=snp)
text(1,1.5,paste0("N=",cnt_matching_samples_exclNA,
                 " Corr= ",substr(corr,1,6)))
dev.off()

#Print summary output
data.frame(SNP=snp,
           MatchingSamples=cnt_matching_samples,
           MatchingSamplesExclNoCall=cnt_matching_samples_exclNA,
           Concordance=corr)
#Output plot file
write.table(d,paste0(snp,"_PlotFile.txt"),row.names=F,quote=F)


# Testing ggplot ----------------------------------------------------------

#file_impute_gen <- "impute.gen"
#file_impute_sample <- "impute.sample"
#file_plink_raw_typed <- "plink.raw"
#snp <- "rs12728254" 
#snp <- "rs17599629"
#snp <- "rs59654322"
#snp <- "rs636291"
#snp <- "rs1775148" #impute only
#snp <- "rs6625711" #typed only

#GGPlot
# p <- ggplot(d,aes(d[,2],d[,3])) +
#   geom_point(alpha=0.5,size=4)+
#   ggtitle(snp)+
#   xlab("Imputed") + ylab("Typed") +
#   xlim(0,2) + ylim(0,2) +
#   geom_text(data = NULL, x = 1, y = 1.5,
#             label = paste("N=",cnt_matching_samples_exclNA,
#                           "Corr=",round(corr,4)))
#Save plot it to a file
#ggsave(filename=paste0(snp,".png"),plot=p,width=4,height=4)
