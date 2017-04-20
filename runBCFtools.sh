#!/bin/bash

#$ -m ea
#$ -M bo4da@sheffield.ac.uk

for i in $(seq 9 22); do bcftools annotate -x ^FMT/GT NeaChr${i}Filt.recode.vcf.gz -o NeaChr${i}Filt2nd.vcf; done
