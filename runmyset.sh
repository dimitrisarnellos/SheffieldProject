#!/bin/bash

#$ -l h_rt=8:00:00
#$ -pe openmp 4
#$ -l rmem=12G
#$ -l mem=12G
#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/binapps/java/1.8.0u112
export _JAVA_OPTIONS='-Xmx18G'
java -Xss5m -jar /home/bo4da/Programs/bin/beagle.jar unphased=beagNewDen.chr-1.dat missing=0 fastibd=true out=2beag3NewDen
