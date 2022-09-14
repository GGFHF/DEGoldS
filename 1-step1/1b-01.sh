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
#READS_DIR: Reads directory
#MEMORY: maximum number of memory to use (in GB)
#LEFT_SUFFIX: left reads file suffix (including extension)
#RIGHT_SUFFIX: right reads file suffix (including extension)
#CONDA_DIR: Conda directory
#TRINITY_ENV: Trinity environment in Conda

#VARIABLES DEFINITION
WD=""

NCPU=
MEMORY=
READS_DIR=""
LEFT_SUFFIX=""
RIGHT_SUFFIX=""

CONDA_DIR=""
TRINITY_ENV=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-LIBRARIES ASSEMBLY WITH TRINITY
echo '**************************************************'
echo 'ASSEMBLING LIBRARIES WITH TRINITY ...'

cd "$CONDA_DIR"
source activate "$TRINITY_ENV"
cd "$WD"

mkdir "$WD"/trinity_output

LEFT_READS=`ls "$READS_DIR"/*"$LEFT_SUFFIX" | tr '\n' ',' | sed 's/.$//g'`
RIGHT_READS=`ls "$READS_DIR"/*"$RIGHT_SUFFIX" | tr '\n' ',' | sed 's/.$//g'`

Trinity \
     --no_version_check \
     --CPU "$NCPU" \
     --max_memory "$MEMORY"G \
     --bflyHeapSpaceMax 4G \
     --bflyCalculateCPU \
     --seqType fq \
     --left "$LEFT_READS" \
     --right "$RIGHT_READS" \
     --normalize_by_read_set \
     --output "$WD"/trinity_output

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
