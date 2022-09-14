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
#SAMPLE_LEARN_FILE_PATH: one of the ".isoform.result" files file path in 2a-01
#LOCI_FILE_PATH: "trancriptome.loci" file from script 2b-A01
#PATH1_SEQS_IDS_FILE_PATH: "assembly-ids-1path.txt" from script 1d-04

#VARIABLES DEFINITION
WD=""

SAMPLE_LEARN_FILE_PATH=""
LOCI_FILE_PATH=""
PATH1_SEQS_IDS_FILE_PATH=""

#CHANGE INTO WD AND LOG GENERATION
cd "$WD"

touch file.log
exec 1> >(tee -a file.log) 2>&1

#1-CANDIDATE UNIQUE LOCUS-ISOFORM SEQS EXTRACTION
echo '**************************************************'
echo 'EXTRACTING CANDIDATE UNIQUE LOCUS-ISOFORM SEQS ...'

mkdir "$WD"/output

cut -d "	" -f 1 "$SAMPLE_LEARN_FILE_PATH" | tail -n +2 > "$WD"/output/01-all_seqs_IDs.txt
cut -d " " -f 1 "$PATH1_SEQS_IDS_FILE_PATH" > "$WD"/output/02-path1_seqs_IDs.txt
grep -Fw -f "$WD"/output/02-path1_seqs_IDs.txt "$WD"/output/01-all_seqs_IDs.txt > "$WD"/output/03-usable_path1_seqs_IDs.txt
grep -v "," "$LOCI_FILE_PATH" > "$WD"/output/04-unique_seqs_loci.txt
grep -Fw -f "$WD"/output/01-all_seqs_IDs.txt "$WD"/output/04-unique_seqs_loci.txt > "$WD"/output/05-candidate_unique_seqs_loci.txt
cut -d "	" -f 4 "$WD"/output/05-candidate_unique_seqs_loci.txt | sed 's/.mrna1//g' > "$WD"/output/06-candidate_unique_seqs_IDs.txt
grep -Fw -f "$WD"/output/03-usable_path1_seqs_IDs.txt "$WD"/output/04-unique_seqs_loci.txt > "$WD"/output/07-path1_candidate_unique_seqs_loci.txt
cut -d "	" -f 4 "$WD"/output/07-path1_candidate_unique_seqs_loci.txt | sed 's/.mrna1//g' > "$WD"/output/08-path1_candidate_unique_seqs_IDs.txt

sed 's/_i.*//g' "$WD"/output/01-all_seqs_IDs.txt | sort | uniq -u > "$WD"/output/09-unique-plus_genes.txt
grep -f "$WD"/output/09-unique-plus_genes.txt "$WD"/output/06-candidate_unique_seqs_IDs.txt > "$WD"/output/10-candidate_unique-plus_seqs.txt
grep -f "$WD"/output/09-unique-plus_genes.txt "$WD"/output/08-path1_candidate_unique_seqs_IDs.txt > "$WD"/output/11-path1_candidate_unique-plus_seqs.txt

if [ $? -ne 0 ]; then echo 'Script ended with errors.'; exit 1; fi

#END
echo '**************************************************'
