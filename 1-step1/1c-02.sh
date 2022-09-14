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
#NCPU: number of CPUs
#LINEAGE_DATASET: specify the name of the BUSCO lineage to be used (BUSCO MANUAL --lineage_dataset option)
#TRANSCRIPTOME_FILE_PATH: by length filtered transcriptome FASTA file path
#CONDA_DIR: Conda directory
#BUSCO_ENV: BUSCO environment in Conda

#VARIABLES DEFINITION
WD=""

NCPU=
LINEAGE_DATASET=""
TRANSCRIPTOME_FILE_PATH=""

CONDA_DIR=""
BUSCO_ENV=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- TRANSCRIPTOME COMPLETENESS ASSESMENT
echo '**************************************************'
echo 'ASESSING TRANSCRIPTOME COMPLETENESS ...'

cd "$CONDA_DIR"
source activate "$BUSCO_ENV"
cd "$WD"

busco \
	--cpu="$NCPU" \
	--lineage_dataset="$LINEAGE_DATASET" \
	--mode=tran \
	--evalue=1E-03 \
	--limit=3 \
	--in="$TRANSCRIPTOME_FILE_PATH" \
	--out=busco

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

