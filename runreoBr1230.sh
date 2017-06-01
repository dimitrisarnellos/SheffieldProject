#!/bin/bash

#$ -l h_rt=88:00:00
#$ -pe openmp 4
#$ -l rmem=12G
#$ -l mem=12G
#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/binapps/java/1.8.0u112
export _JAVA_OPTIONS='-Xmx18G'
java -Xss5m -jar /home/bo4da/Programs/bin/b4.r1230.jar gt=$1 map=/home/bo4da/Analyses/BEAGLE/mapFiles/plink.chrX.GRCh37.map ibd=true burnin-its=0 gprobs=false phase-its=0 overlap=10000 ibdtrim=100 window=100000 impute=false out=$2
