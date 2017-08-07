mode=$1
org=$2

if [ $org != "AltaiNea" ] && [ $org != "DenisovaPinky" ]; then
	echo "Must specify AltaiNea or DenisovaPinky as second argument"
	exit
fi

if [ $org = "AltaiNea" ]; then
	otherAncient=DenisovaPinky
else
	otherAncient=AltaiNea
fi

grep ${org} chr1.result.clst | grep -v $otherAncient | grep -v panTro4 | python /home/bo4da/Scripts/emiResults.py afr $mode | python /home/bo4da/Scripts/emi2R.py > onlyafrforR1corr
grep ${org} chr1.result.clst | grep -v $otherAncient | grep -v panTro4 | python /home/bo4da/Scripts/emiResults.py nonafr $mode | python /home/bo4da/Scripts/emi2R.py > onlynonafrforR1corr
grep ${org} chr1.result.clst | grep -v $otherAncient | grep -v panTro4 | python /home/bo4da/Scripts/emiResults.py common | python /home/bo4da/Scripts/emi2R.py > comClustforR1corr

sort -k3,3 -k1,1n -k2,2n onlyafrforR1corr | python /home/bo4da/Scripts/mergeEMIsegs.py > finafr1
sort -k3,3 -k1,1n -k2,2n onlynonafrforR1corr | python /home/bo4da/Scripts/mergeEMIsegs.py > finonafr1
sort -k3,3 -k1,1n -k2,2n comClustforR1corr | python /home/bo4da/Scripts/mergeEMIsegs.py > fincom1${org}

grep -vwF -f onlyafrforR1corr <(grep $org chr1.emiFinal | grep -v "panTro4\|${otherAncient}" | awk -v organism="$org" '$1 != organism{print $5"\t"$6"\t"$1}') | grep -f /data/bo4da/afr.list > onlyafrnoclust1corr
cat onlyafrnoclust1corr finafr1 > correctonlyAfr1corr
grep -vwF -f onlynonafrforR1corr <(grep $org chr1.emiFinal | grep -v "panTro4\|${otherAncient}" | awk -v organism="$org" '$1 != organism{print $5"\t"$6"\t"$1}') | grep -f /data/bo4da/eur.list > onlyeurnoclust1corr
grep -vwF -f onlynonafrforR1corr <(grep $org chr1.emiFinal | grep -v "panTro4\|${otherAncient}" | awk -v organism="$org" '$1 != organism{print $5"\t"$6"\t"$1}') | grep -f /data/bo4da/eas.list > onlyeasnoclust1corr
cat onlyeurnoclust1corr onlyeasnoclust1corr > corrnonafrnoclust1corr
cat corrnonafrnoclust1corr onlynonafrforR1corr > correctonlyNonAfr1corr

cat correctonlyNonAfr1corr correctonlyAfr1corr > correctNonCommon1corr

rm onlyafrforR1corr onlynonafrforR1corr comClustforR1corr finafr1 finonafr1 onlyafrnoclust1corr correctonlyAfr1corr onlyeurnoclust1corr onlyeasnoclust1corr corrnonafrnoclust1corr correctonlyNonAfr1corr


cat correctNonCommon*corr > segregatedSegsAllChroms${mode}${org}
cat fincom* > Allfincom${mode}${org}

rm correctNonCommon*corr
rm fincom*