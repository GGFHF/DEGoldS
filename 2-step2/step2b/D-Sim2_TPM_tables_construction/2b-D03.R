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
#sel_sig_seqs_number: number of sequences to select from count matrix in "05-common_sig_rest_removed_count_matrix.csv" from script 2b-D02 that will belong to upregulated transcripts
#sel_no_sig_seqs_number: number of sequences to select from count matrix in "06-no_sig_rest_removed_count_matrix.csv" from script 2b-D02 that will belong to filler transcripts
#sig_count_matrix_file_path: "05-common_sig_rest_removed_count_matrix.csv" file path from script 2b-D02
#no_sig_count_matrix_file_path: "06-no_sig_rest_removed_count_matrix.csv" file path from script 2b-D02

#VARIABLES DEFINITION
wd <- ""

sel_sig_seqs_number <- 
sel_no_sig_seqs_number <- 
sig_count_matrix_file_path <- ""
no_sig_count_matrix_file_path <- ""

#TABLE IMPORT
setwd(wd)
sig_count_matrix <- read.table(sig_count_matrix_file_path, sep="\t", header=TRUE)
rownames(sig_count_matrix) <- sig_count_matrix$transcript_id

no_sig_count_matrix <- read.table(no_sig_count_matrix_file_path, sep="\t", header=TRUE)
rownames(no_sig_count_matrix) <- no_sig_count_matrix$transcript_id

#SIGNIFICANT SEQUENCE RANDOM SELECTION FROM CANDIDATE SEQUENCE POOL
candidate_sig_seqs_list <- sig_count_matrix$transcript_id
candidate_no_sig_seqs_list <- no_sig_count_matrix$transcript_id

sel_sig_seqs_list <- sample(candidate_sig_seqs_list, sel_sig_seqs_number)
sel_no_sig_seqs_list <- sample(candidate_no_sig_seqs_list, sel_no_sig_seqs_number)

write.table(sel_sig_seqs_list, file = "01-sel_sig_seqs.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
write.table(sel_no_sig_seqs_list, file = "02-sel_no_sig_seqs.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
