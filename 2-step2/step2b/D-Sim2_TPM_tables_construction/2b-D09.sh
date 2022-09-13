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
#SAMPLE_LEARN_FILE_PATH: one of the ".isoform.result" files file path in 2a-01
#UPREG_SEL_SEQS_FILE_PATH: "01-DE_trinity_transcripts.txt" file path from 2b-C02 (Sim1) and "upreg_seqs.txt" file path from script 2b-D05 (Sim2)
#FILLER_SEL_SEQS_FILE_PATH: "filler_seqs.txt" file path from script 2b-D07

#VARIABLES DEFINITION
WD=""

SAMPLE_LEARN_FILE_PATH=""
UPREG_SEL_SEQS_FILE_PATH=""
FILLER_SEL_SEQS_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-SURPLUS SEQS OBTAINING
echo '**************************************************'
echo 'OBTAINING SURPLUS SEQS ...'

mkdir "$WD"/output
mkdir "$WD"/output/temp

cut -d "	" -f 1 "$SAMPLE_LEARN_FILE_PATH" | tail -n +2 > "$WD"/output/temp/01-all_seqs_ids.txt
cat "$UPREG_SEL_SEQS_FILE_PATH" "$FILLER_SEL_SEQS_FILE_PATH" > "$WD"/output/temp/02-DEGs_and_filler_seqs_ids.txt
grep -Fw -v -f "$WD"/output/temp/02-DEGs_and_filler_seqs_ids.txt "$WD"/output/temp/01-all_seqs_ids.txt > "$WD"/output/surplus_seqs_ids.txt

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

rm -r "$WD"/output/temp

#END
echo '**************************************************'
