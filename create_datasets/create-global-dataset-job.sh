#!/bin/bash
set -euo pipefail

chr=$1
mode=$2
no_indivs=$3

if [ $mode = "vanilla"]; then
    ls CDX.list CEU.list CH* ESN.list FIN.list GBR.list GWD.list IBS.list JPT.list KHV.list LWK.list MSL.list TSI.list YRI.list | while read line; do head -n${no_indivs} $line; done > global30indivsperpop.list

    /home/bo4da/Programs/bin/bcftools view ../ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S global30indivsperpop.list > ${chr}.vcf

    /home/bo4da/Programs/bin/bgzip ${chr}.vcf
    /home/bo4da/Programs/bin/tabix -p vcf ${chr}.vcf.gz

    /home/bo4da/Programs/bin/bcftools isec -c all -p isec${chr} -n=2 ${chr}.vcf.gz /data/bo4da/Denisovan/DenChr${chr}Filt2nd.vcf.gz
else
    /home/bo4da/Programs/bin/bcftools isec -c all -p isec${chr} -n=2 ../ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz /data/bo4da/Denisovan/DenChr${chr}Filt2nd.vcf.gz
fi

for i in $(seq 0 1); do /home/bo4da/Programs/bin/bgzip isec${chr}/000${i}.vcf; done
for i in $(seq 0 1); do /home/bo4da/Programs/bin/tabix -p vcf isec${chr}/000${i}.vcf.gz; done
/home/bo4da/Programs/bin/bcftools merge isec${chr}/0000.vcf.gz isec${chr}/0001.vcf.gz -o merged${chr}.vcf

###
module load apps/vcftools/0.1.14
vcftools --vcf merged${chr}.vcf --non-ref-ac-any 1 --remove-indels --remove-filtered LowQual --max-missing 1 --recode --out submit${chr}
rm merged${chr}.vcf