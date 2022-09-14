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
#DESEQ2_LEARN_DE_SIG_RES: "02-learning_DESeq2_sig_seqs.csv" file path from script 2b-B01
#EDGER_LEARN_DE_SIG_RES: "02-learning_edgeR_sig_seqs.csv" file path from script 2b-B03

#VARIABLES DEFINITION
WD=""

DESEQ2_LEARN_DE_SIG_RES=""
EDGER_LEARN_DE_SIG_RES=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-DESEQ2 AND EDGER COMMON DEGS EXTRACTION
echo '**************************************************'
echo 'EXTRACTING DESEQ2 AND EDGER COMMON DEGS...'

mkdir "$WD"/output

cut -d "," -f 1 "$DESEQ2_LEARN_DE_SIG_RES" | tail -n +2 | sed 's/"//g'> "$WD"/output/01-DESeq2_sig_isoforms.csv
cut -d " " -f 1 "$EDGER_LEARN_DE_SIG_RES" | tail -n +2 | sed 's/"//g'> "$WD"/output/02-edgeR_sig_isoforms.csv
grep -Fw -f "$WD"/output/01-DESeq2_sig_isoforms.csv "$WD"/output/02-edgeR_sig_isoforms.csv > "$WD"/output/03-DESeq2_edgeR_common_sig_isoforms.csv
grep -Fw -v -f "$WD"/output/02-edgeR_sig_isoforms.csv "$WD"/output/01-DESeq2_sig_isoforms.csv  > "$WD"/output/04-DESeq2_only_sig_isoforms.csv
grep -Fw -v -f "$WD"/output/01-DESeq2_sig_isoforms.csv "$WD"/output/02-edgeR_sig_isoforms.csv > "$WD"/output/05-edgeR_only_sig_isoforms.csv
cat "$WD"/output/04-DESeq2_only_sig_isoforms.csv "$WD"/output/05-edgeR_only_sig_isoforms.csv > "$WD"/output/06-DESeq2_edgeR_not_common_sig_isoforms.csv

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
