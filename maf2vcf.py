'''
Author: Dimitris Arnellos
Purpose: Maf to Vcf
Usage: maf2vcf.py maffile > vcffile
'''
import sys,re


with open(sys.argv[1], 'r') as f:
	count = 0
	ref = []
	alt = []
	pos = 0
	gt = ""
	print("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tChimpanzee")
	for line in f:
		count = count + 1
		if count == 1:
			subit = re.match('\S+\s+(\S+)\s+(\S+)\s+\S+\s+\S+\s+\S+\s+(\S+)', line)
			chr = subit.group(1).split(".")[1]
			chr = chr.replace("chr", "")
			#print("CHROOOOOOOOOOM", chr)
			pos = subit.group(2)
			ref = list(subit.group(3))
			#print(ref, pos)
		if count == 2:
			subit = re.match('\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+(\S+)', line)
			alt = list(subit.group(1))
			#print(count, alt)
		if count == 3:
			for i in range(len(ref)):
				#print(ref[i], alt[i])
				if ref[i] == "-":
					continue
				elif alt[i] == "-":
					alt[i] = "."
					gt = "./." #should I have this as phased or unphased, I don't know
				elif ref[i].upper() == alt[i].upper():
					gt = "0|0"
					ref[i] = ref[i].upper()
					alt[i] = alt[i].upper()
				elif ref[i].upper() != alt[i].upper():
					gt = "1|1"
					ref[i] = ref[i].upper()
					alt[i] = alt[i].upper()
				print(chr, int(pos) + i + 1, ".",  ref[i].upper(), alt[i].upper(), ".", ".", ".", "GT", gt, sep="\t")
			count = 0
			ref = []
			alt = []
			pos = 0
			gt = ""
