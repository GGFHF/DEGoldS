########################################################################
#DISCLAIMER
#DEGoldS is available for free download from the GitHub
#software repository (https://github.com/GGFHF/DEGoldS) under GNU
#General Public License v3.0.
#This software has been developed in memoriam of Dr. Pablo G. Goicoechea
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
library(edgeR)
library(tximport)

#Data import from tximport
setwd(wd)
samples <- read.table(file.path(samples_description_file_path), header = TRUE)
samples

files <- file.path(learn_dir, paste(samples$sample, ".isoforms.results", sep=""))
names(files) <- samples$sample
txi.rsem <- tximport(files, type = "rsem", txOut = TRUE)
head(txi.rsem$counts)

txi <- txi.rsem

cts <- txi$counts

x <- cts

colnames(x) <- c("group01_sample01","group01_sample02","group01_sample03","group02_sample01","group02_sample02","group02_sample03")
head(x)

group <- factor(samples$group)

#DGEList construction
y <- DGEList(counts=x,group=group)

#Filtering
keep <- filterByExpr(y)
y <- y[keep,,keep.lib.sizes=FALSE]

#Normalization
y <- calcNormFactors(y)

#Dispersion estimation
design <- model.matrix(~group)

y <- estimateDisp(y,design,robust=TRUE)

#DE genes testing
et <- exactTest(y)
topTags(et)
summary(decideTests(et))
FDR.et <- p.adjust(et$table$PValue, method="BH")
nfdr.et <- sum(FDR.et<0.001)
sorted.et <- topTags(et, n=10000000)
significant.et <- topTags(et, n=nfdr.et)

#Exporting results to CSV files
write.table(sorted.et$table, "01-learning_edgeR_all_seqs.csv", sep=" ")
write.table(significant.et$table, "02-learning_edgeR_sig_seqs.csv", sep=" ")
