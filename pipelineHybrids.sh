
VCFdir=/fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged
IBDdir=/fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged/rerunChr2/allibd
popDir=/fastdata/bo4da/Data/1000genomes/byPopulation

for chr in $(seq 12 22); do
	#all human sharing
	grep Denis ${IBDdir}/allref${chr}.ibd |
	grep -v Altai |
	grep -v panTro4 |
	sort -u -n -k6 -k7 >  denSegs${chr}.txt

	grep Denis ${IBDdir}/allref${chr}.ibd | grep Altai > neadensegs${chr}.txt

	sort -u -k6 -k7 -n neadensegs${chr}.txt |
	python /home/bo4da/Scripts/myIBDmerge.py > neadenmerged${chr}

	#africans
	grep Denis ${IBDdir}/allref${chr}.ibd |
	grep -v Altai |
	grep -v panTro4 |
	grep -f ${popDir}/afr.list |
	sort -u -n -k6 -k7 > afrDen${chr}.txt

	sort -u -k6 -k7 -n afrDen${chr}.txt |
	python /home/bo4da/Scripts/myHyAlgo.py neadenmerged${chr} |
	sort -u -k2 -k3 -n |
	python /home/bo4da/Scripts/myHyAlgoMerg2.py > afrdensegs${chr}

	sort -u -k6 -k7 -n denSegs${chr}.txt |
	python /home/bo4da/Scripts/myHyAlgo.py neadenmerged${chr} |
	sort -u -k2 -k3 -n | python /home/bo4da/Scripts/myHyAlgoMerg2.py |
	python /home/bo4da/Scripts/myHyAlgoMakeVCF2.py NA19031 afrdensegs${chr} ${VCFdir}/reffiltered${chr}.recode.vcf > afrhyb${chr}

	#asians
	grep Denis ${IBDdir}/allref${chr}.ibd |
	grep -v Altai |
	grep -v panTro4 |
	grep -f ${popDir}/eas.list |
	sort -u -n -k6 -k7 > easDen${chr}.txt

	sort -u -k6 -k7 -n easDen${chr}.txt |
	python /home/bo4da/Scripts/myHyAlgo.py neadenmerged${chr} |
	sort -u -k2 -k3 -n |
	python /home/bo4da/Scripts/myHyAlgoMerg2.py > easdensegs${chr}

	sort -u -k6 -k7 -n denSegs${chr}.txt |
	python /home/bo4da/Scripts/myHyAlgo.py neadenmerged${chr} |
	sort -u -k2 -k3 -n | python /home/bo4da/Scripts/myHyAlgoMerg2.py |
	python /home/bo4da/Scripts/myHyAlgoMakeVCF2.py HG01861 easdensegs${chr} ${VCFdir}/reffiltered${chr}.recode.vcf > asianhyb${chr}

	#europeans
	grep Denis ${IBDdir}/allref${chr}.ibd |
	grep -v Altai |
	grep -v panTro4 |
	grep -f ${popDir}/eur.list |
	sort -u -n -k6 -k7 > eurDen${chr}.txt

	sort -u -k6 -k7 -n eurDen${chr}.txt |
	python /home/bo4da/Scripts/myHyAlgo.py neadenmerged${chr} |
	sort -u -k2 -k3 -n |
	python /home/bo4da/Scripts/myHyAlgoMerg2.py > eurdensegs${chr}

	sort -u -k6 -k7 -n denSegs${chr}.txt |
	python /home/bo4da/Scripts/myHyAlgo.py neadenmerged${chr} |
	sort -u -k2 -k3 -n |
	python /home/bo4da/Scripts/myHyAlgoMerg2.py |
	python /home/bo4da/Scripts/myHyAlgoMakeVCF2.py NA20505 eurdensegs${chr} ${VCFdir}/reffiltered${chr}.recode.vcf > eurhyb${chr}
done
