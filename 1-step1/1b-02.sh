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
#RAW_TRANSCRIPTOME_FILE_PATH: pre-filtered transcriptome FASTA file path
#TRANSCRIPTOME_NAME: filtered transcriptome name (file name without extension)
#NGSHELPER_DIR: NGSHelper directory

#VARIABLES DEFINITION
WD=""

RAW_TRANSCRIPTOME_FILE_PATH=""
TRANSCRIPTOME_NAME=""

NGSHELPER_DIR=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-TRANCRIPTS FILTERING BY LENGHT
echo '**************************************************'
echo 'FILTERING TRANSCRIPTS BY LENGHT ...'

cd "$NGSHELPER_DIR"
mkdir "$WD"/output

# Execute the program filter-transcripts-bylen.py

/usr/bin/time \
    ./filter-fasta.py \
        --fasta="$RAW_TRANSCRIPTOME_FILE_PATH"\
        --output="$WD"/output/"$TRANSCRIPTOME_NAME".fasta \
        --minlen=300 \
        --maxlen=10000 \
        --verbose=Y \
        --trace=N
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

