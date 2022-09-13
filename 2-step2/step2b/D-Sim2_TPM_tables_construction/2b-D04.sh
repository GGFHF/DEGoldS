#!/bin/bash

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
#WD: Working directory
#SEL_SIG_SEQS_FILE_PATH: "01-sel_sig_seqs.txt" file path from script 2b-D03
#SEL_NO_SIG_SEQS_FILE_PATH: "02-sel_no_sig_seqs.txt" file path from script 2b-D03
#SIG_COUNT_MATRIX_FILE_PATH: "05-common_sig_rest_removed_count_matrix.csv" file path from script 2b-D02
#NO_SIG_COUNT_MATRIX_FILE_PATH: "06-no_sig_rest_removed_count_matrix.csv" file path from script 2b-D02

#VARIABLES DEFINITION
WD=""

SEL_SIG_SEQS_FILE_PATH=""
SEL_NO_SIG_SEQS_FILE_PATH=""
SIG_COUNT_MATRIX_FILE_PATH=""
NO_SIG_COUNT_MATRIX_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- SIGNIFICANT AND NO SIGNIFICANT COUNT MATRIX COMPLETION
echo '**************************************************'
echo 'COMPLETING SIGNIFICANT AND NO SIGNIFICANT COUNT MATRIX ...'

#cd "$CONDADIR"
#source activate "$RSEMENV"
cd "$WD"

mkdir "$WD"/output
mkdir "$WD"/output/temp

head -n 1 "$SIG_COUNT_MATRIX_FILE_PATH" > "$WD"/output/temp/01-count_matrix_header.csv
grep -Fw -f "$SEL_SIG_SEQS_FILE_PATH" "$SIG_COUNT_MATRIX_FILE_PATH" > "$WD"/output/temp/02-no_header_complete_sig_count_matrix
grep -Fw -f "$SEL_NO_SIG_SEQS_FILE_PATH" "$NO_SIG_COUNT_MATRIX_FILE_PATH" > "$WD"/output/temp/03-no_header_no_sig_count_matrix.csv
cat "$WD"/output/temp/03-no_header_no_sig_count_matrix.csv  > "$WD"/output/temp/04-no_header_complete_no_sig_count_matrix.csv

cat "$WD"/output/temp/01-count_matrix_header.csv "$WD"/output/temp/02-no_header_complete_sig_count_matrix > "$WD"/output/01-complete_sig_count_matrix
cat "$WD"/output/temp/01-count_matrix_header.csv "$WD"/output/temp/04-no_header_complete_no_sig_count_matrix.csv > "$WD"/output/02-complete_no_sig_count_matrix.csv

rm -r "$WD"/output/temp

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
