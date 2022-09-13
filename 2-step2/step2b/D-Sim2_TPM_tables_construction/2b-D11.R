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
#sample_learn_file_path: one of the ".isoform.result" files file path in 2a-01
#sel_sig_count_matrix_file_path: "01-complete_sig_count_matrix" file path from script 2b-D04
#sel_no_sig_count_matrix_file_path: "02-complete_no_sig_count_matrix.csv" file path from script 2b-D04
#upreg_group01_sample01_learn_file_path: upregulated ".isoform.result" file path in 2b-D10 for sample 1 in group 1
#upreg_group01_sample02_learn_file_path: upregulated ".isoform.result" file path in 2b-D10 for sample 2 in group 1
#upreg_group01_sample03_learn_file_path: upregulated ".isoform.result" file path in 2b-D10 for sample 3 in group 1
#upreg_group02_sample01_learn_file_path: upregulated ".isoform.result" file path in 2b-D10 for sample 1 in group 2
#upreg_group02_sample02_learn_file_path: upregulated ".isoform.result" file path in 2b-D10 for sample 2 in group 2
#upreg_group02_sample03_learn_file_path: upregulated ".isoform.result" file path in 2b-D10 for sample 3 in group 2
#filler_group01_sample01_learn_file_path: filler ".isoform.result" file path in 2b-D10 for sample 1 in group 1
#filler_group01_sample02_learn_file_path: filler ".isoform.result" file path in 2b-D10 for sample 2 in group 1
#filler_group01_sample03_learn_file_path: filler ".isoform.result" file path in 2b-D10 for sample 3 in group 1
#filler_group02_sample01_learn_file_path: filler ".isoform.result" file path in 2b-D10 for sample 1 in group 2
#filler_group02_sample02_learn_file_path: filler ".isoform.result" file path in 2b-D10 for sample 2 in group 2
#filler_group02_sample03_learn_file_path: filler ".isoform.result" file path in 2b-D10 for sample 3 in group 2
#surplus_group01_sample01_learn_file_path: surplus ".isoform.result" file path in 2b-D10 for sample 1 in group 1
#surplus_group01_sample02_learn_file_path: surplus ".isoform.result" file path in 2b-D10 for sample 2 in group 1
#surplus_group01_sample03_learn_file_path: surplus ".isoform.result" file path in 2b-D10 for sample 3 in group 1
#surplus_group02_sample01_learn_file_path: surplus ".isoform.result" file path in 2b-D10 for sample 1 in group 2
#surplus_group02_sample02_learn_file_path: surplus ".isoform.result" file path in 2b-D10 for sample 2 in group 2
#surplus_group02_sample03_learn_file_path: surplus ".isoform.result" file path in 2b-D10 for sample 3 in group 2
#group01_sample01_samplename: sample name for sample 1 in group 1 (should coincide with the names of the input reads in the workflow)
#group01_sample02_samplename: sample name for sample 2 in group 1 (should coincide with the names of the input reads in the workflow)
#group01_sample03_samplename: sample name for sample 3 in group 1 (should coincide with the names of the input reads in the workflow)
#group02_sample01_samplename: sample name for sample 1 in group 1 (should coincide with the names of the input reads in the workflow)
#group02_sample02_samplename: sample name for sample 2 in group 2 (should coincide with the names of the input reads in the workflow)
#group02_sample03_samplename: sample name for sample 3 in group 3 (should coincide with the names of the input reads in the workflow)

#VARIABLES DEFINITION
wd <- ""

sample_learn_file_path <- ""
sel_sig_count_matrix_file_path <- ""
sel_no_sig_count_matrix_file_path <- ""
upreg_group01_sample01_learn_file_path <- ""
upreg_group01_sample02_learn_file_path <- ""
upreg_group01_sample03_learn_file_path <- ""
upreg_group02_sample01_learn_file_path <- ""
upreg_group02_sample02_learn_file_path <- ""
upreg_group02_sample03_learn_file_path <- ""
filler_group01_sample01_learn_file_path <- ""
filler_group01_sample02_learn_file_path <- ""
filler_group01_sample03_learn_file_path <- ""
filler_group02_sample01_learn_file_path <- ""
filler_group02_sample02_learn_file_path <- ""
filler_group02_sample03_learn_file_path <- ""
surplus_group01_sample01_learn_file_path <- ""
surplus_group01_sample02_learn_file_path <- ""
surplus_group01_sample03_learn_file_path <- ""
surplus_group02_sample01_learn_file_path <- ""
surplus_group02_sample02_learn_file_path <- ""
surplus_group02_sample03_learn_file_path <- ""
group01_sample01_samplename <- ""
group01_sample02_samplename <- ""
group01_sample03_samplename <- ""
group02_sample01_samplename <- ""
group02_sample02_samplename <- ""
group02_sample03_samplename <- ""

#TABLE IMPORT
setwd(wd)
ch <- c("character", "character", "character", "character", "character", "numeric", "character", "character")

sample_learn_table <- read.table(sample_learn_file_path, header=TRUE, colClasses = ch )
rownames(sample_learn_table) <- sample_learn_table$transcript_id

sel_sig_matrix_table <- read.table(sel_sig_count_matrix_file_path, header=TRUE, sep="\t")
random_sel_sig_matrix_table <- sel_sig_matrix_table[sample(nrow(sel_sig_matrix_table)),]

sel_no_sig_matrix_table <- read.table(sel_no_sig_count_matrix_file_path, header=TRUE, sep="\t" )
random_sel_no_sig_matrix_table <- sel_no_sig_matrix_table[sample(nrow(sel_no_sig_matrix_table)),]

upreg_group01_sample01_before <- read.table(upreg_group01_sample01_learn_file_path, colClasses = ch )
upreg_group01_sample01_after <- upreg_group01_sample01_before
rownames(upreg_group01_sample01_after) <- upreg_group01_sample01_after$transcript_id
upreg_group01_sample01_count <- upreg_group01_sample01_before
rownames(upreg_group01_sample01_count) <- upreg_group01_sample01_count$transcript_id

upreg_group01_sample02_before <- read.table(upreg_group01_sample02_learn_file_path, colClasses = ch )
upreg_group01_sample02_after <- upreg_group01_sample02_before
rownames(upreg_group01_sample02_after) <- upreg_group01_sample02_after$transcript_id
upreg_group01_sample02_count <- upreg_group01_sample02_before
rownames(upreg_group01_sample02_count) <- upreg_group01_sample02_count$transcript_id

upreg_group01_sample03_before <- read.table(upreg_group01_sample03_learn_file_path, colClasses = ch )
upreg_group01_sample03_after <- upreg_group01_sample03_before
rownames(upreg_group01_sample03_after) <- upreg_group01_sample03_after$transcript_id
upreg_group01_sample03_count <- upreg_group01_sample03_before
rownames(upreg_group01_sample03_count) <- upreg_group01_sample03_count$transcript_id

upreg_group02_sample01_before <- read.table(upreg_group02_sample01_learn_file_path, colClasses = ch )
upreg_group02_sample01_after <- upreg_group02_sample01_before
rownames(upreg_group02_sample01_after) <- upreg_group02_sample01_after$transcript_id
upreg_group02_sample01_count <- upreg_group02_sample01_before
rownames(upreg_group02_sample01_count) <- upreg_group02_sample01_count$transcript_id

upreg_group02_sample02_before <- read.table(upreg_group02_sample02_learn_file_path, colClasses = ch )
upreg_group02_sample02_after <- upreg_group02_sample02_before
rownames(upreg_group02_sample02_after) <- upreg_group02_sample02_after$transcript_id
upreg_group02_sample02_count <- upreg_group02_sample02_before
rownames(upreg_group02_sample02_count) <- upreg_group02_sample02_count$transcript_id

upreg_group02_sample03_before <- read.table(upreg_group02_sample03_learn_file_path, colClasses = ch )
upreg_group02_sample03_after <- upreg_group02_sample03_before
rownames(upreg_group02_sample03_after) <- upreg_group02_sample03_after$transcript_id
upreg_group02_sample03_count <- upreg_group02_sample03_before
rownames(upreg_group02_sample03_count) <- upreg_group02_sample03_count$transcript_id

filler_group01_sample01_before <- read.table(filler_group01_sample01_learn_file_path, colClasses = ch )
filler_group01_sample01_after <- filler_group01_sample01_before
rownames(filler_group01_sample01_after) <- filler_group01_sample01_after$transcript_id
filler_group01_sample01_count <- filler_group01_sample01_before
rownames(filler_group01_sample01_count) <- filler_group01_sample01_count$transcript_id

filler_group01_sample02_before <- read.table(filler_group01_sample02_learn_file_path, colClasses = ch )
filler_group01_sample02_after <- filler_group01_sample02_before
rownames(filler_group01_sample02_after) <- filler_group01_sample02_after$transcript_id
filler_group01_sample02_count <- filler_group01_sample02_before
rownames(filler_group01_sample02_count) <- filler_group01_sample02_count$transcript_id

filler_group01_sample03_before <- read.table(filler_group01_sample03_learn_file_path, colClasses = ch )
filler_group01_sample03_after <- filler_group01_sample03_before
rownames(filler_group01_sample03_after) <- filler_group01_sample03_after$transcript_id
filler_group01_sample03_count <- filler_group01_sample03_before
rownames(filler_group01_sample03_count) <- filler_group01_sample03_count$transcript_id

filler_group02_sample01_before <- read.table(filler_group02_sample01_learn_file_path, colClasses = ch )
filler_group02_sample01_after <- filler_group02_sample01_before
rownames(filler_group02_sample01_after) <- filler_group02_sample01_after$transcript_id
filler_group02_sample01_count <- filler_group02_sample01_before
rownames(filler_group02_sample01_count) <- filler_group02_sample01_count$transcript_id

filler_group02_sample02_before <- read.table(filler_group02_sample02_learn_file_path, colClasses = ch )
filler_group02_sample02_after <- filler_group02_sample02_before
rownames(filler_group02_sample02_after) <- filler_group02_sample02_after$transcript_id
filler_group02_sample02_count <- filler_group02_sample02_before
rownames(filler_group02_sample02_count) <- filler_group02_sample02_count$transcript_id

filler_group02_sample03_before <- read.table(filler_group02_sample03_learn_file_path, colClasses = ch )
filler_group02_sample03_after <- filler_group02_sample03_before
rownames(filler_group02_sample03_after) <- filler_group02_sample03_after$transcript_id
filler_group02_sample03_count <- filler_group02_sample03_before
rownames(filler_group02_sample03_count) <- filler_group02_sample03_count$transcript_id

surplus_group01_sample01_before <- read.table(surplus_group01_sample01_learn_file_path, colClasses = ch )
surplus_group01_sample01_after <- surplus_group01_sample01_before
rownames(surplus_group01_sample01_after) <- surplus_group01_sample01_after$transcript_id
surplus_group01_sample01_count <- surplus_group01_sample01_before
rownames(surplus_group01_sample01_count) <- surplus_group01_sample01_count$transcript_id

surplus_group01_sample02_before <- read.table(surplus_group01_sample02_learn_file_path, colClasses = ch )
surplus_group01_sample02_after <- surplus_group01_sample02_before
rownames(surplus_group01_sample02_after) <- surplus_group01_sample02_after$transcript_id
surplus_group01_sample02_count <- surplus_group01_sample02_before
rownames(surplus_group01_sample02_count) <- surplus_group01_sample02_count$transcript_id

surplus_group01_sample03_before <- read.table(surplus_group01_sample03_learn_file_path, colClasses = ch )
surplus_group01_sample03_after <- surplus_group01_sample03_before
rownames(surplus_group01_sample03_after) <- surplus_group01_sample03_after$transcript_id
surplus_group01_sample03_count <- surplus_group01_sample03_before
rownames(surplus_group01_sample03_count) <- surplus_group01_sample03_count$transcript_id

surplus_group02_sample01_before <- read.table(surplus_group02_sample01_learn_file_path, colClasses = ch )
surplus_group02_sample01_after <- surplus_group02_sample01_before
rownames(surplus_group02_sample01_after) <- surplus_group02_sample01_after$transcript_id
surplus_group02_sample01_count <- surplus_group02_sample01_before
rownames(surplus_group02_sample01_count) <- surplus_group02_sample01_count$transcript_id

surplus_group02_sample02_before <- read.table(surplus_group02_sample02_learn_file_path, colClasses = ch )
surplus_group02_sample02_after <- surplus_group02_sample02_before
rownames(surplus_group02_sample02_after) <- surplus_group02_sample02_after$transcript_id
surplus_group02_sample02_count <- surplus_group02_sample02_before
rownames(surplus_group02_sample02_count) <- surplus_group02_sample02_count$transcript_id

surplus_group02_sample03_before <- read.table(surplus_group02_sample03_learn_file_path, colClasses = ch )
surplus_group02_sample03_after <- surplus_group02_sample03_before
rownames(surplus_group02_sample03_after) <- surplus_group02_sample03_after$transcript_id
surplus_group02_sample03_count <- surplus_group02_sample03_before
rownames(surplus_group02_sample03_count) <- surplus_group02_sample03_count$transcript_id

#TABLES EDITION
upreg_group01_sample01_count$V5 <- random_sel_sig_matrix_table$group01_sample01
upreg_group01_sample02_count$V5 <- random_sel_sig_matrix_table$group01_sample02
upreg_group01_sample03_count$V5 <- random_sel_sig_matrix_table$group01_sample03
upreg_group02_sample01_count$V5 <- random_sel_sig_matrix_table$group02_sample01
upreg_group02_sample02_count$V5 <- random_sel_sig_matrix_table$group02_sample02
upreg_group02_sample03_count$V5 <- random_sel_sig_matrix_table$group02_sample03

filler_group01_sample01_count$V5 <- random_sel_no_sig_matrix_table$group01_sample01
filler_group01_sample02_count$V5 <- random_sel_no_sig_matrix_table$group01_sample02
filler_group01_sample03_count$V5 <- random_sel_no_sig_matrix_table$group01_sample03
filler_group02_sample01_count$V5 <- random_sel_no_sig_matrix_table$group02_sample01
filler_group02_sample02_count$V5 <- random_sel_no_sig_matrix_table$group02_sample02
filler_group02_sample03_count$V5 <- random_sel_no_sig_matrix_table$group02_sample03

surplus_group01_sample01_count$V5 <- "0.00"
surplus_group01_sample02_count$V5 <- "0.00"
surplus_group01_sample03_count$V5 <- "0.00"
surplus_group02_sample01_count$V5 <- "0.00"
surplus_group02_sample02_count$V5 <- "0.00"
surplus_group02_sample03_count$V5 <- "0.00"

#Count tables union and edition
group01_sample01_count <- rbind(upreg_group01_sample01_count,filler_group01_sample01_count,surplus_group01_sample01_count)
colnames(group01_sample01_count) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group01_sample01_count$expected_count <- as.numeric(group01_sample01_count$expected_count)
group01_sample01_count$effective_length <- as.numeric(group01_sample01_count$effective_length)
group01_sample01_count$TPM <- (((group01_sample01_count$expected_count)/(group01_sample01_count$effective_length))*1000000)/(sum((group01_sample01_count$expected_count)/(group01_sample01_count$effective_length)))
sum(group01_sample01_count$TPM)

group01_sample02_count <- rbind(upreg_group01_sample02_count,filler_group01_sample02_count,surplus_group01_sample02_count)
colnames(group01_sample02_count) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group01_sample02_count$expected_count <- as.numeric(group01_sample02_count$expected_count)
group01_sample02_count$effective_length <- as.numeric(group01_sample02_count$effective_length)
group01_sample02_count$TPM <- (((group01_sample02_count$expected_count)/(group01_sample02_count$effective_length))*1000000)/(sum((group01_sample02_count$expected_count)/(group01_sample02_count$effective_length)))
sum(group01_sample02_count$TPM)

group01_sample03_count <- rbind(upreg_group01_sample03_count,filler_group01_sample03_count,surplus_group01_sample03_count)
colnames(group01_sample03_count) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group01_sample03_count$expected_count <- as.numeric(group01_sample03_count$expected_count)
group01_sample03_count$effective_length <- as.numeric(group01_sample03_count$effective_length)
group01_sample03_count$TPM <- (((group01_sample03_count$expected_count)/(group01_sample03_count$effective_length))*1000000)/(sum((group01_sample03_count$expected_count)/(group01_sample03_count$effective_length)))
sum(group01_sample03_count$TPM)

group02_sample01_count <- rbind(upreg_group02_sample01_count,filler_group02_sample01_count,surplus_group02_sample01_count)
colnames(group02_sample01_count) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group02_sample01_count$expected_count <- as.numeric(group02_sample01_count$expected_count)
group02_sample01_count$effective_length <- as.numeric(group02_sample01_count$effective_length)
group02_sample01_count$TPM <- (((group02_sample01_count$expected_count)/(group02_sample01_count$effective_length))*1000000)/(sum((group02_sample01_count$expected_count)/(group02_sample01_count$effective_length)))
sum(group02_sample01_count$TPM)

group02_sample02_count <- rbind(upreg_group02_sample02_count,filler_group02_sample02_count,surplus_group02_sample02_count)
colnames(group02_sample02_count) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group02_sample02_count$expected_count <- as.numeric(group02_sample02_count$expected_count)
group02_sample02_count$effective_length <- as.numeric(group02_sample02_count$effective_length)
group02_sample02_count$TPM <- (((group02_sample02_count$expected_count)/(group02_sample02_count$effective_length))*1000000)/(sum((group02_sample02_count$expected_count)/(group02_sample02_count$effective_length)))
sum(group02_sample02_count$TPM)

group02_sample03_count <- rbind(upreg_group02_sample03_count,filler_group02_sample03_count,surplus_group02_sample03_count)
colnames(group02_sample03_count) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group02_sample03_count$expected_count <- as.numeric(group02_sample03_count$expected_count)
group02_sample03_count$effective_length <- as.numeric(group02_sample03_count$effective_length)
group02_sample03_count$TPM <- (((group02_sample03_count$expected_count)/(group02_sample03_count$effective_length))*1000000)/(sum((group02_sample03_count$expected_count)/(group02_sample03_count$effective_length)))
sum(group02_sample03_count$TPM)


#TPM tables union and edition
group01_sample01 <- rbind(upreg_group01_sample01_after,filler_group01_sample01_after,surplus_group01_sample01_after)
colnames(group01_sample01) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group01_sample01$TPM <- as.numeric(group01_sample01_count$TPM)
group01_sample01divfactor <- (sum(group01_sample01$TPM)/1000000)
group01_sample01$TPM <- (group01_sample01$TPM)/(group01_sample01divfactor)
group01_sample01$TPM <- round(group01_sample01$TPM, 2)
sum(group01_sample01$TPM)
group01_sample01$TPM <- format(group01_sample01$TPM, nsmall=2, trim=TRUE)
rownames(group01_sample01) <- group01_sample01$transcript_id
all(rownames(group01_sample01) %in% rownames(sample_learn_table))
all(rownames(group01_sample01) == rownames(sample_learn_table))
sorted_group01_sample01 <- group01_sample01[rownames(sample_learn_table), ]
all(rownames(sorted_group01_sample01) == rownames(sample_learn_table))

group01_sample02 <- rbind(upreg_group01_sample02_after,filler_group01_sample02_after,surplus_group01_sample02_after)
colnames(group01_sample02) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group01_sample02$TPM <- as.numeric(group01_sample02_count$TPM)
group01_sample02divfactor <- (sum(group01_sample02$TPM)/1000000)
group01_sample02$TPM <- (group01_sample02$TPM)/(group01_sample02divfactor)
group01_sample02$TPM <- round(group01_sample02$TPM, 2)
sum(group01_sample02$TPM)
group01_sample02$TPM <- format(group01_sample02$TPM, nsmall=2, trim=TRUE)
rownames(group01_sample02) <- group01_sample02$transcript_id
all(rownames(group01_sample02) %in% rownames(sample_learn_table))
all(rownames(group01_sample02) == rownames(sample_learn_table))
sorted_group01_sample02 <- group01_sample02[rownames(sample_learn_table), ]
all(rownames(sorted_group01_sample02) == rownames(sample_learn_table))

group01_sample03 <- rbind(upreg_group01_sample03_after,filler_group01_sample03_after,surplus_group01_sample03_after)
colnames(group01_sample03) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group01_sample03$TPM <- as.numeric(group01_sample03_count$TPM)
group01_sample03divfactor <- (sum(group01_sample03$TPM)/1000000)
group01_sample03$TPM <- (group01_sample03$TPM)/(group01_sample03divfactor)
group01_sample03$TPM <- round(group01_sample03$TPM, 2)
sum(group01_sample03$TPM)
group01_sample03$TPM <- format(group01_sample03$TPM, nsmall=2, trim=TRUE)
rownames(group01_sample03) <- group01_sample03$transcript_id
all(rownames(group01_sample03) %in% rownames(sample_learn_table))
all(rownames(group01_sample03) == rownames(sample_learn_table))
sorted_group01_sample03 <- group01_sample03[rownames(sample_learn_table), ]
all(rownames(sorted_group01_sample03) == rownames(sample_learn_table))

group02_sample01 <- rbind(upreg_group02_sample01_after,filler_group02_sample01_after,surplus_group02_sample01_after)
colnames(group02_sample01) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group02_sample01$TPM <- as.numeric(group02_sample01_count$TPM)
group02_sample01divfactor <- (sum(group02_sample01$TPM)/1000000)
group02_sample01$TPM <- (group02_sample01$TPM)/(group02_sample01divfactor)
group02_sample01$TPM <- round(group02_sample01$TPM, 2)
sum(group02_sample01$TPM)
group02_sample01$TPM <- format(group02_sample01$TPM, nsmall=2, trim=TRUE)
rownames(group02_sample01) <- group02_sample01$transcript_id
all(rownames(group02_sample01) %in% rownames(sample_learn_table))
all(rownames(group02_sample01) == rownames(sample_learn_table))
sorted_group02_sample01 <- group02_sample01[rownames(sample_learn_table), ]
all(rownames(sorted_group02_sample01) == rownames(sample_learn_table))

group02_sample02 <- rbind(upreg_group02_sample02_after,filler_group02_sample02_after,surplus_group02_sample02_after)
colnames(group02_sample02) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group02_sample02$TPM <- as.numeric(group02_sample02_count$TPM)
group02_sample02divfactor <- (sum(group02_sample02$TPM)/1000000)
group02_sample02$TPM <- (group02_sample02$TPM)/(group02_sample02divfactor)
group02_sample02$TPM <- round(group02_sample02$TPM, 2)
sum(group02_sample02$TPM)
group02_sample02$TPM <- format(group02_sample02$TPM, nsmall=2, trim=TRUE)
rownames(group02_sample02) <- group02_sample02$transcript_id
all(rownames(group02_sample02) %in% rownames(sample_learn_table))
all(rownames(group02_sample02) == rownames(sample_learn_table))
sorted_group02_sample02 <- group02_sample02[rownames(sample_learn_table), ]
all(rownames(sorted_group02_sample02) == rownames(sample_learn_table))

group02_sample03 <- rbind(upreg_group02_sample03_after,filler_group02_sample03_after,surplus_group02_sample03_after)
colnames(group02_sample03) <- c("transcript_id", "gene_id",	"length",	"effective_length",	"expected_count",	"TPM",	"FPKM",	"IsoPct")
group02_sample03$TPM <- as.numeric(group02_sample03_count$TPM)
group02_sample03divfactor <- (sum(group02_sample03$TPM)/1000000)
group02_sample03$TPM <- (group02_sample03$TPM)/(group02_sample03divfactor)
group02_sample03$TPM <- round(group02_sample03$TPM, 2)
sum(group02_sample03$TPM)
group02_sample03$TPM <- format(group02_sample03$TPM, nsmall=2, trim=TRUE)
rownames(group02_sample03) <- group02_sample03$transcript_id
all(rownames(group02_sample03) %in% rownames(sample_learn_table))
all(rownames(group02_sample03) == rownames(sample_learn_table))
sorted_group02_sample03 <- group02_sample03[rownames(sample_learn_table), ]
all(rownames(sorted_group02_sample03) == rownames(sample_learn_table))

#TABLES EXPORT
write.table(sorted_group01_sample01, file = paste("edited", group01_sample01_samplename, "isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(sorted_group01_sample02, file = paste("edited", group01_sample02_samplename, "isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(sorted_group01_sample03, file = paste("edited", group01_sample03_samplename, "isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(sorted_group02_sample01, file = paste("edited", group02_sample01_samplename, "isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(sorted_group02_sample02, file = paste("edited", group02_sample02_samplename, "isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(sorted_group02_sample03, file = paste("edited", group02_sample03_samplename, "isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
