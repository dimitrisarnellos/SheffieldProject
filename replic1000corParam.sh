
#!/bin/bash

#$ -l h_rt=4:00:00
#$ -pe openmp 4
#$ -l rmem=12G
#$ -l mem=12G
#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/binapps/java/1.8.0u112
export _JAVA_OPTIONS='-Xmx18G'
java -Xss5m -jar /home/bo4da/Programs/bin/beagle.21Jan17.6cc.jar gt=/fastdata/bo4da/Data/1000genomes/v1.0ChrX.vcf.gz map=/home/bo4da/Analyses/BEAGLE/mapFiles/plink.chrX.GRCh37.map ibd=true niterations=0 overlap=10000 ibdtrim=100 window=100000 impute=false out=chrX
