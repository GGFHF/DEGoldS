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
#TRANSCRIPTOME_INDEX_DIR: transcriptome RSEM index directory
#TRANSCRIPTOME_INDEX_NAME: transcriptome RSEM index name
#LEARN_DIR:  "02-model_learning/output/" directory from script 2a-01
#EDITED_SAMPLES_LEARN_DIR: directory with generated "isoforms.results" in script 2b-C03 (Sim1) or 2b-D11 (Sim2)
#READSNUMBER: number of reads to be simulated
#REPNUMBER: number of replicates to be simulated for each input "isoforms.results" file

#VARIABLES DEFINITION
WD=""

TRANSCRIPTOME_INDEX_DIR=""
TRANSCRIPTOME_INDEX_NAME=""
LEARN_DIR=""
EDITED_SAMPLES_LEARN_DIR=""
READSNUMBER=
REPNUMBER=

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1- SEQUENCING DATA SIMULATION
echo '**************************************************'
echo 'SIMULATING SEQUENCING DATA ...'

mkdir "$WD"/output

ls -d "$LEARN_DIR"/*.stat > "$LEARN_DIR"/stats_dir.txt

while read DIR_STATS; do

	for i in $( eval echo {1..$REPNUMBER} )
	do

	SAMPLENAME2=`echo $DIR_STATS | sed 's/.stat//g' | sed "s,$LEARN_DIR,,g" | sed 's,/,,g'`
	ESTMODELFILE=`echo $DIR_STATS | sed "s,.stat,.stat/$SAMPLENAME2.model,g"`
	LEARN_FILE=`echo $DIR_STATS | sed "s,$LEARN_DIR,$EDITED_SAMPLES_LEARN_DIR,g" | sed "s,$SAMPLENAME2,edited_$SAMPLENAME2,g" | sed 's/.stat/.isoforms.results/g'`
	THETA0FILE=`echo $DIR_STATS | sed "s,.stat,.stat/$SAMPLENAME2.theta,g"`
	THETA0=`cut -d " " -f 1 $THETA0FILE | tail -n 1`

	rsem-simulate-reads "$TRANSCRIPTOME_INDEX_DIR"/"$TRANSCRIPTOME_INDEX_NAME" "$ESTMODELFILE" "$LEARN_FILE" "$THETA0" "$READSNUMBER" "$WD"/output/"$SAMPLENAME2"_"$i"
	echo "$THETA0" > "$WD"/output/"$SAMPLENAME2"_theta.txt

	done

done < "$LEARN_DIR"/stats_dir.txt

ls "$WD"/output/*.fq > "$WD"/output/reads.txt

while read READS; do

	gzip -9 "$READS"

done < "$WD"/output/reads.txt

rm "$WD"/output/reads.txt
rm "$LEARN_DIR"/stats_dir.txt

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
