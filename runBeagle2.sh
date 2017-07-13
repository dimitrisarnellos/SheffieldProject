#!/bin/bash

#$ -pe openmp 12
#$ -m ea
#$ -M bo4da@sheffield.ac.uk

export OMP_NUM_THREADS=12
module load apps/binapps/java/1.8.0u112
export _JAVA_OPTIONS='-Xmx18G'
java -Xss5m -jar /home/bo4da/Programs/bin/beagle.21Jan17.6cc.jar gt=$1 map=/home/bo4da/Analyses/BEAGLE/mapFiles/plink.chr${2}.GRCh37.map ibd=true impute=false ibdcm=0.001 niterations=0 ibdtrim=0 nthreads=12 out=$3
