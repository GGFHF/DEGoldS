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
#upreg_seqs_number: number of upregulated transcripts to select

#VARIABLES DEFINITION
wd <- ""

candidate_upreg_seqs_file_path <- ""
upreg_seqs_number <- 

#TABLE IMPORT
setwd(wd)
candidate_upreg_seqs_table <- read.table(candidate_upreg_seqs_file_path, header=FALSE)
rownames(candidate_upreg_seqs_table) <- candidate_upreg_seqs_table$V1

#UPREGULATED SEQUENCES SELECTION
candidate_upreg_seqs_list <- candidate_upreg_seqs_table$V1

upreg_sel_seqs_list <- sample(candidate_upreg_seqs_list, upreg_seqs_number)

write.table(upreg_sel_seqs_list, file = "upreg_seqs.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
