mode=$1
org=$2
if [ org != "Altai" ] && [ org != "Denisova" ]; then
	echo "Must specify Altai or Denisova as second argument"
	exit
fi

for chr in $(seq 22); do
	grep 'Altai' chr${chr}.result.clst | grep -v Denis | grep -v panTro4 | python /home/bo4da/Scripts/emiResults.py afr $mode | python /home/bo4da/Scripts/emi2R.py > onlyafrforR${chr}corr
	grep 'Altai' chr${chr}.result.clst | grep -v Denis | grep -v panTro4 | python /home/bo4da/Scripts/emiResults.py nonafr $mode | python /home/bo4da/Scripts/emi2R.py > onlynonafrforR${chr}corr
	grep 'Altai' chr${chr}.result.clst | grep -v Denis | grep -v panTro4 | python /home/bo4da/Scripts/emiResults.py common | python /home/bo4da/Scripts/emi2R.py > comClustforR${chr}corr

	sort -k3,3 -k1,1n -k2,2n onlyafrforR${chr}corr | python /home/bo4da/Scripts/mergeEMIsegs.py > finafr${chr}
	sort -k3,3 -k1,1n -k2,2n onlynonafrforR${chr}corr | python /home/bo4da/Scripts/mergeEMIsegs.py > finonafr${chr}
	sort -k3,3 -k1,1n -k2,2n comClustforR${chr}corr | python /home/bo4da/Scripts/mergeEMIsegs.py > fincom${chr}

	grep -vwF -f onlyafrforR${chr}corr <(grep Altai chr${chr}.emiFinal | grep -v 'panTro4\|DenisovaPinky' | awk '$1 != "AltaiNea"{print $5"\t"$6"\t"$1}') | grep -f /fastdata/bo4da/Data/1000genomes/byPopulation/afr.list > onlyafrnoclust${chr}corr
	cat onlyafrnoclust${chr}corr finafr${chr} > correctonlyAfr${chr}corr
	grep -vwF -f onlynonafrforR${chr}corr <(grep Altai chr${chr}.emiFinal | grep -v 'panTro4\|DenisovaPinky' | awk '$1 != "AltaiNea"{print $5"\t"$6"\t"$1}') | grep -f /fastdata/bo4da/Data/1000genomes/byPopulation/eur.list > onlyeurnoclust${chr}corr
	grep -vwF -f onlynonafrforR${chr}corr <(grep Altai chr${chr}.emiFinal | grep -v 'panTro4\|DenisovaPinky' | awk '$1 != "AltaiNea"{print $5"\t"$6"\t"$1}') | grep -f /fastdata/bo4da/Data/1000genomes/byPopulation/eas.list > onlyeasnoclust${chr}corr
	cat onlyeurnoclust${chr}corr onlyeasnoclust${chr}corr > corrnonafrnoclust${chr}corr
	cat corrnonafrnoclust${chr}corr onlynonafrforR${chr}corr > correctonlyNonAfr${chr}corr

	cat correctonlyNonAfr${chr}corr correctonlyAfr${chr}corr > correctNonCommon${chr}corr

	rm onlyafrforR${chr}corr onlynonafrforR${chr}corr comClustforR${chr}corr finafr${chr} finonafr${chr} onlyafrnoclust${chr}corr correctonlyAfr${chr}corr onlyeurnoclust${chr}corr onlyeasnoclust${chr}corr corrnonafrnoclust${chr}corr correctonlyNonAfr${chr}corr
done

cat correctNonCommon*corr > segregatedSegsAllChroms${mode}
cat fincom* > Allfincom

rm correctNonCommon*corr
rm fincom*
