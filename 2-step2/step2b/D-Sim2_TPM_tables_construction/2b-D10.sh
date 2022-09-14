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
#LEARN_DIR: "02-model_learning/output/" directory from script 2a-01
#UPREG_SEL_SEQS_FILE_PATH: "01-DE_trinity_transcripts.txt" file path from 2b-C02 (Sim1) and "upreg_seqs.txt" file path from script 2b-D05 (Sim2)
#FILLER_SEL_SEQS_FILE_PATH: "filler_seqs.txt" file path from script 2b-D07
#SURPLUS_OBT_SEQS_FILE_PATH: "surplus_seqs_ids.txt" file path from script 2b-D09

#VARIABLES DEFINITION
WD=""

LEARN_DIR=""
UPREG_SEL_SEQS_FILE_PATH=""
FILLER_SEL_SEQS_FILE_PATH=""
SURPLUS_OBT_SEQS_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-COUNT TABLES BY SEQ TYPE SEPARATION
echo '**************************************************'
echo 'DIVIDING COUNT TABLES BY SEQ TYPE ...'

mkdir "$WD"/output
mkdir "$WD"/output/temp

ls -d "$LEARN_DIR"/*.stat > "$WD"/output/temp/stats_dir.txt

while read DIR_STATS; do

	SAMPLENAME=`echo $DIR_STATS | sed 's/.stat//g' | sed "s,$LEARN_DIR,,g" | sed 's,/,,g'`
	LEARN_FILE_PATH=`echo $DIR_STATS | sed 's/.stat/.isoforms.results/g'`

	grep -Fw -f "$UPREG_SEL_SEQS_FILE_PATH" "$LEARN_FILE_PATH" > "$WD"/output/upreg_"$SAMPLENAME".isoforms.results
	grep -Fw -f "$FILLER_SEL_SEQS_FILE_PATH" "$LEARN_FILE_PATH" > "$WD"/output/filler_"$SAMPLENAME".isoforms.results
    grep -Fw -f "$SURPLUS_OBT_SEQS_FILE_PATH" "$LEARN_FILE_PATH" > "$WD"/output/surplus_"$SAMPLENAME".isoforms.results
    
    if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

done < "$WD"/output/temp/stats_dir.txt

rm -r "$WD"/output/temp

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
