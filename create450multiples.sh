for chr in $(seq 21); do
  mkdir ${chr}
  cd ${chr}
  for i in $(seq 450); do sed "s/NA19041/NA19041.${i}/g" ../one-indiv${chr}.vcf > one-indiv${chr}.${i}.vcf; done

  bcftools view -s DenisovaPinky,AltaiNea,panTro4 ../../global-random${chr}.vcf.gz -o ancients${chr}.vcf

  for i in $(seq 450); do bgzip one-indiv${chr}.${i}.vcf; done

  bgzip ancients${chr}.vcf

  for i in $(seq 450); do tabix -p vcf one-indiv${chr}.${i}.vcf.gz; done

  tabix -p vcf ancients${chr}.vcf.gz

  bcftools isec -c all -p onemultiplied${chr} -n=451 one-indiv${chr}.*.vcf.gz ancients${chr}.vcf.gz

  ls onemultiplied${chr}/*vcf | while read line; do bgzip $line; done

  ls onemultiplied${chr}/*vcf.gz | while read line; do tabix -p vcf $line; done

  mkdir all${chr}

  bcftools merge onemultiplied${chr}/*.vcf.gz -o all${chr}/allmerged${chr}.vcf


  rm *
  rm -r onemultiplied${chr}


  mkdir IBD
  cd IBD
  qsub /home/bo4da/Scripts/runBeagle2.sh /fastdata-sharc/bo4da/retest-random/one-indiv/${chr}/all${chr}/allmerged${chr}.vcf ${chr} all${chr}
  cd ../../
done
