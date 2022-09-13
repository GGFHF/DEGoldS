########################################################################
#DISCLAIMER
#DEGoldS is available for free download from the GitHub
#software repository (https://github.com/GGFHF/DEGoldS) under GNU
#General Public License v3.0.
#This software has been developed in memoriam of Dr. Pablo Goikoetxea
#who initiated this research along with researchers from NEIKER,
#Departamento de Sistemas y Recursos Naturales (Universidad Politécnica
#de Madrid) and Universidad del País Vasco (UPV/EHU).
########################################################################

#VARIABLES INSTRUCTIONS
#wd: Working directory
#samples_description_file_path: samples description text file path (view samples.txt example file)
#learn_dir:  "02-model_learning/output/" directory from script 2a-01

#VARIABLES DEFINITION
wd <- ""

samples_description_file_path <- ""
learn_dir <- ""

#Libraries load
library("tximport")
library("readr")
library("DESeq2")
library("IHW")
library("apeglm")

#Data import from tximport
setwd(wd)
samples <- read.table(file.path(samples_description_file_path), header=TRUE)
rownames(samples) <- samples$sample

files <- file.path(learn_dir, paste(samples$sample, ".isoforms.results", sep=""))
names(files) <- samples$sample

txi <- tximport(files, type="rsem", txOut = TRUE)

#DESeqDataSet construction
dds <- DESeqDataSetFromTximport(txi,
                                   colData = samples,
                                   design = ~ group)

#Differential expression analysis
dds <- DESeq(dds)
res0001IHW <- results(dds, contrast=c(0,1), filterFun=ihw, alpha=0.001)
res0001IHW

##p-values and adjusted p-values
res0001IHWOrdered <- res0001IHW[order(res0001IHW$pvalue),]
res0001IHWOrderedadj <- res0001IHW[order(res0001IHW$padj),]

summary(res0001IHW)

sum(res0001IHW$padj < 0.001, na.rm=TRUE)

metadata(res0001IHW)$ihwResult

#Exploring and exporting results
##Exporting results to CSV files
write.csv(as.data.frame(res0001IHWOrderedadj),
          file="01-nf_learning_DESeq2_all_seqs.csv")

res0001IHWSigadj <- subset(res0001IHWOrderedadj, padj < 0.001)
res0001IHWSigadj

write.csv(as.data.frame(res0001IHWSigadj),
          file="02-nf_learning_DESeq2_sig_seqs.csv")
