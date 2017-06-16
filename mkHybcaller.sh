window=$1
percentage=$2
african=$3
chimpanzee=$4
chimpName=`echo $chimpanzee | cut -d "-" -f 2`

declare -a repeatTime=("first" "second" "third" "fourth" "fifth");
sourceDir=/fastdata/bo4da/Data/postTests/datasetsCorrect/hybridConstruction/hybrids/hybridpopstest/autoDiff/source
outDir=/fastdata/bo4da/Data/postTests/datasetsCorrect/hybridConstruction/hybrids/hybridpopstest/autoDiff/out
base=${african}_${chimpanzee}

mkdir ${outDir}/${african}_${chimpName}
for count in $(seq 0 4); do
	mkdir ${outDir}/${african}_${chimpName}/${repeatTime[${count}]}
	for chr in $(seq 1); do
		hybridSource=${chr}_${base}
		bcftools view -s ${african},${chimpanzee} /fastdata/bo4da/Data/postTests/datasetsCorrect/manymerged/manyfiltered${chr}.recode.vcf -o ${sourceDir}/${hybridSource}
		awk 'BEGIN{start=0;end=0}$1 == "#CHROM"{getline;start=$2}END{end=$2;print end-start"\t"start"\t"end}' ${sourceDir}/${hybridSource} > hybridLengths.temp
		python /home/bo4da/Scripts/makeHybridv3.0.py hybridLengths.temp ${sourceDir}/${hybridSource} $window 0.${percentage} > ${outDir}/${african}_${chimpName}/${repeatTime[${count}]}/hybridChr${chr}.vcf
	done
	rm hybridLengths.temp
done
