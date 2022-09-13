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
#counts_dir: a directory where .sim.isoforms.results from script 2c-01 are placed after changing 5th column name into "expected_count" instead of "count"
#sim_tx2gene_file_path: two column text file (transcript ID-gene ID) separated by space (view tx2gene.csv example file) for transcriptome gene IDs

#VARIABLES DEFINITION
wd <- ""

samples_description_file_path <- ""
counts_dir <- ""
sim_tx2gene_file_path <- ""

#Libraries load
library("tximport")
library("readr")
library("DESeq2")
library("IHW")
library("apeglm")

#Data import from tximport
setwd(wd)
samples <- read.table(file.path(samples_description_file_path), header=TRUE)
samples$group <- factor(samples$group)
rownames(samples) <- samples$sample

files <- file.path(counts_dir, paste(samples$sample, ".sim.isoforms.results", sep=""))
names(files) <- samples$sample
tx2gene <- read.csv(file.path(sim_tx2gene_file_path), sep =" ")

txi <- tximport(files, type="rsem", tx2gene = tx2gene)

#DESeqDataSet construction
dds <- DESeqDataSetFromTximport(txi,
                                   colData = samples,
                                   design = ~ group)

#Pre-filtering
keep <- rowSums(counts(dds)) >= 30
dds <- dds[keep,]

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
res0001IHWSigadj <- subset(res0001IHWOrderedadj, padj < 0.001)
res0001IHWSigadj

write.csv(as.data.frame(res0001IHWSigadj),
          file="simGS_DESeq2.csv")
