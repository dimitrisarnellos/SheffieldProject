#!/bin/bash

#$ -l h_rt=2:00:00
#$ -l rmem=12G
#$ -l mem=12G
#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/python/conda
source activate python3env
python /home/bo4da/Programs/PoMo/scripts/FastaToVCF.py  -r trCleanedHumRef.fa pt2__cs-hg19.fa chimp.vcf
