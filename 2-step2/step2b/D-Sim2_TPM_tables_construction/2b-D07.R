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
#filler_pre_candidate_seqs_file_path: a text file with a list of selectable transcript IDs in the first column with no header for filler transcripts selection (i. e. selectable transcripts pool), for example, "10-candidate_unique-plus_seqs.txt" file path in script 2b-A02
#upreg_sel_seqs_file_path: "01-DE_trinity_transcripts.txt" file path from script 2b-C02 (Sim1) or "upreg_seqs.txt" file path from script 2b-D05 (Sim2)
#filler_sel_seqs_number: number of filler transcripts to select

#VARIABLES DEFINITION
wd <- ""

filler_pre_candidate_seqs_file_path <- ""
upreg_sel_seqs_file_path <- ""
filler_sel_seqs_number <- 

#TABLE IMPORT
setwd(wd)
filler_pre_candidate_seqs_table <- read.table(filler_pre_candidate_seqs_file_path, header=FALSE)
rownames(filler_pre_candidate_seqs_table) <- filler_pre_candidate_seqs_table$V1

#FILLER SEQUENCES SELECTION
filler_pre_candidate_seqs_list <- filler_pre_candidate_seqs_table$V1

upreg_sel_seqs_table <- read.table(upreg_sel_seqs_file_path)
upreg_sel_seqs_list <- upreg_sel_seqs_table$V1

upreg_sel_seqs_list <- c(upreg_sel_seqs_list)
             
filler_candidate_seqs_list <- setdiff(filler_pre_candidate_seqs_list,upreg_sel_seqs_list)
filler_sel_seqs_list <- sample(filler_candidate_seqs_list, filler_sel_seqs_number)

total_sel_seqs_list <- union(upreg_sel_seqs_list, filler_sel_seqs_list)
total_sel_seqs_number <- length(total_sel_seqs_list)
total_sel_seqs_number
common_seqs <- intersect(upreg_sel_seqs_list,filler_sel_seqs_list)
common_seqs
target_total_sel_seqs_number = (as.numeric(filler_sel_seqs_number))+(length(upreg_sel_seqs_list))
target_total_sel_seqs_number

while (total_sel_seqs_number != target_total_sel_seqs_number) {
  filler_sel_seqs_list <- sample(candidate_seqs_list, filler_sel_seqs_number)
  total_sel_seqs_list <- union(upreg_sel_seqs_list, filler_sel_seqs_list)
  total_sel_seqs_number <- length(total_sel_seqs_list)
  if (total_sel_seqs_number == target_total_sel_seqs_number)
    break
}

length(total_sel_seqs_list)
intersect(upreg_sel_seqs_list,filler_sel_seqs_list)

write.table(filler_sel_seqs_list, file = "filler_seqs.txt", col.names = FALSE, row.names = FALSE, sep = "  ", quote = FALSE)
