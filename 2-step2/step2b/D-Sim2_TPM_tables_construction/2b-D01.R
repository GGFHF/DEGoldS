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
#group01_sample01_learn_file_path: ".isoform.result" file in 2a-01 for sample 1 in group 1
#group01_sample02_learn_file_path: ".isoform.result" file in 2a-01 for sample 2 in group 1
#group01_sample03_learn_file_path: ".isoform.result" file in 2a-01 for sample 3 in group 1
#group02_sample01_learn_file_path: ".isoform.result" file in 2a-01 for sample 1 in group 2
#group02_sample02_learn_file_path: ".isoform.result" file in 2a-01 for sample 2 in group 2
#group02_sample03_learn_file_path: ".isoform.result" file in 2a-01 for sample 3 in group 2

#VARIABLES DEFINITION
wd <- ""

group01_sample01_learn_file_path <- ""
group01_sample02_learn_file_path <- ""
group01_sample03_learn_file_path <- ""
group02_sample01_learn_file_path <- ""
group02_sample02_learn_file_path <- ""
group02_sample03_learn_file_path <- ""

#TABLE IMPORT
setwd(wd)
ch <- c("character", "character", "character", "character", "character", "character", "character")

group01_sample01_learn_table <- read.table(group01_sample01_learn_file_path, header=TRUE, sep="\t", colClasses = ch)
rownames(group01_sample01_learn_table) <- group01_sample01_learn_table$transcript_id

group01_sample02_learn_table <- read.table(group01_sample02_learn_file_path, header=TRUE, sep="\t", colClasses = ch)
rownames(group01_sample02_learn_table) <- group01_sample02_learn_table$transcript_id

group01_sample03_learn_table <- read.table(group01_sample03_learn_file_path, header=TRUE, sep="\t", colClasses = ch)
rownames(group01_sample03_learn_table) <- group01_sample03_learn_table$transcript_id

group02_sample01_learn_table <- read.table(group02_sample01_learn_file_path, header=TRUE, sep="\t", colClasses = ch)
rownames(group02_sample01_learn_table) <- group02_sample01_learn_table$transcript_id

group02_sample02_learn_table <- read.table(group02_sample02_learn_file_path, header=TRUE, sep="\t", colClasses = ch)
rownames(group02_sample02_learn_table) <- group02_sample02_learn_table$transcript_id

group02_sample03_learn_table <- read.table(group02_sample03_learn_file_path, header=TRUE, sep="\t", colClasses = ch)
rownames(group02_sample03_learn_table) <- group02_sample03_learn_table$transcript_id

#TABLE SORTING
sorted_group01_sample01_learn_table <- group01_sample01_learn_table[order(rownames(group01_sample01_learn_table)), ]
sorted_group01_sample02_learn_table <- group01_sample02_learn_table[order(rownames(group01_sample02_learn_table)), ]
sorted_group01_sample03_learn_table <- group01_sample03_learn_table[order(rownames(group01_sample03_learn_table)), ]
sorted_group02_sample01_learn_table <- group02_sample01_learn_table[order(rownames(group02_sample01_learn_table)), ]
sorted_group02_sample02_learn_table <- group02_sample02_learn_table[order(rownames(group02_sample02_learn_table)), ]
sorted_group02_sample03_learn_table <- group02_sample03_learn_table[order(rownames(group02_sample03_learn_table)), ]


#TRANSCRIPTS COUNT MATRIX BUILDING
learn_count_matrix <- cbind(sorted_group01_sample01_learn_table$transcript_id,sorted_group01_sample01_learn_table$expected_count,sorted_group01_sample02_learn_table$expected_count,sorted_group01_sample03_learn_table$expected_count,sorted_group02_sample01_learn_table$expected_count,sorted_group02_sample02_learn_table$expected_count,sorted_group02_sample03_learn_table$expected_count)
rownames(learn_count_matrix) <- sorted_group01_sample01_learn_table$transcript_id
colnames(learn_count_matrix) <- c("transcript_id","group01_sample01", "group01_sample02", "group01_sample03", "group02_sample01", "group02_sample02", "group02_sample03")
learn_count_matrix_totals <- as.data.frame(learn_count_matrix)
learn_count_matrix_totals$group01_sample01 <- as.numeric(learn_count_matrix_totals$group01_sample01)
learn_count_matrix_totals$group01_sample02 <- as.numeric(learn_count_matrix_totals$group01_sample02)
learn_count_matrix_totals$group01_sample03 <- as.numeric(learn_count_matrix_totals$group01_sample03)
learn_count_matrix_totals$group02_sample01 <- as.numeric(learn_count_matrix_totals$group02_sample01)
learn_count_matrix_totals$group02_sample02 <- as.numeric(learn_count_matrix_totals$group02_sample02)
learn_count_matrix_totals$group02_sample03 <- as.numeric(learn_count_matrix_totals$group02_sample03)
learn_count_matrix_totals$total <- (learn_count_matrix_totals$group01_sample01)+(learn_count_matrix_totals$group01_sample02)+(learn_count_matrix_totals$group01_sample03)+(learn_count_matrix_totals$group02_sample01)+(learn_count_matrix_totals$group02_sample02)+(learn_count_matrix_totals$group02_sample03)

empty_total <- sum(learn_count_matrix_totals$total == 0)
empty_total
matrix_length <- length(learn_count_matrix_totals$transcript_id)
matrix_length
per_empty_total <- (empty_total)*100/(matrix_length)
per_empty_total

learn_count_matrix_totals_emptys_removed <- learn_count_matrix_totals
learn_count_matrix_totals_emptys_removed <- learn_count_matrix_totals_emptys_removed[learn_count_matrix_totals_emptys_removed$total > 0, ]

empty_total_emptys_removed <- sum(learn_count_matrix_totals_emptys_removed$total == 0)
empty_total_emptys_removed
matrix_length_emptys_removed <- length(learn_count_matrix_totals_emptys_removed$transcript_id)
matrix_length_emptys_removed
per_empty_total_emptys_removed <- (empty_total_emptys_removed)*100/(matrix_length_emptys_removed)
per_empty_total_emptys_removed

final_learn_count_matrix <- cbind(learn_count_matrix_totals_emptys_removed$transcript_id, learn_count_matrix_totals_emptys_removed$group01_sample01, learn_count_matrix_totals_emptys_removed$group01_sample02, learn_count_matrix_totals_emptys_removed$group01_sample03, learn_count_matrix_totals_emptys_removed$group02_sample01, learn_count_matrix_totals_emptys_removed$group02_sample02, learn_count_matrix_totals_emptys_removed$group02_sample03)
rownames(final_learn_count_matrix) <- learn_count_matrix_totals_emptys_removed$transcript_id
colnames(final_learn_count_matrix) <- c("transcript_id","group01_sample01", "group01_sample02", "group01_sample03", "group02_sample01", "group02_sample02", "group02_sample03")

#TRANSCRIPTS EFFECTIVE LENGTH MATRIX BUILDING
efflength_matrix<- cbind(sorted_group01_sample01_learn_table$transcript_id,sorted_group01_sample01_learn_table$effective_length,sorted_group01_sample02_learn_table$effective_length,sorted_group01_sample03_learn_table$effective_length,sorted_group02_sample01_learn_table$effective_length,sorted_group02_sample02_learn_table$effective_length,sorted_group02_sample03_learn_table$effective_length)
rownames(efflength_matrix) <- sorted_group01_sample01_learn_table$transcript_id
colnames(efflength_matrix) <- c("transcript_id","group01_sample01", "group01_sample02", "group01_sample03", "group02_sample01", "group02_sample02", "group02_sample03")
efflength_matrix_totals <- as.data.frame(efflength_matrix)
efflength_matrix_totals$count_total <- learn_count_matrix_totals$total

efflength_matrix_totals_emptys_removed <- efflength_matrix_totals
efflength_matrix_totals_emptys_removed <- efflength_matrix_totals_emptys_removed[efflength_matrix_totals_emptys_removed$count_total > 0, ]

final_efflength_matrix <- cbind(efflength_matrix_totals_emptys_removed$transcript_id, efflength_matrix_totals_emptys_removed$group01_sample01, efflength_matrix_totals_emptys_removed$group01_sample02, efflength_matrix_totals_emptys_removed$group01_sample03, efflength_matrix_totals_emptys_removed$group02_sample01, efflength_matrix_totals_emptys_removed$group02_sample02, efflength_matrix_totals_emptys_removed$group02_sample03)
rownames(final_efflength_matrix) <- efflength_matrix_totals_emptys_removed$transcript_id
colnames(final_efflength_matrix) <- c("transcript_id","group01_sample01", "group01_sample02", "group01_sample03", "group02_sample01", "group02_sample02", "group02_sample03")

#TRANSCRIPTS LENGTH MATRIX BUILDING
length_matrix<- cbind(sorted_group01_sample01_learn_table$transcript_id,sorted_group01_sample01_learn_table$length,sorted_group01_sample02_learn_table$length,sorted_group01_sample03_learn_table$length,sorted_group02_sample01_learn_table$length,sorted_group02_sample02_learn_table$length,sorted_group02_sample03_learn_table$length)
rownames(length_matrix) <- sorted_group01_sample01_learn_table$transcript_id
colnames(length_matrix) <- c("transcript_id","group01_sample01", "group01_sample02", "group01_sample03", "group02_sample01", "group02_sample02", "group02_sample03")
length_matrix_totals <- as.data.frame(length_matrix)
length_matrix_totals$count_total <- learn_count_matrix_totals$total

length_matrix_totals_emptys_removed <- length_matrix_totals
length_matrix_totals_emptys_removed <- length_matrix_totals_emptys_removed[length_matrix_totals_emptys_removed$count_total > 0, ]

final_length_matrix <- cbind(length_matrix_totals_emptys_removed$transcript_id, length_matrix_totals_emptys_removed$group01_sample01, length_matrix_totals_emptys_removed$group01_sample02, length_matrix_totals_emptys_removed$group01_sample03, length_matrix_totals_emptys_removed$group02_sample01, length_matrix_totals_emptys_removed$group02_sample02, length_matrix_totals_emptys_removed$group02_sample03)
rownames(final_length_matrix) <- length_matrix_totals_emptys_removed$transcript_id
colnames(final_length_matrix) <- c("transcript_id","group01_sample01", "group01_sample02", "group01_sample03", "group02_sample01", "group02_sample02", "group02_sample03")

#TABLE EXPORT
write.table(final_learn_count_matrix, file = "01-learn_count_matrix.csv", row.names = FALSE, sep = "\t", quote = FALSE)
write.table(efflength_matrix, file = "02-effective_length_matrix.csv", row.names = FALSE, sep = "\t", quote = FALSE)
write.table(length_matrix, file = "03-length_matrix.csv", row.names = FALSE, sep = "\t", quote = FALSE)
