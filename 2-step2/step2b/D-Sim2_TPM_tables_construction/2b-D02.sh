#!/bin/bash

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
#WD: Working directory
#COMMONDEIDS: "03-DESeq2_edgeR_common_sig_isoforms.csv" file path from script 2b-B05
#NOTCOMMONDEIDS: "06-DESeq2_edgeR_not_common_sig_isoforms.csv" file path from script 2b-B05
#COUNTMATRIX: "01-learn_count_matrix.csv" file path from script 2b-D01
#DESEQ2_LEARN_DE_ALL_RES: "01-learning_DESeq2_all_seqs.csv" file path from script 2b-B01
#EDGER_LEARN_DE_ALL_RES: "01-learning_edgeR_all_seqs.csv" file path from script 2b-B01
#DESEQ2_LEARN_DE_SIG_RES: "02-learning_DESeq2_sig_seqs.csv" file path from script 2b-B01
#EDGER_LEARN_DE_SIG_RES: "02-learning_edgeR_sig_seqs.csv" file path from script 2b-B03
#NF_DESEQ2_LEARN_DE_SIG_RES: "02-nf_learning_DESeq2_sig_seqs.csv" file path from script 2b-B01
#NF_EDGER_LEARN_DE_SIG_RES: "02-learning_edgeR_sig_seqs.csv" file path from script 2b-B01
#FILTNUMSIGDESEQ2: number of DESeq2 significant sequences to be filtered starting from bottom
#FILTNUMSIGEDGER: number of edgeR significant sequences to be filtered starting from bottom
#FILTNUMNOSIGDESEQ2: number of DESeq2 non-significant sequences to be filtered starting from head
#FILTNUMNOSIGEDGER: number of edgeR non-significant sequences to be filtered starting from head

#VARIABLES DEFINITION
WD=""

COMMONDEIDS=""
NOTCOMMONDEIDS=""
COUNTMATRIX=""
DESEQ2_LEARN_DE_ALL_RES=""
EDGER_LEARN_DE_ALL_RES=""
DESEQ2_LEARN_DE_SIG_RES=""
EDGER_LEARN_DE_SIG_RES=""
NF_DESEQ2_LEARN_DE_SIG_RES=""
NF_EDGER_LEARN_DE_SIG_RES=""
FILTNUMSIGDESEQ2=
FILTNUMSIGEDGER=
FILTNUMNOSIGDESEQ2=
FILTNUMNOSIGEDGER=


#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-COUNT MATRIX BY SIGNIFICANCE SEPARATION
echo '**************************************************'
echo 'DIVIDING COUNT MATRIX BY SIGNIFICANCE ...'

mkdir "$WD"/output
mkdir "$WD"/output/temp

head -n 1 "$COUNTMATRIX" > "$WD"/output/temp/01-count_matrix_header.csv
grep -Fw -f "$COMMONDEIDS" "$COUNTMATRIX" > "$WD"/output/temp/02-no_header_common_sig_count_matrix.csv
grep -Fw -f "$NOTCOMMONDEIDS" "$COUNTMATRIX" > "$WD"/output/temp/03-no_header_not_common_sig_count_matrix.csv
cat "$COMMONDEIDS" "$NOTCOMMONDEIDS" > "$WD"/output/temp/04-total_sig_isoforms.txt
grep -Fw -f "$COMMONDEIDS" "$DESEQ2_LEARN_DE_SIG_RES" | cut -d "," -f 1 | sed 's/"//g' | tail -n "$FILTNUMSIGDESEQ2" > "$WD"/output/temp/05-deseq2_sig_to_remove_isoforms.csv
grep -Fw -f "$COMMONDEIDS" "$EDGER_LEARN_DE_SIG_RES" | cut -d " " -f 1 | sed 's/"//g' | tail -n "$FILTNUMSIGEDGER" > "$WD"/output/temp/06-edgeR_sig_to_remove_isoforms.csv

cut -d "," -f 1 "$DESEQ2_LEARN_DE_SIG_RES" | tail -n +2 | sed 's/"//g' >  "$WD"/output/temp/07-deseq2_sig_isoforms.csv
cut -d " " -f 1 "$EDGER_LEARN_DE_SIG_RES" | tail -n +2 | sed 's/"//g' > "$WD"/output/temp/08-edgeR_sig_isoforms.csv
cut -d "," -f 1 "$NF_DESEQ2_LEARN_DE_SIG_RES" | tail -n +2 | sed 's/"//g' >  "$WD"/output/temp/09-deseq2_no_filtered_sig_isoforms.csv
cut -d " " -f 1 "$NF_EDGER_LEARN_DE_SIG_RES" | tail -n +2 | sed 's/"//g' > "$WD"/output/temp/10-edgeR_no_filtered_sig_isoforms.csv
grep -Fw -v -f "$WD"/output/temp/07-deseq2_sig_isoforms.csv "$WD"/output/temp/09-deseq2_no_filtered_sig_isoforms.csv > "$WD"/output/temp/11-deseq2_only_no_filtered_sig_isoforms.csv
grep -Fw -v -f "$WD"/output/temp/08-edgeR_sig_isoforms.csv "$WD"/output/temp/10-edgeR_no_filtered_sig_isoforms.csv > "$WD"/output/temp/12-edgeR_only_no_filtered_sig_isoforms.csv
cat "$WD"/output/temp/11-deseq2_only_no_filtered_sig_isoforms.csv "$WD"/output/temp/12-edgeR_only_no_filtered_sig_isoforms.csv | sort | uniq > "$WD"/output/temp/13-total_only_no_filtered_sig_isoforms.csv
grep -Fw "NA" "$DESEQ2_LEARN_DE_ALL_RES" | cut -d "," -f 1 | sed 's/"//g' > "$WD"/output/temp/14-deseq2_excluded_from_analysis.csv
grep -Fw "NA" "$EDGER_LEARN_DE_ALL_RES" | cut -d " " -f 1 | sed 's/"//g' > "$WD"/output/temp/15-edgeR_excluded_from_analysis.csv
cat "$WD"/output/temp/14-deseq2_excluded_from_analysis.csv "$WD"/output/temp/15-edgeR_excluded_from_analysis.csv | sort | uniq > "$WD"/output/temp/16-total_excluded_from_analysis.csv
cat "$WD"/output/temp/16-total_excluded_from_analysis.csv "$WD"/output/temp/13-total_only_no_filtered_sig_isoforms.csv "$WD"/output/temp/04-total_sig_isoforms.txt | sort | uniq > "$WD"/output/temp/17-total_excluded_from_analysis_sig_only_no_filtered_sig_isoforms.txt
grep -Fw -v -f "$WD"/output/temp/17-total_excluded_from_analysis_sig_only_no_filtered_sig_isoforms.txt "$DESEQ2_LEARN_DE_ALL_RES" | tail -n +2 | cut -d "," -f 1 | sed 's/"//g' | head -n "$FILTNUMNOSIGDESEQ2" > "$WD"/output/temp/18-deseq2_no_sig_to_remove_isoforms.csv
grep -Fw -v -f "$WD"/output/temp/17-total_excluded_from_analysis_sig_only_no_filtered_sig_isoforms.txt "$EDGER_LEARN_DE_ALL_RES" | tail -n +2 | cut -d " " -f 1 | sed 's/"//g' | head -n "$FILTNUMNOSIGEDGER"  > "$WD"/output/temp/19-edgeR_no_sig_to_remove_isoforms.csv
cat "$WD"/output/temp/05-deseq2_sig_to_remove_isoforms.csv "$WD"/output/temp/06-edgeR_sig_to_remove_isoforms.csv | sort | uniq > "$WD"/output/temp/20-total_sig_to_remove_isoforms.csv
cat "$WD"/output/temp/18-deseq2_no_sig_to_remove_isoforms.csv "$WD"/output/temp/19-edgeR_no_sig_to_remove_isoforms.csv | sort | uniq > "$WD"/output/temp/21-total_no_sig_to_remove_isoforms.csv

cat "$WD"/output/temp/01-count_matrix_header.csv "$WD"/output/temp/02-no_header_common_sig_count_matrix.csv > "$WD"/output/01-common_sig_count_matrix.csv
cat "$WD"/output/temp/01-count_matrix_header.csv "$WD"/output/temp/03-no_header_not_common_sig_count_matrix.csv > "$WD"/output/02-not_common_sig_count_matrix.csv
grep -Fw -v -f "$WD"/output/temp/04-total_sig_isoforms.txt "$COUNTMATRIX" > "$WD"/output/03-no_sig_count_matrix.csv
grep -Fw -v -f "$WD"/output/temp/17-total_excluded_from_analysis_sig_only_no_filtered_sig_isoforms.txt "$COUNTMATRIX" > "$WD"/output/04-no_sig_no_only_no_filtered_sig_without_excluded_from_analysis_count_matrix.csv
grep -Fw -v -f "$WD"/output/temp/20-total_sig_to_remove_isoforms.csv "$WD"/output/01-common_sig_count_matrix.csv > "$WD"/output/05-common_sig_rest_removed_count_matrix.csv
grep -Fw -v -f "$WD"/output/temp/21-total_no_sig_to_remove_isoforms.csv "$WD"/output/04-no_sig_no_only_no_filtered_sig_without_excluded_from_analysis_count_matrix.csv > "$WD"/output/06-no_sig_rest_removed_count_matrix.csv

rm -r "$WD"/output/temp

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
