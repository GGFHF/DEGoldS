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
#candidate_upreg_seqs_file_path: a text file with a list of selectable transcript IDs in the first column with no header for upregulated transcripts selection (i. e. selectable transcripts pool), for example, "08-path1_candidate_unique_seqs_IDs.txt" (Sim1) and "11-path1_candidate_unique-plus_seqs.txt" (Sim2) file path from 2b-A02
#group01_upreg_seqs_x1_number: number of transcripts to select for group 1 with level 1 of expression in upregulated transcripts
#group01_upreg_seqs_x2_number: number of transcripts to select for group 1 with level 2 of expression in upregulated transcripts
#group01_upreg_seqs_x3_number: number of transcripts to select for group 1 with level 3 of expression in upregulated transcripts
#group01_upreg_seqs_x4_number: number of transcripts to select for group 1 with level 4 of expression in upregulated transcripts
#group01_upreg_seqs_x5_number: number of transcripts to select for group 1 with level 5 of expression in upregulated transcripts
#group02_upreg_seqs_x1_number: number of transcripts to select for group 2 with level 1 of expression in upregulated transcripts
#group02_upreg_seqs_x2_number: number of transcripts to select for group 2 with level 1 of expression in upregulated transcripts
#group02_upreg_seqs_x3_number: number of transcripts to select for group 2 with level 1 of expression in upregulated transcripts
#group02_upreg_seqs_x4_number: number of transcripts to select for group 2 with level 1 of expression in upregulated transcripts
#group02_upreg_seqs_x5_number: number of transcripts to select for group 2 with level 1 of expression in upregulated transcripts

#VARIABLES DEFINITION
wd <- ""

candidate_upreg_seqs_file_path <- ""
group01_upreg_seqs_x1_number <- 
group01_upreg_seqs_x2_number <- 
group01_upreg_seqs_x3_number <- 
group01_upreg_seqs_x4_number <- 
group01_upreg_seqs_x5_number <- 
group02_upreg_seqs_x1_number <- 
group02_upreg_seqs_x2_number <- 
group02_upreg_seqs_x3_number <- 
group02_upreg_seqs_x4_number <- 
group02_upreg_seqs_x5_number <- 

#TABLE IMPORT
setwd(wd)
candidate_upreg_seqs_table <- read.table(candidate_upreg_seqs_file_path, header=FALSE)
rownames(candidate_upreg_seqs_table) <- candidate_upreg_seqs_table$V1

#UPREGULATED SEQUENCES SELECTION
candidate_upreg_seqs_list <- candidate_upreg_seqs_table$V1

group01_upreg_seqs_x1 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x1_number)
group01_upreg_seqs_x2 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x2_number)
group01_upreg_seqs_x3 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x3_number)
group01_upreg_seqs_x4 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x4_number)
group01_upreg_seqs_x5 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x5_number)
group02_upreg_seqs_x1 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x1_number)
group02_upreg_seqs_x2 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x2_number)
group02_upreg_seqs_x3 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x3_number)
group02_upreg_seqs_x4 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x4_number)
group02_upreg_seqs_x5 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x5_number)

total_sel_seqs_list <- union(group02_upreg_seqs_x5, union(group02_upreg_seqs_x4, union(group02_upreg_seqs_x3, union(group02_upreg_seqs_x2, union(group02_upreg_seqs_x1, union(group01_upreg_seqs_x5, union(group01_upreg_seqs_x4, union(group01_upreg_seqs_x3, union(group01_upreg_seqs_x1, group01_upreg_seqs_x2)))))))))
total_sel_seqs_list
total_sel_seqs_number <- length(total_sel_seqs_list)
total_sel_seqs_number
target_total_sel_seqs_number <- (as.numeric(group01_upreg_seqs_x1_number))+(as.numeric(group01_upreg_seqs_x2_number))+(as.numeric(group01_upreg_seqs_x3_number))+(as.numeric(group01_upreg_seqs_x4_number))+(as.numeric(group01_upreg_seqs_x5_number))+(as.numeric(group02_upreg_seqs_x1_number))+(as.numeric(group02_upreg_seqs_x2_number))+(as.numeric(group02_upreg_seqs_x3_number))+(as.numeric(group02_upreg_seqs_x4_number))+(as.numeric(group02_upreg_seqs_x5_number))
target_total_sel_seqs_number

while (total_sel_seqs_number != target_total_sel_seqs_number) {
  group01_upreg_seqs_x1 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x1_number)
  group01_upreg_seqs_x2 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x2_number)
  group01_upreg_seqs_x3 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x3_number)
  group01_upreg_seqs_x4 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x4_number)
  group01_upreg_seqs_x5 <- sample(candidate_upreg_seqs_list, group01_upreg_seqs_x5_number)
  group02_upreg_seqs_x1 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x1_number)
  group02_upreg_seqs_x2 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x2_number)
  group02_upreg_seqs_x3 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x3_number)
  group02_upreg_seqs_x4 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x4_number)
  group02_upreg_seqs_x5 <- sample(candidate_upreg_seqs_list, group02_upreg_seqs_x5_number)
  total_sel_seqs_list <- union(group02_upreg_seqs_x5, union(group02_upreg_seqs_x4, union(group02_upreg_seqs_x3, union(group02_upreg_seqs_x2, union(group02_upreg_seqs_x1, union(group01_upreg_seqs_x5, union(group01_upreg_seqs_x4, union(group01_upreg_seqs_x3, union(group01_upreg_seqs_x1, group01_upreg_seqs_x2)))))))))
  total_sel_seqs_number <- length(total_sel_seqs_list)
  if (total_sel_seqs_number == target_total_sel_seqs_number)
    break
} 

length(total_sel_seqs_list)

write.table(group01_upreg_seqs_x1, file = "group01_upreg_seqs_x1.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group01_upreg_seqs_x2, file = "group01_upreg_seqs_x2.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group01_upreg_seqs_x3, file = "group01_upreg_seqs_x3.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group01_upreg_seqs_x4, file = "group01_upreg_seqs_x4.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group01_upreg_seqs_x5, file = "group01_upreg_seqs_x5.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group02_upreg_seqs_x1, file = "group02_upreg_seqs_x1.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group02_upreg_seqs_x2, file = "group02_upreg_seqs_x2.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group02_upreg_seqs_x3, file = "group02_upreg_seqs_x3.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group02_upreg_seqs_x4, file = "group02_upreg_seqs_x4.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(group02_upreg_seqs_x5, file = "group02_upreg_seqs_x5.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
