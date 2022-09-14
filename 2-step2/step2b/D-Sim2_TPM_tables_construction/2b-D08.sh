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
#FILLER_SEL_SEQS_FILE_PATH: "filler_seqs.txt" file path from script 2b-D07

#VARIABLES DEFINITION
WD=""

FILLER_SEL_SEQS_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-FILLER SEQS CHECK
echo '**************************************************'
echo 'CHECKING FILLER SEQS ...'

mkdir "$WD"/output

sort "$FILLER_SEL_SEQS_FILE_PATH" | sort | uniq > "$WD"/output/01-filler_trinity_transcripts.txt
sed 's/_i/ /g' "$WD"/output/01-filler_trinity_transcripts.txt | cut -d " " -f 1 | sort | uniq > "$WD"/output/02-filler_trinity_genes.txt
wc -l "$WD"/output/01-filler_trinity_transcripts.txt > "$WD"/output/03-total_filler_trinity_transcripts.txt
wc -l "$WD"/output/02-filler_trinity_genes.txt > "$WD"/output/04-total_filler_trinity_genes.txt

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
