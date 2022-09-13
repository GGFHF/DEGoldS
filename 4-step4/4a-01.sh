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
#PIPELINE_ANN_FILE: tested pipeline GTF/GFF file
#EDITED_GMAP_GFF_FILE: edited GMAP GFF output (unstranded_edited_alignment.gff in 1d-05)
#GFFCOMPARE_DIR: GffCompare directory

#VARIABLES DEFINITION
WD=""

PIPELINE_ANN_FILE=""
EDITED_GMAP_GFF_FILE=""

GFFCOMPARE_DIR=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- TRANSCRIPTS COORDINATES COMPARISON
echo '**************************************************'
echo 'COMPARING TRANSCRIPTS COORDINATES ...'

mkdir "$WD"/output

"$GFFCOMPARE_DIR"/trmap -o "$WD"/output/ref_pipeline.txt "$PIPELINE_ANN_FILE" "$EDITED_GMAP_GFF_FILE"
"$GFFCOMPARE_DIR"/trmap -o "$WD"/output/ref_transcriptome.txt "$EDITED_GMAP_GFF_FILE" "$PIPELINE_ANN_FILE"

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

