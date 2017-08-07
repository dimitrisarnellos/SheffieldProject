module load apps/python/anaconda3-4.2.0

for chr in $(seq 20 22); do
	awk 'substr($0,1,1) != "#"{print}' ../ref${chr}nomulti.vcf > nomultiBody${chr}
	cut -f1-459 nomultiBody${chr} > nomultiBody${chr}final
	awk 'substr($0,1,2) == "##"{print}' ../ref${chr}nomulti.vcf > header${chr}
	awk '$1 == "#CHROM"{print}' ../ref${chr}nomulti.vcf | cut -f1-459 > subheader${chr}
	cd ..
	bgzip ref${chr}nomulti.vcf
	tabix -p vcf ref${chr}nomulti.vcf.gz
	cd randomised
	bcftools view ../ref${chr}nomulti.vcf.gz -s panTro4,DenisovaPinky,AltaiNea -o threeancient${chr}.vcf
	bgzip threeancient${chr}.vcf
	tabix -p vcf threeancient${chr}.vcf.gz

	python /home/bo4da/Scripts/randFast.py nomultiBody${chr}final mem
	paste -d '' first9 c{0..449} > vcfBody${chr}
	rm c*
	rm first9 nomultiBody${chr}
	perl -pe 'chomp if eof' vcfBody${chr} > vcfBody${chr}chomped
	rm vcfBody${chr}
	cat header${chr} subheader${chr} vcfBody${chr}chomped > fullAllRandom${chr}.vcf
	rm header${chr} subheader${chr} vcfBody${chr}chomped
	bgzip fullAllRandom${chr}.vcf
	tabix -p vcf fullAllRandom${chr}.vcf.gz
	bcftools merge fullAllRandom${chr}.vcf.gz threeancient${chr}.vcf.gz -o allRandomFinal${chr}.vcf
	rm fullAllRandom${chr}.vcf.gz threeancient${chr}.vcf.gz
done
