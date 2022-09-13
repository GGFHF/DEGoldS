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
#filler_pre_candidate_seqs_file_path: a text file with a list of selectable transcript IDs in the first column with no header for filler transcripts selection (i. e. selectable transcripts pool), for example, "10-candidate_unique-plus_seqs.txt" file path in script 2b-A02
#group01_sample01_learn_file_path: ".isoform.result" file in 2a-01 for sample 1 in group 1
#group01_sample02_learn_file_path: ".isoform.result" file in 2a-01 for sample 2 in group 1
#group01_sample03_learn_file_path: ".isoform.result" file in 2a-01 for sample 3 in group 1
#group02_sample01_learn_file_path: ".isoform.result" file in 2a-01 for sample 1 in group 2
#group02_sample02_learn_file_path: ".isoform.result" file in 2a-01 for sample 2 in group 2
#group02_sample03_learn_file_path: ".isoform.result" file in 2a-01 for sample 3 in group 2
#filler_sel_seqs_number: number of filler transcripts to select
#group01_upreg_X1_sel_seqs_file_path: selected transcripts in group 1 with level 1 of expression in upregulated transcripts ("group01_upreg_seqs_x1.txt" file path from script 2b-C01)
#group01_upreg_X2_sel_seqs_file_path: selected transcripts in group 1 with level 2 of expression in upregulated transcripts ("group01_upreg_seqs_x2.txt" file path from script 2b-C01)
#group01_upreg_X3_sel_seqs_file_path: selected transcripts in group 1 with level 3 of expression in upregulated transcripts ("group01_upreg_seqs_x3.txt" file path from script 2b-C01)
#group01_upreg_X4_sel_seqs_file_path: selected transcripts in group 1 with level 4 of expression in upregulated transcripts ("group01_upreg_seqs_x4.txt" file path from script 2b-C01)
#group01_upreg_X5_sel_seqs_file_path: selected transcripts in group 1 with level 5 of expression in upregulated transcripts ("group01_upreg_seqs_x5.txt" file path from script 2b-C01)
#group02_upreg_X1_sel_seqs_file_path: selected transcripts in group 2 with level 1 of expression in upregulated transcripts ("group02_upreg_seqs_x1.txt" file path from script 2b-C01)
#group02_upreg_X2_sel_seqs_file_path: selected transcripts in group 2 with level 2 of expression in upregulated transcripts ("group02_upreg_seqs_x2.txt" file path from script 2b-C01)
#group02_upreg_X3_sel_seqs_file_path: selected transcripts in group 2 with level 3 of expression in upregulated transcripts ("group02_upreg_seqs_x3.txt" file path from script 2b-C01)
#group02_upreg_X4_sel_seqs_file_path: selected transcripts in group 2 with level 4 of expression in upregulated transcripts ("group02_upreg_seqs_x4.txt" file path from script 2b-C01)
#group02_upreg_X5_sel_seqs_file_path: selected transcripts in group 2 with level 5 of expression in upregulated transcripts ("group02_upreg_seqs_x5.txt" file path from script 2b-C01)
#base_value: base expression level value
#upreg_value_X1: upregulated expression value for level 1
#upreg_value_X2: upregulated expression value for level 2
#upreg_value_X3: upregulated expression value for level 3
#upreg_value_X4: upregulated expression value for level 4
#upreg_value_X5: upregulated expression value for level 5
#group01_sample01_samplename: sample name for sample 1 in group 1 (should coincide with the names of the input reads in the workflow)
#group01_sample02_samplename: sample name for sample 2 in group 1 (should coincide with the names of the input reads in the workflow)
#group01_sample03_samplename: sample name for sample 3 in group 1 (should coincide with the names of the input reads in the workflow)
#group02_sample01_samplename: sample name for sample 1 in group 1 (should coincide with the names of the input reads in the workflow)
#group02_sample02_samplename: sample name for sample 2 in group 2 (should coincide with the names of the input reads in the workflow)
#group02_sample03_samplename: sample name for sample 3 in group 3 (should coincide with the names of the input reads in the workflow)

#VARIABLES DEFINITION
wd <- ""

filler_pre_candidate_seqs_file_path <- ""
group01_sample01_learn_file_path <- ""
group01_sample02_learn_file_path <- ""
group01_sample03_learn_file_path <- ""
group02_sample01_learn_file_path <- ""
group02_sample02_learn_file_path <- ""
group02_sample03_learn_file_path <- ""
filler_sel_seqs_number <-
group01_upreg_X1_sel_seqs_file_path <- ""
group01_upreg_X2_sel_seqs_file_path <- ""
group01_upreg_X3_sel_seqs_file_path <- ""
group01_upreg_X4_sel_seqs_file_path <- ""
group01_upreg_X5_sel_seqs_file_path <- ""
group02_upreg_X1_sel_seqs_file_path <- ""
group02_upreg_X2_sel_seqs_file_path <- ""
group02_upreg_X3_sel_seqs_file_path <- ""
group02_upreg_X4_sel_seqs_file_path <- ""
group02_upreg_X5_sel_seqs_file_path <- ""
base_value <- ""
upreg_value_X1 <- ""
upreg_value_X2 <- ""
upreg_value_X3 <- ""
upreg_value_X4 <- ""
upreg_value_X5 <- ""
group01_sample01_samplename <- ""
group01_sample02_samplename <- ""
group01_sample03_samplename <- ""
group02_sample01_samplename <- ""
group02_sample02_samplename <- ""
group02_sample03_samplename <- ""

#TABLE IMPORT
setwd(wd)
ch <- c("character", "character", "character", "character", "character", "character", "character", "character")

filler_pre_candidate_seqs_table <- read.table(filler_pre_candidate_seqs_file_path, header=FALSE)
rownames(filler_pre_candidate_seqs_table) <- filler_pre_candidate_seqs_table$V1

group01_sample01_before <- read.table(group01_sample01_learn_file_path, header=TRUE, colClasses = ch )
group01_sample01_after <- group01_sample01_before
rownames(group01_sample01_after) <- group01_sample01_after$transcript_id

group01_sample02_before <- read.table(group01_sample02_learn_file_path, header=TRUE, colClasses = ch )
group01_sample02_after <- group01_sample02_before
rownames(group01_sample02_after) <- group01_sample02_after$transcript_id

group01_sample03_before <- read.table(group01_sample03_learn_file_path, header=TRUE, colClasses = ch )
group01_sample03_after <- group01_sample03_before
rownames(group01_sample01_after) <- group01_sample03_after$transcript_id

group02_sample01_before <- read.table(group02_sample01_learn_file_path, header=TRUE, colClasses = ch)
group02_sample01_after <- group02_sample01_before
rownames(group02_sample01_after) <- group02_sample01_after$transcript_id

group02_sample02_before <- read.table(group01_sample02_learn_file_path, header=TRUE, colClasses = ch)
group02_sample02_after <- group02_sample02_before
rownames(group02_sample02_after) <- group02_sample02_after$transcript_id

group02_sample03_before <- read.table(group01_sample03_learn_file_path, header=TRUE, colClasses = ch)
group02_sample03_after <- group02_sample03_before
rownames(group02_sample03_after) <- group02_sample03_after$transcript_id

#FILLER SEQUENCES SELECTION
#filler_candidate_seqs_list <- group01_sample01_after$transcript_id
#filler_sel_seqs_list <- sample(filler_candidate_seqs_list, filler_sel_seqs_number)

group01_upreg_X1_seqs_table <- read.table(group01_upreg_X1_sel_seqs_file_path)
group01_upreg_X1_sel_seqs_list <- group01_upreg_X1_seqs_table$V1
group01_upreg_X2_sel_seqs_table <- read.table(group01_upreg_X2_sel_seqs_file_path)
group01_upreg_X2_sel_seqs_list <- group01_upreg_X2_sel_seqs_table$V1
group01_upreg_X3_sel_seqs_table <- read.table(group01_upreg_X3_sel_seqs_file_path)
group01_upreg_X3_sel_seqs_list <- group01_upreg_X3_sel_seqs_table$V1
group01_upreg_X4_sel_seqs_table <- read.table(group01_upreg_X4_sel_seqs_file_path)
group01_upreg_X4_sel_seqs_list <- group01_upreg_X4_sel_seqs_table$V1
group01_upreg_X5_sel_seqs_table <- read.table(group01_upreg_X5_sel_seqs_file_path)
group01_upreg_X5_sel_seqs_list <- group01_upreg_X5_sel_seqs_table$V1
group02_upreg_X1_sel_seqs_table <- read.table(group02_upreg_X1_sel_seqs_file_path)
group02_upreg_X1_sel_seqs_list <- group02_upreg_X1_sel_seqs_table$V1
group02_upreg_X2_sel_seqs_table <- read.table(group02_upreg_X2_sel_seqs_file_path)
group02_upreg_X2_sel_seqs_list <- group02_upreg_X2_sel_seqs_table$V1
group02_upreg_X3_sel_seqs_table <- read.table(group02_upreg_X3_sel_seqs_file_path)
group02_upreg_X3_sel_seqs_list <- group02_upreg_X3_sel_seqs_table$V1
group02_upreg_X4_sel_seqs_table <- read.table(group02_upreg_X4_sel_seqs_file_path)
group02_upreg_X4_sel_seqs_list <- group02_upreg_X4_sel_seqs_table$V1
group02_upreg_X5_sel_seqs_table <- read.table(group02_upreg_X5_sel_seqs_file_path)
group02_upreg_X5_sel_seqs_list <- group02_upreg_X5_sel_seqs_table$V1

upreg_sel_seqs_list <- c(group01_upreg_X1_sel_seqs_list,group01_upreg_X2_sel_seqs_list,group01_upreg_X3_sel_seqs_list,group01_upreg_X4_sel_seqs_list,group01_upreg_X5_sel_seqs_list,group02_upreg_X1_sel_seqs_list,group02_upreg_X2_sel_seqs_list,group02_upreg_X3_sel_seqs_list,group02_upreg_X4_sel_seqs_list,group02_upreg_X5_sel_seqs_list)
group01_upreg_sel_seqs_list <- c(group01_upreg_X1_sel_seqs_list,group01_upreg_X2_sel_seqs_list,group01_upreg_X3_sel_seqs_list,group01_upreg_X4_sel_seqs_list,group01_upreg_X5_sel_seqs_list)
group02_upreg_sel_seqs_list <- c(group02_upreg_X1_sel_seqs_list,group02_upreg_X2_sel_seqs_list,group02_upreg_X3_sel_seqs_list,group02_upreg_X4_sel_seqs_list,group02_upreg_X5_sel_seqs_list)

filler_pre_candidate_seqs_list <- filler_pre_candidate_seqs_table$V1
filler_candidate_seqs_list <- setdiff(filler_pre_candidate_seqs_list,upreg_sel_seqs_list)
filler_sel_seqs_list <- sample(filler_candidate_seqs_list, filler_sel_seqs_number)

total_sel_seqs_list <- union(upreg_sel_seqs_list, filler_sel_seqs_list)
total_sel_seqs_list
total_sel_seqs_list_number <- length(total_sel_seqs_list)
total_sel_seqs_list_number
common_seqs <- intersect(upreg_sel_seqs_list,filler_sel_seqs_list)
common_seqs
target_total_sel_seqs_number = (as.numeric(filler_sel_seqs_number))+(length(upreg_sel_seqs_list))
target_total_sel_seqs_number

while (total_sel_seqs_list_number != target_total_sel_seqs_number) {
  filler_sel_seqs_list <- sample(filler_candidate_seqs_list, filler_sel_seqs_number)
  total_sel_seqs_list <- union(upreg_sel_seqs_list, filler_sel_seqs_list)
  total_sel_seqs_list_number <- length(total_sel_seqs_list)
  if (total_sel_seqs_list_number == target_total_sel_seqs_number)
    break
}

length(total_sel_seqs_list)
intersect(upreg_sel_seqs_list,filler_sel_seqs_list)

write.table(filler_sel_seqs_list, file = "filler_seqs.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)

#TABLE EDITION
group01_sample01_after$TPM <- "0.00"

for (transcript_id in c(filler_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X1_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- upreg_value_X1
}

for (transcript_id in c(group01_upreg_X2_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- upreg_value_X2
}

for (transcript_id in c(group01_upreg_X3_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- upreg_value_X3
}

for (transcript_id in c(group01_upreg_X4_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- upreg_value_X4
}

for (transcript_id in c(group01_upreg_X5_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- upreg_value_X5
}

for (transcript_id in c(group02_upreg_X1_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X2_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X3_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X4_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X5_sel_seqs_list)){
  group01_sample01_after$TPM[group01_sample01_after$transcript_id == transcript_id] <- base_value
}

(as.numeric(base_value)*as.numeric(filler_sel_seqs_number))+(as.numeric(upreg_value_X1)*length(group01_upreg_X1_sel_seqs_list))+(as.numeric(upreg_value_X2)*length(group01_upreg_X2_sel_seqs_list))+(as.numeric(upreg_value_X3)*length(group01_upreg_X3_sel_seqs_list))+(as.numeric(upreg_value_X4)*length(group01_upreg_X4_sel_seqs_list))+(as.numeric(upreg_value_X5)*length(group01_upreg_X5_sel_seqs_list))+(as.numeric(base_value)*length(group02_upreg_sel_seqs_list))
sum(as.numeric(group01_sample01_after$TPM))

group01_sample02_after$TPM <- "0.00"

for (transcript_id in c(filler_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X1_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- upreg_value_X1
}

for (transcript_id in c(group01_upreg_X2_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- upreg_value_X2
}

for (transcript_id in c(group01_upreg_X3_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- upreg_value_X3
}

for (transcript_id in c(group01_upreg_X4_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- upreg_value_X4
}

for (transcript_id in c(group01_upreg_X5_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- upreg_value_X5
}

for (transcript_id in c(group02_upreg_X1_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X2_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X3_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X4_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X5_sel_seqs_list)){
  group01_sample02_after$TPM[group01_sample02_after$transcript_id == transcript_id] <- base_value
}

(as.numeric(base_value)*as.numeric(filler_sel_seqs_number))+(as.numeric(upreg_value_X1)*length(group01_upreg_X1_sel_seqs_list))+(as.numeric(upreg_value_X2)*length(group01_upreg_X2_sel_seqs_list))+(as.numeric(upreg_value_X3)*length(group01_upreg_X3_sel_seqs_list))+(as.numeric(upreg_value_X4)*length(group01_upreg_X4_sel_seqs_list))+(as.numeric(upreg_value_X5)*length(group01_upreg_X5_sel_seqs_list))+(as.numeric(base_value)*length(group02_upreg_sel_seqs_list))
sum(as.numeric(group01_sample02_after$TPM))

group01_sample03_after$TPM <- "0.00"

for (transcript_id in c(filler_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X1_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- upreg_value_X1
}

for (transcript_id in c(group01_upreg_X2_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- upreg_value_X2
}

for (transcript_id in c(group01_upreg_X3_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- upreg_value_X3
}

for (transcript_id in c(group01_upreg_X4_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- upreg_value_X4
}

for (transcript_id in c(group01_upreg_X5_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- upreg_value_X5
}

for (transcript_id in c(group02_upreg_X1_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X2_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X3_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X4_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X5_sel_seqs_list)){
  group01_sample03_after$TPM[group01_sample03_after$transcript_id == transcript_id] <- base_value
}

(as.numeric(base_value)*as.numeric(filler_sel_seqs_number))+(as.numeric(upreg_value_X1)*length(group01_upreg_X1_sel_seqs_list))+(as.numeric(upreg_value_X2)*length(group01_upreg_X2_sel_seqs_list))+(as.numeric(upreg_value_X3)*length(group01_upreg_X3_sel_seqs_list))+(as.numeric(upreg_value_X4)*length(group01_upreg_X4_sel_seqs_list))+(as.numeric(upreg_value_X5)*length(group01_upreg_X5_sel_seqs_list))+(as.numeric(base_value)*length(group02_upreg_sel_seqs_list))
sum(as.numeric(group01_sample03_after$TPM))

group02_sample01_after$TPM <- "0.00"

for (transcript_id in c(filler_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X1_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- upreg_value_X1
}

for (transcript_id in c(group02_upreg_X2_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- upreg_value_X2
}

for (transcript_id in c(group02_upreg_X3_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- upreg_value_X3
}

for (transcript_id in c(group02_upreg_X4_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- upreg_value_X4
}

for (transcript_id in c(group02_upreg_X5_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- upreg_value_X5
}

for (transcript_id in c(group01_upreg_X1_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X2_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X3_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X4_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X5_sel_seqs_list)){
  group02_sample01_after$TPM[group02_sample01_after$transcript_id == transcript_id] <- base_value
}

(as.numeric(base_value)*as.numeric(filler_sel_seqs_number))+(as.numeric(upreg_value_X1)*length(group02_upreg_X1_sel_seqs_list))+(as.numeric(upreg_value_X2)*length(group02_upreg_X2_sel_seqs_list))+(as.numeric(upreg_value_X3)*length(group02_upreg_X3_sel_seqs_list))+(as.numeric(upreg_value_X4)*length(group02_upreg_X4_sel_seqs_list))+(as.numeric(upreg_value_X5)*length(group02_upreg_X5_sel_seqs_list))+(as.numeric(base_value)*length(group01_upreg_sel_seqs_list))
sum(as.numeric(group02_sample01_after$TPM))

group02_sample02_after$TPM <- "0.00"

for (transcript_id in c(filler_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X1_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- upreg_value_X1
}

for (transcript_id in c(group02_upreg_X2_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- upreg_value_X2
}

for (transcript_id in c(group02_upreg_X3_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- upreg_value_X3
}

for (transcript_id in c(group02_upreg_X4_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- upreg_value_X4
}

for (transcript_id in c(group02_upreg_X5_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- upreg_value_X5
}

for (transcript_id in c(group01_upreg_X1_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X2_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X3_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X4_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X5_sel_seqs_list)){
  group02_sample02_after$TPM[group02_sample02_after$transcript_id == transcript_id] <- base_value
}

(as.numeric(base_value)*as.numeric(filler_sel_seqs_number))+(as.numeric(upreg_value_X1)*length(group02_upreg_X1_sel_seqs_list))+(as.numeric(upreg_value_X2)*length(group02_upreg_X2_sel_seqs_list))+(as.numeric(upreg_value_X3)*length(group02_upreg_X3_sel_seqs_list))+(as.numeric(upreg_value_X4)*length(group02_upreg_X4_sel_seqs_list))+(as.numeric(upreg_value_X5)*length(group02_upreg_X5_sel_seqs_list))+(as.numeric(base_value)*length(group01_upreg_sel_seqs_list))
sum(as.numeric(group02_sample02_after$TPM))

group02_sample03_after$TPM <- "0.00"

for (transcript_id in c(filler_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group02_upreg_X1_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- upreg_value_X1
}

for (transcript_id in c(group02_upreg_X2_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- upreg_value_X2
}

for (transcript_id in c(group02_upreg_X3_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- upreg_value_X3
}

for (transcript_id in c(group02_upreg_X4_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- upreg_value_X4
}

for (transcript_id in c(group02_upreg_X5_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- upreg_value_X5
}

for (transcript_id in c(group01_upreg_X1_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X2_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X3_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X4_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- base_value
}

for (transcript_id in c(group01_upreg_X5_sel_seqs_list)){
  group02_sample03_after$TPM[group02_sample03_after$transcript_id == transcript_id] <- base_value
}

(as.numeric(base_value)*as.numeric(filler_sel_seqs_number))+(as.numeric(upreg_value_X1)*length(group02_upreg_X1_sel_seqs_list))+(as.numeric(upreg_value_X2)*length(group02_upreg_X2_sel_seqs_list))+(as.numeric(upreg_value_X3)*length(group02_upreg_X3_sel_seqs_list))+(as.numeric(upreg_value_X4)*length(group02_upreg_X4_sel_seqs_list))+(as.numeric(upreg_value_X5)*length(group02_upreg_X5_sel_seqs_list))+(as.numeric(base_value)*length(group01_upreg_sel_seqs_list))
sum(as.numeric(group02_sample03_after$TPM))

#TABLES EXPORT
write.table(group01_sample01_after, file = paste("edited_", group01_sample01_samplename, ".isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(group01_sample02_after, file = paste("edited_", group01_sample02_samplename, ".isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(group01_sample03_after, file = paste("edited_", group01_sample03_samplename, ".isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(group02_sample01_after, file = paste("edited_", group02_sample01_samplename, ".isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(group02_sample02_after, file = paste("edited_", group02_sample02_samplename, ".isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)
write.table(group02_sample03_after, file = paste("edited_", group02_sample03_samplename, ".isoforms.results", sep=""), row.names = FALSE, sep = "\t", quote = FALSE)

