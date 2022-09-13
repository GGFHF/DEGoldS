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
#CORRESP_FILE_PATH: "ref_pipeline.txt" file path from 4a-01
#SIMGS_FILE_DEL: column delimiter in $SIMGS_FILE_PATH
#SIMGS_FILE_GENE_ID_COL_NUMBER: gene ID column number in $SIMGS_FILE_PATH
#SIMGS_FILE_PATH: "simGS_DESeq2.csv" (DESeq2) and "simGS_edgeR.csv" file path (edgeR) from 2d-01 and 2d-02 respectively or any other used
#UPREG_SEL_SEQS_FILE_PATH: "01-DE_trinity_transcripts.txt" file path from 2b-C02 (Sim1) and "upreg_seqs.txt" file path from script 2b-D05 (Sim2)
#PIPELINE_TX2GENE_FILE_PATH: two column text file (transcript ID-gene ID) separated by space (view tx2gene.csv example file) for pipeline gene IDs
#GS_NAME: gold-standard given name (recommended a name distinguishing each DE analysers, i.e. DESeq2/edgeR)

#VARIABLES DEFINITION
WD=""

CORRESP_FILE_PATH=""
SIMGS_FILE_DEL=""
SIMGS_FILE_GENE_ID_COL_NUMBER=
SIMGS_FILE_PATH=""
UPREG_SEL_SEQS_FILE_PATH=""
PIPELINE_TX2GENE_FILE_PATH=""
GS_NAME=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- UPREGULATED SEQUENCE CORRESPONDENCE ID RECOVERY
echo '**************************************************'
echo 'RECOVERING UPREGULATED SEQUENCE CORRESPONDENCE ID ...'

mkdir "$WD"/output
mkdir "$WD"/output/temp

grep -v "i	" "$CORRESP_FILE_PATH" \
| grep -v "y	" \
| awk -F "\t" '{if ($1 ~ /^>/) print $1; else print $6;}' \
| sed 'N;/>.*\n.*>/!P;D' | awk '{if ($1 ~ /^>/) print $1;else print $1",";}' \
| awk '/^>/ {printf("%s%s\t",(N>0?"\n":""),$0);N++;next;} {printf("%s",$0);} END {printf("\n");}' \
| sed 's/>//g' \
| sed 's/.$//' > "$WD"/output/01-correspondence_table.csv
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

cut -d "$SIMGS_FILE_DEL" -f "$SIMGS_FILE_GENE_ID_COL_NUMBER" "$SIMGS_FILE_PATH" | tail -n +2 | sed 's/"//' | sed 's/"//' | sed 's/$/_/'  > "$WD"/output/temp/01-"$GS_NAME"_edited_simGS_geneIDs.txt
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

grep -F -f "$WD"/output/temp/01-"$GS_NAME"_edited_simGS_geneIDs.txt "$UPREG_SEL_SEQS_FILE_PATH" >  "$WD"/output/02-"$GS_NAME"_simGS_transcriptIDs.csv
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

grep -Fw -f "$WD"/output/02-"$GS_NAME"_simGS_transcriptIDs.csv "$WD"/output/01-correspondence_table.csv > "$WD"/output/03-"$GS_NAME"_simGS_correspondence_table.csv
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

cut -d "	" -f 2 "$WD"/output/03-"$GS_NAME"_simGS_correspondence_table.csv | cut -d "," -f 1 > "$WD"/output/04-"$GS_NAME"_pipelineGS_transcriptIDs.txt
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

grep -Fw -f "$WD"/output/04-"$GS_NAME"_pipelineGS_transcriptIDs.txt "$PIPELINE_TX2GENE_FILE_PATH" | cut -d " " -f 2 | sort | uniq >  "$WD"/output/05-"$GS_NAME"_pipelineGS_geneIDs.txt
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

rm -r "$WD"/output/temp
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi
#END
echo '**************************************************'

