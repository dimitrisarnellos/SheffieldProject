import sys,re,random

def parseVCF(vcf):
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
if len(sys.argv) == 2:
	parseVCF(sys.argv[1])
else:
	print("Script needs custom-made vcf")