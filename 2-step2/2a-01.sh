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
#TRANSCRIPTOME_FILE_PATH: by length filtered transcriptome FASTA file path
#TRANSCRIPTOME_INDEX_NAME: transcriptome RSEM index name
#READS_DIR: Reads directory
#BOWTIE2_DIR: Bowtie2 directory

#VARIABLES DEFINITION
WD=""

TRANSCRIPTOME_FILE_PATH=""
TRANSCRIPTOME_INDEX_NAME=""
READS_DIR=""

BOWTIE2_DIR=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- REFERENCE TRANSCRIPTOME PREPARATION FOR RSEM
echo '**************************************************'
echo 'PREPARING REFERENCE TRANSCRIPTOME FOR RSEM ...'

mkdir "$WD"/01-reference_index
mkdir "$WD"/01-reference_index/output

rsem-prepare-reference "$TRANSCRIPTOME_FILE_PATH" "$WD"/01-reference_index/output/"$TRANSCRIPTOME_INDEX_NAME" --bowtie2 --bowtie2-path "$BOWTIE2_DIR"

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#2- PARAMETRES LEARNING FROM REAL DATA
echo '**************************************************'
echo 'LEARNING PARAMETRES FROM REAL DATA ...'

mkdir "$WD"/02-model_learning
mkdir "$WD"/02-model_learning/output

cd "$CONDADIR"
source activate "$RSEM_ENV"
cd "$WD"

ls "$READS_DIR"/*_1.fq.gz > "$READS_DIR"/reads_files.txt

while read FILE1_READS; do

	FILE2_READS=`echo $FILE1_READS | sed 's/_1.fq.gz/_2.fq.gz/g'`
	SAMPLENAME=`echo $FILE1_READS | sed 's/_1.fq.gz//g' | sed "s,$READS_DIR,,g" | sed 's,/,,g'`

	rsem-calculate-expression --paired-end "$FILE1_READS" "$FILE2_READS" "$WD"/01-reference_index/output/"$TRANSCRIPTOME_INDEX_NAME" "$WD"/02-model_learning/output/"$SAMPLENAME" --bowtie2 --bowtie2-path "$BOWTIE2_DIR"

done < "$READS_DIR"/reads_files.txt

rm "$READS_DIR"/reads_files.txt

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
