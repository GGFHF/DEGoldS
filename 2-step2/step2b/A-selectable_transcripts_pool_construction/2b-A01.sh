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
#EDITED_GMAP_GFF_FILE: edited GMAP GFF output (unstranded_edited_alignment.gff in 1d-05)
#GFFCOMPARE_DIR: GffCompare directory

#VARIABLES DEFINITION
WD=""

EDITED_GMAP_GFF_FILE=""

GFFCOMPARE_DIR=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- GFF ANALYSIS
echo '**************************************************'
echo 'ANALYSING GFF ...'

mkdir "$WD"/output

"$GFFCOMPARE_DIR"/gffcompare "$EDITED_GMAP_GFF_FILE" -o "$WD"/output/transcriptome

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

