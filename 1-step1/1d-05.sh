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
#GMAP_GFF_FILE: GMAP GFF output (alignment.gff in 1d-03)

#VARIABLES DEFINITION
WD=""

GMAP_GFF_FILE=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- GFF MODIFICATION
echo '**************************************************'
echo 'MODIFYING GFF ...'

mkdir "$WD"/output

awk 'BEGIN{FS=OFS="	"} {gsub(/\+/,".",$7); print}' "$GMAP_GFF_FILE" | awk 'BEGIN{FS=OFS="	"} {gsub(/\-/,".",$7); print}' > "$WD"/output/unstranded_edited_alignment.gff

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'

