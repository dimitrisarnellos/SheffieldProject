#!/bin/bash

#$ -l h_rt=48:00:00
#$ -pe openmp 4
#$ -l rmem=12G
#$ -l mem=12G
#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/binapps/java/1.8.0u112
export _JAVA_OPTIONS='-Xmx18G'
java -Xss5m -jar /home/bo4da/Programs/bin/beagle.21Jan17.6cc.jar gt=/fastdata/bo4da/Data/Merged/3chr22humannofilter/CHR22DenNeaHum.vcf ibd=true impute=false ibdcm=0.001 ibdtrim=2 out=chr22
