### Downloading data
```bash
wget http://bochet.gcc.biostat.washington.edu/beagle/genetic_maps/plink.GRCh37.map.zip
unzip plink.GRCh37.map.zip
```

### Downloading Denisovan
```bash
for i in $(seq 22); do wget http://cdna.eva.mpg.de/denisova/VCF/hg19_1000g/T_hg19_1000g.${i}.mod.vcf.gz; done
for i in $(seq 22); do wget http://cdna.eva.mpg.de/denisova/VCF/hg19_1000g/T_hg19_1000g.${i}.mod.vcf.gz.tbi; done
```

### Downloading Neandertal
```bash
for i in $(seq 22); do wget http://cdna.eva.mpg.de/neandertal/altai/AltaiNeandertal/VCF/AltaiNea.hg19_1000g.${i}.mod.vcf.gz; done
```

### Downloading human
```bash
for i in $(seq 22); do wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz; done
for i in $(seq 22); do wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr${i}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz.tbi; done
```


### creating list of IDs for populations and superpopulations
```bash
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel
awk '$3=="AFR"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > afr.list
awk '$3=="EUR"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > eur.list
awk '$3=="EAS"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > eas.list
awk '$3=="AMR"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > amr.list
awk '$3=="SAS"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > sas.list

awk '$2=="CHB"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > CHB.list
awk '$2=="JPT"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > JPT.list
awk '$2=="CHS"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > CHS.list
awk '$2=="CDX"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > CDX.list
awk '$2=="KHV"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > KHV.list
awk '$2=="CEU"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > CEU.list
awk '$2=="TSI"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > TSI.list
awk '$2=="FIN"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > FIN.list
awk '$2=="GBR"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > GBR.list
awk '$2=="IBS"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > IBS.list
awk '$2=="YRI"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > YRI.list
awk '$2=="LWK"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > LWK.list
awk '$2=="GWD"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > GWD.list
awk '$2=="MSL"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > MSL.list
awk '$2=="ESN"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > ESN.list
awk '$2=="ASW"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > ASW.list
awk '$2=="ACB"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > ACB.list
awk '$2=="MXL"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > MXL.list
awk '$2=="PUR"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > PUR.list
awk '$2=="CLM"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > CLM.list
awk '$2=="PEL"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > PEL.list
awk '$2=="GIH"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > GIH.list
awk '$2=="PJL"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > PJL.list
awk '$2=="BEB"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > BEB.list
awk '$2=="STU"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > STU.list
awk '$2=="ITU"{print $1}' integrated_call_samples_v3.20130502.ALL.panel > ITU.list
```

# CREATE MAIN DATASET, RUN BEAGLE REFINED IBD
### 30 individuals from 15 human populations
```bash
ls CDX.list CEU.list CH* ESN.list FIN.list GBR.list GWD.list IBS.list JPT.list KHV.list LWK.list MSL.list TSI.list YRI.list | while read line; do head -n30 $line; done > 30noAdmixedNew.list

for chr in $(seq 22); do bcftools view /fastdata/bo4da/Data/1000genomes/ALL.chr${chr}.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S /fastdata/bo4da/Data/1000genomes/byPopulation/30noAdmixedNew.list -o 1000gRedNoAdmChr${chr}.vcf; done
for chr in $(seq 22); do bgzip 1000gRedNoAdmChr${chr}.vcf; done
for chr in $(seq 22); do tabix -p vcf 1000gRedNoAdmChr${chr}.vcf.gz; done
```

### creating the reference chimp files
```bash
for chr in $(seq 22); do grep -wF -A1 "hg19.chr${chr}" /fastdata/bo4da/Data/Chimpanzee/maffilterFiles/humanChimp.maf > mafChr${chr}.maf; done
for chr in $(seq 22); do (python /home/bo4da/Scripts/maf2vcf.py mafChr${chr}.maf > chimpRaw${chr}.vcf &); done
for chr in $(seq 22); do (perl -pe 'chomp if eof' chimpRaw${chr}.vcf > chomped${chr}.vcf; rm chimpRaw${chr}.vcf &); done
echo "##fileformat=VCFv4.2" >> headerNew.txt
echo "##fileDate=20170601" >> headerNew.txt
echo '##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">' >> headerNew.txt
for chr in $(seq 22); do ((cat headerNew.txt chomped${chr}.vcf > chimpChr${chr}.vcf; rm chomped${chr}.vcf) &); done
for chr in $(seq 22); do (bgzip chimpChr${chr}.vcf &); done
for chr in $(seq 22); do  (tabix -p vcf chimpChr${chr}.vcf.gz &); done
```

### intersecting and merging the refchimp
```bash
for chr in $(seq 22); do (bcftools isec -c all -p refnewisec${chr} -n=4 1000gRedNoAdmChr${chr}.vcf.gz /fastdata/bo4da/Data/Merged/DenChr${chr}Filt2nd.vcf.gz /fastdata/bo4da/Data/Merged/NeaChr${chr}Filt2nd.vcf.gz /fastdata/bo4da/Data/Chimpanzee/May/chroms/chimpChr${chr}.vcf.gz &); if [ $(($chr % 12)) = "0" ]; then wait; fi; done
for chr in $(seq 22); do (for i in $(seq 0 3); do bgzip refnewisec${chr}/000${i}.vcf; done &); done
for chr in $(seq 22); do (for i in $(seq 0 3); do tabix -p vcf refnewisec${chr}/000${i}.vcf.gz; done &); done
for chr in $(seq 22); do (bcftools merge refnewisec${chr}/0000.vcf.gz refnewisec${chr}/0001.vcf.gz refnewisec${chr}/0002.vcf.gz refnewisec${chr}/0003.vcf.gz -o refmerged/newrefmer${chr}.vcf &); done
for chr in $(seq 22); do (vcftools --vcf refmerged/newrefmer${chr}.vcf --remove-indels --non-ref-ac-any 1 --remove-filtered LowQual --max-missing 1 --recode --out refmerged/reffiltered${chr} &); done
rm newrefmer*
```

### run refined IBD
```bash
for chr in $(seq 22); do qsub /home/bo4da/Scripts/runBeagle2.sh /fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged/reffiltered${chr}.recode.vcf ${chr} allref${chr}; done
cat *ibd > ALLREFIBD
cat ALLREFIBD | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > allrefibdmerg
```

# PCA
```bash
bcftools concat reffiltered*.recode.vcf -o refALL.vcf
plink --vcf refALL.vcf --make-bed --out refall

echo -e "panTro4\tpanTro4" > nochimp.txt
plink --bfile refall --remove nochimp.txt --make-bed --out allNoChimp
plink --bfile allNoChimp --pca --out noChPCA
```

# ADMIXTURE
### for Denisovan (remove Neandertal)
```bash
cat manyall.fam | while read line; do ind=$(echo $line | cut -d " " -f1); grep -wF $ind /fastdata/bo4da/Data/1000genomes/byPopulation/integrated_call_samples_v3.20130502.ALL.panel | awk '{print $3}'; done > manyall.pop
echo -e "\nNeandertal" >> manyall.pop
for i in $(seq 70); do echo "Chimpanzee" >> manyall.pop; done
echo -e "AltaiNea\tAltaiNea" > removeNea.txt
plink --bfile manyall --remove removeNea.txt --make-bed --out manyallnoNea
grep -v Neandertal manyall.pop > manyallnoNea.pop
admixture --supervised manyallnoNea.bed 4 -j12
```


### for Neandertal (remove Denisovan)
```bash
echo -e "DenisovaPinky\tDenisovaPinky" > removeDen.txt
plink --bfile manyall --remove removeDen.txt --make-bed --out manyallnoDen
cat manyall.fam | while read line; do ind=$(echo $line | cut -d " " -f1); grep -wF $ind /fastdata/bo4da/Data/1000genomes/byPopulation/integrated_call_samples_v3.20130502.ALL.panel | awk '{print $3}'; done > manyallnoDen.pop
echo -e "" >> manyallnoDen.pop
for i in $(seq 70); do echo "Chimpanzee" >> manyallnoDen.pop; done
admixture --supervised manyallnoDen.bed 4 -j12
```

# PLINK --genome for IBS distance calculation
```bash
plink --vcf withoutChimp/Chr1noChimp.vcf --make-bed --out inplink
plink --vcf withoutChimp/Chr1noChimp.vcf --recode --out pedinplink

grep -wF -f <(awk '{print $4}' plplink.map) pedinplink.map | awk '{print $2}' > sharedsnps.txt
plink --vcf withoutChimp/Chr1noChimp.vcf --extract sharedsnps.txt --make-bed --out smallerhumneaden
plink --bfile smallerhumneaden --genome --out smibs
```


# RANDOMISING THE DATASET AND DRAWING THE CUTOFF
### creating dataset by removing multiallelic sites
```bash
for chr in $(seq 22); do bcftools view /data/bo4da/Merged/reffiltered${chr}.recode.vcf.gz --max-alleles 2 -o ref${chr}nomulti.vcf; done
cd randomised
```

### This pipeline creates the randomised human individuals
```bash
bash /home/bo4da/Scripts/pipeRandom.sh
```


### in beagleNormal
```bash
for chr in $(seq 22); do qsub -l h_rt=24:00:00 /home/bo4da/Scripts/runBeagle3.sh ../ref${chr}nomulti.vcf.gz ${chr} normalnomulti${chr}; done
at *ibd > allNormal.ibd
cat allNormal.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > allNormMergsubset

for chr in $(seq 22); do qsub -l h_rt=24:00:00 /home/bo4da/Scripts/runBeagle3.sh ../randomised/allRandomFinal${chr}.vcf ${chr} randomised${chr}; done
at *ibd > allRandom.ibd
cat allRandom.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > allRandMergedsubset
```

### in R
```r
norm <- superpopulations("allNormMergsubset")
ran <- superpopulations("allRandMergedsubset")
normcut <- norm
normcut$ibdden <- norm$ibdden[norm$ibdden$Subpopulation == "LWK" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "LWK",]$Length, 0.95),]
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "MSL" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "MSL",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "ESN" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "ESN",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "GWD" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "GWD",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "YRI" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "YRI",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "CDX" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "CDX",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "CEU" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "CEU",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "CHB" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "CHB",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "CHS" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "CHS",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "FIN" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "FIN",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "GBR" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "GBR",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "IBS" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "IBS",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "TSI" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "TSI",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "JPT" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "JPT",]$Length, 0.95),])
normcut$ibdden <- rbind(normcut$ibdden, norm$ibdden[norm$ibdden$Subpopulation == "KHV" & norm$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "KHV",]$Length, 0.95),])

normcut$ibdnea <- norm$ibdnea[norm$ibdnea$Subpopulation == "LWK" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "LWK",]$Length, 0.95),]
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "MSL" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "MSL",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "ESN" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "ESN",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "GWD" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "GWD",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "YRI" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "YRI",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "CDX" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "CDX",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "CEU" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "CEU",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "CHB" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "CHB",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "CHS" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "CHS",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "FIN" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "FIN",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "GBR" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "GBR",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "IBS" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "IBS",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "TSI" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "TSI",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "JPT" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "JPT",]$Length, 0.95),])
normcut$ibdnea <- rbind(normcut$ibdnea, norm$ibdnea[norm$ibdnea$Subpopulation == "KHV" & norm$ibdnea$Length > quantile(ran$ibdnea[ran$ibdnea$Subpopulation == "KHV",]$Length, 0.95),])
```


# RARE VARIANTS (FIN JPT YRI)
```bash
pop_dir=/fastdata/bo4da/Data/1000genomes/byPopulation/
ls ${pop_dir}FIN.list ${pop_dir}JPT.list ${pop_dir}YRI.list | while read line; do head -n30 $line; done > finjpnyri.list
bcftools view ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S finjpnyri.list -o 1000gRedNoAdmChr.vcf
bgzip 1000gRedNoAdmChr.vcf
tabix -p vcf 1000gRedNoAdmChr.vcf.gz
bcftools isec -c all -p lastisec -n=4 1000gRedNoAdmChr.vcf.gz /data/bo4da/Denisovan/DenChr1Filt2nd.vcf.gz /data/bo4da/Neandertal/NeaChr1Filt2nd.vcf.gz /fastdata/bo4da/Data/Chimpanzee/May/chroms/chimpChr1.vcf.gz
for i in $(seq 0 3); do bgzip lastisec/000${i}.vcf; done
for i in $(seq 0 3); do tabix -p vcf lastisec/000${i}.vcf.gz; done
bcftools merge lastisec/0000.vcf.gz lastisec/0001.vcf.gz lastisec/0002.vcf.gz lastisec/0003.vcf.gz -o lastisec/lastmerged.vcf
vcftools --vcf lastisec/lastmerged.vcf --remove-indels --non-ref-ac-any 1 --remove-filtered LowQual --max-missing 1 --recode --out lastfiltered

qsub -l h_rt=05:00:00 /home/bo4da/Scripts/runBeagle2.sh /fastdata/bo4da/Data/FinJpnYriIBD/lastfiltered.recode.vcf 1 ibd3pops

cat ibd3pops.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > last3Merg
```
### testing maf > 0.01
```bash
vcftools --vcf lastfiltered.recode.vcf --recode --maf 0.01 --out last3maf
qsub -l h_rt=02:00:00 /home/bo4da/Scripts/runBeagle3.sh last3maf.recode.vcf 1 ibd3maf
cat ibd3maf.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > last3mafMerg
### testing maf > 0.05
vcftools --vcf lastfiltered.recode.vcf --recode --maf 0.05 --out last3maf5
qsub -l h_rt=02:00:00 /home/bo4da/Scripts/runBeagle3.sh last3maf5.recode.vcf 1 ibd3maf5
cat ibd3maf5.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > last3mafMerg5
```

### IBD Fin Jap and randomYRI
```bash
cp /fastdata/bo4da/Data/DOGE/randomLWK/ref1nomulti.vcf.gz
bgzip -d ref1nomulti.vcf.gz
```
##### changed some hardcoded indexes so instead of LWK it randomises YRI
```bash
python /home/bo4da/Scripts/randomiseExistingLWK.py ref1nomulti.vcf > randomisedYRIfinal.vcf
bgzip randomisedYRIfinal.vcf
tabix -p vcf randomisedYRIfinal.vcf.gz

pop_dir=/fastdata/bo4da/Data/1000genomes/byPopulation/
ls ${pop_dir}FIN.list ${pop_dir}JPT.list | while read line; do head -n30 $line; done > finjpn.list
bcftools view ../ALL.chr1.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz -S finjpn.list -o 1000gfinjpn.vcf
bgzip 1000gfinjpn.vcf
tabix -p vcf 1000gfinjpn.vcf.gz
bcftools isec -c all -p lastisec -n=5 1000gfinjpn.vcf.gz randomisedYRIfinal.vcf.gz /data/bo4da/Denisovan/DenChr1Filt2nd.vcf.gz /data/bo4da/Neandertal/NeaChr1Filt2nd.vcf.gz /fastdata/bo4da/Data/Chimpanzee/May/chroms/chimpChr1.vcf.gz
for i in $(seq 0 4); do bgzip lastisec/000${i}.vcf; done
for i in $(seq 0 4); do tabix -p vcf lastisec/000${i}.vcf.gz; done
bcftools merge lastisec/0000.vcf.gz lastisec/0001.vcf.gz lastisec/0002.vcf.gz lastisec/0003.vcf.gz lastisec/0004.vcf.gz -o lastisec/lastmerged.vcf
vcftools --vcf lastisec/lastmerged.vcf --remove-indels --non-ref-ac-any 1 --remove-filtered LowQual --max-missing 1 --recode --out lastfiltered

qsub -l h_rt=05:00:00 /home/bo4da/Scripts/runBeagle2.sh lastfiltered.recode.vcf 1 ibdrandYRI

cat ibdrandYRI.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > randYRImerg
```

### R
```r
threepops <- superpopulations("last3Merg")
threecut <- threepops$ibdden[threepops$ibdden$Length > quantile(ran$ibdden$Length, 0.95),]
DrawAncientsRef(threecut)

threecut <- threepops
threecut$ibdden <- threepops$ibdden[threepops$ibdden$Length > quantile(ran$ibdden[ran$ibdden$Subpopulation == "YRI",]$Length, 0.95),]
DrawAncientsRef(threecut)

randYRI <- superpopulations("randYRImerg")
randYRI$ibdden <- threepops$ibdden[threepops$ibdden$Length > quantile(ran$ibdden[randYRI$ibdden$Subpopulation == "RYRI",]$Length, 0.95),]
DrawAncientsRef(randYRI)

threerealcut <- threepops
threerealcut$ibdden <- threepops$ibdden[threepops$ibdden$Length > quantile(randYRI$ibdden[randYRI$ibdden$Subpopulation == "RYRI",]$Length, 0.95),]
DrawAncientsRef(threerealcut)
```


# MARKER DENSITY
### Create the dataset
```bash
wget ftp://ftp.cnag.cat/Chimpanzee/hg19/Freebayes_hg19_Concat_1Mb_Clean_Callable_HWE.vcf.gz
wget ftp://ftp.cnag.cat/Chimpanzee/hg19/Freebayes_hg19_Concat_1Mb_Clean_Callable_HWE.vcf.gz.tbi
for i in $(seq 22); do tabix -h Freebayes_hg19_Concat_1Mb_Clean_Callable_HWE.vcf.gz chr${i} > chimp${i}.vcf; done


for i in $(seq 22); do tabix -h Freebayes_hg19_Concat_1Mb_Clean_Callable_HWE.vcf.gz chr${i} > allIndivs/chimp${i}.vcf; done
for i in $(seq 22); do vcftools --vcf allIndivs/chimp${i}.vcf --remove-indels --remove-filtered LowQual --max-missing 1 --recode --out allIndivs/preparedchimp${i}; done
for i in $(seq 22); do bgzip allIndivs/preparedchimp${i}.recode.vcf; done
for i in $(seq 22); do tabix -p vcf allIndivs/preparedchimp${i}.recode.vcf.gz; done
for i in $(seq 22); do bcftools annotate -x ^FMT/GT allIndivs/preparedchimp${i}.recode.vcf.gz -o allIndivs/filtchimp${i}.vcf; done
```

### fix the #CHROM from e.g chr1 to 1 otherwise bcftools won't find the intersection
```bash
for i in $(seq 22); do awk -v chr="$i" 'BEGIN{OFS="\t"}{if (substr($0,1,1) != "#"){$1 = chr;print $0}else{print}}' allIndivs/filtchimp${i}.vcf > allIndivs/fixedchimp${i}.vcf; done


for i in $(seq 22); do bgzip allIndivs/fixedchimp${i}.vcf; done
for i in $(seq 22); do tabix -p vcf allIndivs/fixedchimp${i}.vcf.gz; done
```

### merge with humans and ancient hominins
```bash
for chr in $(seq 22); do (bcftools isec -c all -p manynewisec${chr} -n=4 1000gRedNoAdmChr${chr}.vcf.gz /fastdata/bo4da/Data/Merged/DenChr${chr}Filt2nd.vcf.gz /fastdata/bo4da/Data/Merged/NeaChr${chr}Filt2nd.vcf.gz /fastdata/bo4da/Data/Chimpanzee/cnagPaper/allIndivs/fixedchimp${chr}.vcf.gz &); done
for chr in $(seq 22); do (for i in $(seq 0 3); do bgzip manynewisec${chr}/000${i}.vcf; done &); done
for chr in $(seq 22); do (for i in $(seq 0 3); do tabix -p vcf manynewisec${chr}/000${i}.vcf.gz; done &); done
for chr in $(seq 22); do (bcftools merge manynewisec${chr}/0000.vcf.gz manynewisec${chr}/0001.vcf.gz manynewisec${chr}/0002.vcf.gz manynewisec${chr}/0003.vcf.gz -o manymerged/newmanymer${chr}.vcf &); done
for chr in $(seq 22); do (vcftools --vcf manymerged/newmanymer${chr}.vcf --remove-indels --non-ref-ac-any 1 --remove-filtered LowQual --max-missing 1 --recode --out manymerged/manyfiltered${chr} &); done
rm newmanymer*
```

### run refined IBD
```bash
for chr in $(seq 22); do qsub /home/bo4da/Scripts/runBeagle2.sh /fastdata/bo4da/Data/postTests/datasetsCorrect/manymerged/manyfiltered${chr}.recode.vcf ${chr} allmany${chr}; done
cat *ibd > MANYREFIBD
cat MANYREFIBD | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > manyrefibdmerg
```

# ADD RANDOMISED POPULATION TO MAIN DATASET

```bash
cp /fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged/reffiltered1.recode.vcf .
bgzip reffiltered1.recode.vcf
tabix -p vcf reffiltered1.recode.vcf.gz
bcftools view reffiltered1.recode.vcf.gz --max-alleles 2 -o ref1nomulti.vcf
```
### randomise LWK
```bash
python /home/bo4da/Scripts/randomiseExistingLWK.py ref1nomulti.vcf > randomisedLWKfinal.vcf
bgzip randomisedLWKfinal.vcf

tabix -p vcf randomisedLWKfinal.vcf.gz
bgzip ref1nomulti.vcf
tabix -p vcf ref1nomulti.vcf.gz
bcftools merge ref1nomulti.vcf.gz randomisedLWKfinal.vcf.gz -o chr1withrandomcorrect.vcf
qsub -l h_rt=48:00:00 /home/bo4da/Scripts/runBeagle2.sh chr1withrandomcorrect.vcf 1 randomResultscorrect

cat randomResultscorrect.ibd | java -jar /home/bo4da/Programs/bin/ibdmerge.jar > randCorrMerg
```

### R
```r
randcor <- superpopulations("randCorrMerg")
DrawAncientsRef(randcor)
```

# SHORT SEGMENT WINDOW
### in R
```r
normtrunkated <- normcut
normtrunkated$ibdden <- normcut$ibdden[normcut$ibdden$Length < 10000,]
normtrunkated$ibdnea <- normcut$ibdnea[normcut$ibdnea$Length < 10000,]
```


# HYBRIDS
### make hybrids for all chromosomes
```bash
bash /home/bo4da/Scripts/pipelineHybrids.sh
```

### adding dataset to hybrids
```bash
bcftools concat afrhyb* -o afrALL.vcf
bcftools concat asianhyb* -o asianALL.vcf
bcftools concat eurhyb* -o eurALL.vcf
bgzip /fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged/refALL.vcf
tabix -p vcf /fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged/refALL.vcf.gz
bgzip afrALL.vcf
tabix -p vcf afrALL.vcf.gz
bgzip asianALL.vcf
tabix -p vcf asianALL.vcf.gz
bgzip eurALL.vcf
tabix -p vcf eurALL.vcf.gz
bcftools merge /fastdata/bo4da/Data/postTests/datasetsCorrect/refmerged/refALL.vcf.gz afrALL.vcf.gz asianALL.vcf.gz eurALL.vcf.gz --force-samples -o datasetWithHybridsFULL
bcftools view -s ^panTro4 datasetWithHybridsFULL -o datasetWithHybridsFULLnochimp.vcf
```

### add den4
```bash
vcftools --vcf ../datasetWithHybridsFULLnochimp.vcf --positions ../../Denisova_4.chr_pos --recode --out refallhybden4pos
plink --vcf refallhybden4pos.recode.vcf --recode --out refallhybden4posplink
plink --tfile ../../Denisova_4 --recode --out den4all
join -j 4 <(sort -k4,4 refallhybden4posplink.map) <(sort -k4,4 den4all.map) -o '1.1,2.2,1.3,2.4' > correctRS4.map
python /home/bo4da/Scripts/fixmaps.py correctRS4.map refallhybden4posplink.map > refallhybden4posplink.mapnew
mv refallhybden4posplink.map refallhybden4posplink.mapold
mv refallhybden4posplink.mapnew refallhybden4posplink.map
awk '{print $2}' refallhybden4posplink.map > den4subsetID.txt
plink --file den4all --extract den4subsetID.txt --recode --out den4allsubset
plink --file den4allsubset --make-bed --out den4allsubsetbed
plink --file refallhybden4posplink --make-bed --out refallhybden4posplinkbed
plink --bfile refallhybden4posplinkbed --bmerge den4allsubsetbed.bed den4allsubsetbed.bim den4allsubsetbed.fam --recode --out den4mergedhyb
plink --bfile refallhybden4posplinkbed --exclude den4mergedhyb.missnp --make-bed --out den4biallelichyb
plink --bfile den4biallelichyb --bmerge den4allsubsetbed.bed den4allsubsetbed.bim den4allsubsetbed.fam --recode --out den4mergedFINALhyb

echo -e "AltaiNea AltaiNea\nDenisovaPinky DenisovaPinky\nDenisova_4 Denisova_4\npanTro4 panTro4\nHybrid Hybrid\n 3:Hybrid 3:Hybrid\n4:Hybrid 4:Hybrid" > nohumanshyb4.txt
plink --file den4mergedFINALhyb --keep nohumanshyb4.txt --make-bed --out nohumsfinhyb4
plink --bfile nohumsfinhyb4 --pca --out nohumsfinpcahyb4
```

### add den8
```bash
vcftools --vcf ../datasetWithHybridsFULLnochimp.vcf --positions ../../Denisova_8.chr_pos --recode --out refallhybden8pos
plink --vcf refallhybden8pos.recode.vcf --recode --out refallhybden8posplink
plink --tfile ../../Denisova_8 --recode --out den8all
join -j 4 <(sort -k4,4 refallhybden8posplink.map) <(sort -k4,4 den8all.map) -o '1.1,2.2,1.3,2.4' > correctRS8.map
python /home/bo4da/Scripts/fixmaps.py correctRS8.map refallhybden8posplink.map > refallhybden8posplink.mapnew
mv refallhybden8posplink.map refallhybden8posplink.mapold
mv refallhybden8posplink.mapnew refallhybden8posplink.map
awk '{print $2}' refallhybden8posplink.map > den8subsetID.txt
plink --file den8all --extract den8subsetID.txt --recode --out den8allsubset
plink --file den8allsubset --make-bed --out den8allsubsetbed
plink --file refallhybden8posplink --make-bed --out refallhybden8posplinkbed
plink --bfile refallhybden8posplinkbed --bmerge den8allsubsetbed.bed den8allsubsetbed.bim den8allsubsetbed.fam --recode --out den8mergedhyb
plink --bfile refallhybden8posplinkbed --exclude den8mergedhyb.missnp --make-bed --out den8biallelichyb
plink --bfile den8biallelichyb --bmerge den8allsubsetbed.bed den8allsubsetbed.bim den8allsubsetbed.fam --recode --out den8mergedFINALhyb

echo -e "AltaiNea AltaiNea\nDenisovaPinky DenisovaPinky\nDenisova_8 Denisova_8\npanTro4 panTro4\nHybrid Hybrid\n 3:Hybrid 3:Hybrid\n4:Hybrid 4:Hybrid" > nohumanshyb8.txt
plink --file den8mergedFINALhyb --keep nohumanshyb8.txt --make-bed --out nohumsfinhyb8
plink --bfile nohumsfinhyb8 --pca --out nohumsfinpcahyb8
```

# PLOTS IN R

```r
source('~/Sheffield/Rworkdir/commands1.R')
```

### figure 2
```r
africans <- read.table("afr.list")
europeans <- read.table("eur.list")
eastAsians <- read.table("eas.list")
pca <- read.table("noChPCA.eigenvec")
pca$Population[pca$V1 %in% africans$V1] <- "AFR"
pca$Population[pca$V1 %in% europeans$V1] <- "EUR"
pca$Population[pca$V1 %in% eastAsians$V1] <- "EAS"
pca$Population[pca$V1 == "AltaiNea"] <- "Neandertal"
pca$Population[pca$V1 == "DenisovaPinky"] <- "Denisovan"

tiff("FPpca.tiff", height = 12, width = 16, units = 'cm', compression = "lzw", res = 1200)
ggplot(pca) + geom_point(aes(x=V3, y=V4, color=Population)) + guides(colour = guide_legend(override.aes = list(size = 5))) + theme_bw() +
geom_text(data=pca[pca$V1 == "AltaiNea",], aes(V3, V4,label=Population, hjust=-0.1)) + 
geom_text(data=pca[pca$V1 == "DenisovaPinky",], aes(V3, V4,label=Population, hjust=-0.1)) +
theme(legend.key=element_rect(fill=NA)) + ggtitle("Main Dataset 36 Million Markers") + scale_color_brewer(palette="Set1") +
labs(x="Eigenvector 1: 26.37%", y="Eigenvector 2: 11.83%")
dev.off()
```

### figure 3
```r
new <- read.table("smibs.genome", header = TRUE)
new$FID3[new$IID1 %in% YRI$V1] <- "YRI"
new$FID3[new$IID1 %in% CHB$V1] <- "CHB"
new$FID3[new$IID1 %in% GBR$V1] <- "GBR"
neanew <- ggplot(data = new[new$IID2 == "AltaiNea" & (new$FID3 == "YRI" | new$FID3 == "CHB" | new$FID3 == "GBR"),], aes(x=FID3, y=DST)) + geom_boxplot() + ggtitle("Neandertal New Dataset")
dennew <- ggplot(data = new[new$IID2 == "DenisovaPinky" & (new$FID3 == "YRI" | new$FID3 == "CHB" | new$FID3 == "GBR"),], aes(x=FID3, y=DST)) + geom_boxplot() + ggtitle("Denisova New Dataset")

dennew
```

### figure 4a
```r
tiff("FPrezhighResDenisovan.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(norm, title = "Denisovan - Total Pairwise IBD")
dev.off()
```

### figure 4b
```r
tiff("FPrezhighResNeandertal.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(norm, "nea", title = "Neandertal - Total Pairwise IBD")
dev.off()
```

### figure 5
```r
tiff("FPrezhighResMainVsRand.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
ggplot() + 
theme_bw() +
geom_density(data = norm$ibdden[norm$ibdden$Subpopulation == "MSL" | norm$ibdden$Subpopulation == "YRI" | norm$ibdden$Subpopulation == "ESN" | norm$ibdden$Subpopulation == "LWK" | norm$ibdden$Subpopulation == "GWD",], aes(Length, fill=Population), alpha = 0.5) +
geom_density(data = norm$ibdden[norm$ibdden$Population == "EUR" | norm$ibdden$Population == "EAS",], aes(Length, fill=Population), alpha = 0.5) +
geom_density(data = ran$ibdden[ran$ibdden$Population != "Neandertal" & ran$ibdden$Population != "Chimpanzee",], aes(Length, fill='Random'), alpha = 0.2) +
scale_fill_manual(values=c('black')) + scale_fill_discrete(name = "") +
labs(x="Segment Length", y="Density") + scale_x_continuous(limits = c(0, 40000)) +
scale_fill_brewer(palette="Set2") +
geom_vline(aes(xintercept=as.numeric(quantile(ran$ibdden[ran$ibdden$Population != "Neandertal" & ran$ibdden$Population != "Chimpanzee",]$Length, 0.95))), colour="blue") +
geom_text(aes(x=1000, y=0.00018, label = "Random"), alpha=0.7) +
ggtitle("Denisova - Main dataset vs Randomised - Segments' Length")
dev.off()
```

### figure 6a
```r
eashybprop <- c(12.99, 100 - (32.68 + 12.99), 28.08, 4.6, 6.04, 100 - (37.96 + 6.04), 26.41, 11.55, 14.77, 100 - (31.26 + 14.77), 28.44, 2.82)
eashybprop <- data.frame(eashybprop)
eashybprop$Source <- c("Humans", "Denisovan", "Neandertal", "EAS", "Humans", "Denisovan", "Neandertal", "AFR", "Humans", "Denisovan", "Neandertal", "EUR")
eashybprop$Hybrid <- c("EAS", "EAS", "EAS", "EAS", "AFR", "AFR", "AFR", "AFR", "EUR", "EUR", "EUR", "EUR")
eashybprop$Source <- factor(eashybprop$Source, levels = c("Humans", "Denisovan", "Neandertal", "EAS", "AFR", "EUR", ordered = TRUE))
eashybprop$eashybprop <- eashybprop$eashybprop*0.01
ggplot(data = eashybprop, aes(x=Hybrid, y=eashybprop, fill=Source)) + geom_bar(stat = "identity", position = "fill") + geom_text(aes(label = paste0(eashybprop*100, "%")), position = position_stack(vjust = 0.5)) +
theme_bw() + theme(panel.border = element_blank(), panel.grid.major = element_blank(),
panel.grid.minor = element_blank(), axis.line = element_line(colour = "black")) + coord_flip() + theme(axis.line=element_blank(),axis.text.x=element_blank(),
          axis.text.y=element_blank(),axis.ticks=element_blank(),
          axis.title.x=element_blank(),
          axis.title.y=element_blank(),legend.title=element_blank()) + scale_fill_brewer(palette="Set1")
```
		  
### figure 6b
```r
tiff("FPpcaHybDen4.tiff", height = 12, width = 16, units = 'cm', compression = "lzw", res = 1200)
hybridPCA("nohumsfinpcahyb4.eigenvec", title = "Hybrids with Den_4 1530 SNPs")
dev.off()
```

### figure 6c
```r
tiff("FPpcaHybDen8.tiff", height = 12, width = 16, units = 'cm', compression = "lzw", res = 1200)
hybridPCA("nohumsfinpcahyb8.eigenvec", title = "Hybrids with Den_8 32492 SNPs")
dev.off()
```

### figure 7a
```r
tiff("FPrezhighResDenCut.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(normcut, title = "Denisovan after cutoff - Total Pairwise IBD")
dev.off()
```

### figure 7b
```r
tiff("FPrezhighResNeaCut.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(normcut, "nea", title = "Neandertal after cutoff - Total Pairwise IBD")
dev.off()
```

### figure 8a
```r
tiff("FPrezhighThreePop.tiff", height = 12, width = 16, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(threepops, title = "Denisovan - Total Pairwise IBD")
dev.off()
```

### figure 8b
```r
tiff("FPrezhighThreePopCut.tiff", height = 12, width = 16, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(threerealcut, title = "Denisovan after cutoff - Total Pairwise IBD")
dev.off()
```

### figure 9a
```r
tiff("FPrezhighResDenSegLenv2.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientMeanSegLenv2(norm, title = "Denisovan - 36 Million Markers - Segments' Length")
dev.off()
```

### figure 9b
```r
tiff("FPrezhighRes4mDenSegLen.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientMeanSegLenv2(manyall, title = "Denisovan - 4 Million Markers Dataset - Segments' Length")
dev.off()
```

### figure 10a
```r
tiff("FPrezhighResDenisovanChr1.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(chr1original, title = "Denisovan - Main Dataset Chromosome 1 - Total Pairwise IBD")
dev.off()
```

### figure 10b
```r
tiff("FPrezhighResDenisovanRLWK.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(randcor, title = "Denisovan - Main Dataset with Randomised LWK - Total Pairwise IBD")
dev.off()
```

### figure 11a
```r
tiff("FPrezhighResRandNeaAndTrunk.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
ggplot() + 
theme_bw() +
geom_density(data = norm$ibdnea[norm$ibdnea$Subpopulation == "MSL" | norm$ibdnea$Subpopulation == "YRI" | norm$ibdnea$Subpopulation == "ESN" | norm$ibdnea$Subpopulation == "LWK" | norm$ibdnea$Subpopulation == "GWD",], aes(Length, fill=Population), alpha = 0.5) +
geom_density(data = norm$ibdnea[norm$ibdnea$Population == "EUR" | norm$ibdnea$Population == "EAS",], aes(Length, fill=Population), alpha = 0.5) +
scale_fill_manual(values=c('black')) + scale_fill_discrete(name = "") +
labs(x="Segment Length", y="Density") + scale_x_continuous(limits = c(0, 40000)) +
scale_fill_brewer(palette="Set2") +
geom_vline(aes(xintercept=as.numeric(quantile(ran$ibdnea[ran$ibdnea$Population != "Denisovan" & ran$ibdnea$Population != "Chimpanzee",]$Length, 0.95))), colour="blue") +
geom_vline(aes(xintercept=10000), colour="blue") +
geom_rect(aes(xmin=as.numeric(quantile(ran$ibdnea[ran$ibdnea$Population != "Denisovan" & ran$ibdnea$Population != "Chimpanzee",]$Length, 0.95)), xmax=10000, ymin=0, ymax=Inf), alpha = 0.4) +
ggtitle("Neandertal - Truncated segments over 10000 bp - Segments' Length")
dev.off()
```

### figure 11b
```r
tiff("FPrezhighResNeaTrunk.tiff", height = 12, width = 22, units = 'cm', compression = "lzw", res = 1200)
DrawAncientsRef(normtrunkated, "nea", title = "Neandertal - Trunkated segments over 10000 bp - Total Pairwise IBD")
dev.off()
```
