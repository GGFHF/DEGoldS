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
#GMAP_ALIGNMENT_FILE: (alignment.log in 1d-02)
#NGSHELPER_DIR: NGSHelper directory

#VARIABLES DEFINITION
WD=""

GMAP_ALIGNMENT_FILE=""

NGSHELPER_DIR=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-TTRANSCRIPTS CLASSIFICATION ACCORDING TO MAPPING TIMES
echo '**************************************************'
echo 'CLASSIFYING TRANSCRIPTS ACCORDING TO MAPPING TIMES ...'

cd "$NGSHELPER_DIR"
mkdir "$WD"/output

# Execute the program get-exon-data.py

/usr/bin/time \
    ./get-exon-data.py \
        --alignment="$GMAP_ALIGNMENT_FILE" \
        --outdir="$WD"/output \
        --verbose=Y  \
        --trace=N
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

