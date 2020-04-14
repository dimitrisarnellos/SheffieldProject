#!/bin/bash

chr=$1
list_name=$2

/home/bo4da/Programs/bin/bcftools view ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S $list_name -o ${chr}.vcf
/home/bo4da/Programs/bin/bgzip ${chr}.vcf
/home/bo4da/Programs/bin/tabix -p vcf ${chr}.vcf.gz
