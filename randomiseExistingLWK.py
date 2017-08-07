import sys,re
from random import shuffle


def parseVCF(vcf):
	mapIndivs = {}
	gt = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
	first9 = []
	with open(vcf, 'r') as f:
		for line in f:
			if re.match('##',  line):
				print(line.rstrip())
			elif re.match('#CHROM',  line):
				fields = re.match('((\S+\s+){9})(.*)',  line)
				indivs = fields.group(0).split("\t")
				for i in indivs:
					mapIndivs[indivs.index(i) + 1] = i
				print(fields.group(1), end = "")
				randomizedLWK = ""
				for i in range(430, 460):#340 370 for LWK, 430 460 for YRI
					if randomizedLWK == "":
						randomizedLWK += "r" + mapIndivs[i]
					else:
						randomizedLWK += "\t" + "r" + mapIndivs[i]
				print(randomizedLWK)
			else:
				#fields = re.match('\S+\s+(\S+)',  line)
				#pos.append(fields.group(1))
				for i in range(430, 460):#340 370 for LWK, 430 460 for YRI
					regex = '((\S+\s+){9})(\S+\s+){' + str(i - 10) + '}(\S+)'
					fields2 = re.match(regex,  line)
					if i == 430:#340 LWK, 430, YRI
						first9.append(fields2.group(1))
					gt[i - 430].append(fields2.group(4))#340 LWK, 430, YRI
				sys.stderr.write("\r" + "Lines processed: " + str(len(first9)))
				sys.stderr.flush()				
	for i in range(len(gt)):
		shuffle(gt[i])
	for i in range(len(first9)):
		print(first9[i], end="")
		for j in range(30):
			if j < 29:
				print(gt[j][i], end="\t")
			else:
				print(gt[j][i])

if len(sys.argv) == 2:
	parseVCF(sys.argv[1])
else:
	print("Script needs custom-made vcf")
