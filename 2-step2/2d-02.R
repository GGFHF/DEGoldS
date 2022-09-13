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
library(edgeR)
library(tximport)

#Data import from tximport
setwd(wd)
samples <- read.table(file.path(samples_description_file_path), header = TRUE)
samples

files <- file.path(counts_dir, paste(samples$sample, ".sim.isoforms.results", sep=""))
names(files) <- samples$sample
tx2gene <- read.csv(file.path(sim_tx2gene_file_path), sep =" ")
txi.rsem <- tximport(files, type="rsem", tx2gene = tx2gene)
head(txi.rsem$counts)

txi <- txi.rsem

cts <- txi$counts
normMat <- txi$length

group <- factor(samples$group)

# Obtaining per-observation scaling factors for length, adjusted to avoid
# changing the magnitude of the counts.
normMat <- normMat/exp(rowMeans(log(normMat)))
normCts <- cts/normMat

# Computing effective library sizes from scaled counts, to account for
# composition biases between samples.
eff.lib <- calcNormFactors(normCts) * colSums(normCts)

# Combining effective library sizes with the length factors, and calculating
# offsets for a log-link GLM.
normMat <- sweep(normMat, 2, eff.lib, "*")
normMat <- log(normMat)

# Creating a DGEList object for use in edgeR.
y <- DGEList(cts, group=group)
y <- scaleOffset(y, normMat)

# filtering using the design information
design <- model.matrix(~group)
keep <- filterByExpr(y, design)
y <- y[keep, ]
# y is now ready for estimate dispersion functions see edgeR User's Guide

y <- estimateDisp(y,design,robust=TRUE)

#DE genes testing
et <- exactTest(y)
topTags(et)
summary(decideTests(et))
FDR.et <- p.adjust(et$table$PValue, method="BH")
nfdr.et <- sum(FDR.et<0.001)
significant.et <- topTags(et, n=nfdr.et)

#Exporting results to CSV files
write.table(significant.et$table, "simGS_edgeR.csv", sep=" ")
