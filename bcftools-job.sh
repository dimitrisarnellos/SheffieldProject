#!/bin/bash

chr=$1
list_name=$2
/home/bo4da/Programs/bin/bcftools view /data/bo4da/Merged/reffiltered${chr}.recode.vcf.gz -S $list_name -o ${chr}.vcf
