#!/bin/bash

#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/gcc/5.2/vcftools/0.1.14
for i in $(seq 16 22); do vcftools --gzvcf ../Denisova/T_hg19_1000g.${i}.mod.vcf.gz --remove-indels --remove-filtered LowQual --max-missing 1 --recode --out DenChr${i}Filt; done
