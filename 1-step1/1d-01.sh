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
#GMAP_INDEX_NAME: reference genome GMAP index name
#GENOME_FILE_PATH: gziped reference genome FASTA file path
#CONDA_DIR: Conda directory
#GMAP_ENV: GMAP environment in Conda

#VARIABLES DEFINITION
WD=""

GMAP_INDEX_NAME=""
GENOME_FILE_PATH=""

CONDADIR=""
GMAP_ENV=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-GMAP INDEX BUILDING
echo '**************************************************'
echo 'INDEXING GENOME WITH GMAP ...'

mkdir "$WD"/output

cd "$CONDADIR"
source activate "$GMAP_ENV"
cd "$WD"

gmap_build -g -D "$WD"/output -d "$GMAP_INDEX_NAME" "$GENOME_FILE_PATH"

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

