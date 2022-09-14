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
#UPREG_SEL_SEQS_FILE_PATH: "01-DE_trinity_transcripts.txt" file path from 2b-C02 (Sim1) and "upreg_seqs.txt" file path from script 2b-D05 (Sim2)

#VARIABLES DEFINITION
WD=""

UPREG_SEL_SEQS_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-SELECTED UPREGULATED SEQUENCES CHECK
echo '**************************************************'
echo 'CHECKING SELECTED UPREGULATED SEQUENCES ...'

mkdir "$WD"/output

sort "$UPREG_SEL_SEQS_FILE_PATH" | sort | uniq > "$WD"/output/01-DE_trinity_transcripts.txt
sed 's/_i/ /g' "$WD"/output/01-DE_trinity_transcripts.txt | cut -d " " -f 1 | sort | uniq > "$WD"/output/02-DE_trinity_genes.txt
wc -l "$WD"/output/01-DE_trinity_transcripts.txt > "$WD"/output/03-total_DE_trinity_transcripts.txt
wc -l "$WD"/output/02-DE_trinity_genes.txt > "$WD"/output/04-total_DE_trinity_genes.txt

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
