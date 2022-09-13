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
#DE_RES_FILE_DEL: column delimiter in $DE_RES_FILE_PATH
#DE_RES_FILE_GENE_ID_COL_NUMBER: gene ID column number in $DE_RES_FILE_PATH
#DE_RES_FILE_PATH: DE analysis results table from tested pipeline
#PIPELINEGS_FILE_PATH: "05-$GS_NAME_pipelineGS_geneIDs.txt" file path from script 4a-02

#VARIABLES DEFINITION
WD=""

DE_RES_FILE_DEL=""
DE_RES_FILE_GENE_ID_COL_NUMBER=
DE_RES_FILE_PATH=""
PIPELINEGS_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-DE SCORING
echo '**************************************************'
echo 'SCORING DE ...'

mkdir "$WD"/output
mkdir "$WD"/output/temp

cut -d "$DE_RES_FILE_DEL" -f "$DE_RES_FILE_GENE_ID_COL_NUMBER" "$DE_RES_FILE_PATH" | tail -n +2 | sed 's/"//g' > "$WD"/output/temp/01-pipeline_DEGs.txt
grep -Fw -f "$PIPELINEGS_FILE_PATH" "$WD"/output/temp/01-pipeline_DEGs.txt > "$WD"/output/01-pipeline_TPs.txt
grep -Fw -v -f "$PIPELINEGS_FILE_PATH" "$WD"/output/temp/01-pipeline_DEGs.txt > "$WD"/output/02-pipeline_FPs.txt

rm -r "$WD"/output/temp

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
