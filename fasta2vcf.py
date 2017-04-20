'''
Author: Dimitris Arnellos
Usage: python3 fasta2vcf.py sequence referenceSequence > file.vcf
'''

import sys, re

seq = []
with open(sys.argv[1], 'r') as f:
	for line in f:
		if re.match('\>', line):
			chr = line.strip(">")
			chr = chr.strip()
		else:
			line = line.strip()
			seq = list(line)

ref = []
with open(sys.argv[2], 'r') as f:
	for line in f:
		if re.match('\>', line):
			continue
		else:
			line = line.strip()
			ref = list(line)


print("#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\tChimpanzee")

for i in range(0, len(seq)):

	alt = ""
	gt = ""
	#line = chr + "\t" + str(i + 1) + "\t" + "." + "\t" + ref[i].upper() + "\t" + alt + "\t" + "." + "\t" + "." + "\t" + "." + "\t" + "GT" + gt

	if (seq[i].upper() == "-" or ref[i].upper() == "N"):
		alt = "."
		gt = ".|."
	elif (ref[i].upper() == seq[i].upper()):
		alt = "."
		gt = "0|0"
	elif (ref[i].upper() != seq[i].upper()):
		alt = seq[i].upper()
		gt = "1|1"
	line = chr + "\t" + str(i + 1) + "\t" + "." + "\t" + ref[i].upper() + "\t" + alt + "\t" + "." + "\t" + "." + "\t" + "." + "\t" + "GT" + "\t" + gt
	print(line)
