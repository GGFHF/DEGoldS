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
#TRANSCRIPTOME_FILE_PATH: by length filtered transcriptome FASTA file path
#CONDA_DIR: Conda directory
#QUAST_ENV: QUAST environment in Conda

#VARIABLES DEFINITION
WD=""

NCPU=
TRANSCRIPTOME_FILE_PATH=""

CONDADIR=""
QUAST_ENV=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- TRANSCRIPTOME ASSEMBLY ASSESMENT
echo '**************************************************'
echo 'ASESSING TRANSCRIPTOME ASSEMBLY ...'

mkdir "$WD"/output

cd "$CONDADIR"
source activate "$QUAST_ENV"
cd "$WD"

quast.py --threads "$NCPU" --output-dir "$WD"/output "$TRANSCRIPTOME_FILE_PATH"
if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

