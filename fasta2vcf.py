'''
Author: Dimitris Arnellos
Usage: python3 fasta2vcf.py -f fasta_sequence reference_fasta_sequence -i indivs_name> file.vcf
'''

import sys
import re
import argparse

parser = argparse.ArgumentParser(description='Convert a fasta file to VCF using another reference fasta.')
parser.add_argument('-f', '--fasta', help='Fasta for conversion', required=True)
parser.add_argument('-r', '--reference', help='Reference fasta', required=True)
parser.add_argument('-i', '--indiv', help='Individuals name from fasta', required=True)
args = parser.parse_args()

seq = []
with open(args.fasta, 'r') as f:
	for line in f:
		if re.match('\>', line):
			chr = line.strip(">")
			chr = chr.strip()
		else:
			line = line.strip()
			for char in line:
				seq.append(char)

ref = []
with open(args.reference, 'r') as f:
	for line in f:
		if re.match('\>', line):
			continue
		else:
			line = line.strip()
			for char in line:
				ref.append(char)

print(f"#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t{args.indiv}")

for i in range(0, len(seq)):

	alt = ""
	gt = ""

	if (seq[i].upper() == "N" or ref[i].upper() == "N"):
		alt = "."
		gt = ".|."
		continue
	elif (ref[i].upper() == seq[i].upper()):
		alt = "."
		gt = "0|0"
	elif (ref[i].upper() != seq[i].upper()):
		alt = seq[i].upper()
		gt = "1|1"

	line = chr + "\t" + str(i + 1) + "\t" + "." + "\t" + ref[i].upper() + "\t" + alt + "\t" + "." + "\t" + "." + "\t" + "." + "\t" + "GT" + "\t" + gt
	print(line)
