#!/bin/bash
set -euxo pipefail

chr=$1
list_name=$2

zgrep "^[^#]" /data/bo4da/Merged/reffiltered${chr}.recode.vcf.gz | awk '{print $1"\t"$2}' > positions${chr}.txt
/home/bo4da/Programs/bin/bcftools view ../ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S <(cat $list_name | sed '$d') -R positions${chr}.txt > ${chr}.vcf
/home/bo4da/Programs/bin/bgzip ${chr}.vcf
/home/bo4da/Programs/bin/tabix -p vcf ${chr}.vcf.gz

/home/bo4da/Programs/bin/bcftools isec -c all -p isec${chr} -n=2 ${chr}.vcf.gz /data/bo4da/Denisovan/DenChr${chr}Filt2nd.vcf.gz
for i in $(seq 0 1); do /home/bo4da/Programs/bin/bgzip isec${chr}/000${i}.vcf; done
for i in $(seq 0 1); do /home/bo4da/Programs/bin/tabix -p vcf isec${chr}/000${i}.vcf.gz; done
/home/bo4da/Programs/bin/bcftools merge isec${chr}/0000.vcf.gz isec${chr}/0001.vcf.gz -o merged${chr}.vcf

###
module load apps/vcftools/0.1.14
vcftools --vcf merged${chr}.vcf --remove-indels --non-ref-ac-any 1 --remove-filtered LowQual --max-missing 1 --recode --out submit${chr}