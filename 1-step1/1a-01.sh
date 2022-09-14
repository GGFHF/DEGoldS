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
#READS_DIR: Reads directory
#CONDA_DIR: Conda directory
#FASTQC_ENV: FASTQC environment in Conda

#VARIABLES DEFINITION
WD=""

READS_DIR=""

CONDA_DIR=""
FASTQC_ENV=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-READS QUALITY ASSESSMENT
echo '**************************************************'
echo 'ASSESING READS QUALITY ...'

cd "$CONDA_DIR"
source activate "$FASTQC_ENV"
cd "$WD"

mkdir "$WD"/output

fastqc "$READS_DIR"/*fq.gz --outdir="$WD"/output --extract
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

