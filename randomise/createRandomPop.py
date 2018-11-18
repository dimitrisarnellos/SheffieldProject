"""
Reads VCF to use the metadata and creates a population of 30
Individuals with random phased genotypes.
"""

import re
import random
import argparse

parser = argparse.ArgumentParser(description='Creates population with random genotypes.')
parser.add_argument('--vcf', help='VCF file', required=True)
args = parser.parse_args()


def output_random_population(vcf):
	genotypes = ["0|0", "0|1", "1|0", "1|1"]
	with open(vcf, 'r') as f:
		for line in f:
			if re.match('##',  line):
				print(line.rstrip())
			elif re.match('#CHROM',  line):
				fields = re.match('((\S+\s+){9})(.*)',  line)
				print(fields.group(1), end="")
				for i in range(30):
					if i < 29:
						print("Random" + str(i) + "\t", end="")
					else:
						print("Random" + str(i))
			else:
				fields = re.match('((\S+\s+){9})',  line)
				print(fields.group(1), end="")
				for i in range(30):
					if i < 29:
						print(random.choice(genotypes), end="\t")
					else:
						print(random.choice(genotypes))


if __name__ == '__main__':
	output_random_population(args.vcf)