'''
Usage: Pipe-in human-Neandertal segments from algo part2, read vcf as first argument
'''
import sys,re

def parseVCF(input, vcf):
	segments = []
	for i in input:
		segments.append(i.rstrip())
	mapIndivs = {}
	with open(vcf, 'r') as f:
		for line in f:
			if re.match('##',  line):
				print(line.rstrip())
			elif re.match('#CHROM',  line):
				fields = re.match('((\S+\s+){9})(.*)',  line)
				print(fields.group(1), "Hybrid", sep = "")
				indivs = fields.group(0).split("\t")
				ourIndivs = []
				for line2 in segments:
					fields2 = re.match('(\S+)\s+(\S+)\s+(\S+)',  line2)
					ourIndivs.append(fields2.group(1))
				ourIndivs = set(ourIndivs)
				for i in ourIndivs:
					if i in indivs:
						mapIndivs[i] = indivs.index(i) + 1
				#break
			else:
				switch = True
				fields = re.match('\S+\s+(\S+)',  line)
				for line2 in segments:
					fields2 = re.match('(\S+)\s+(\S+)\s+(\S+)',  line2)
					if int(fields.group(1)) >= int(fields2.group(2)) and int(fields.group(1)) <= int(fields2.group(3)):
						indexNumber = mapIndivs[fields2.group(1)]
						regex = '((\S+\s+){9})(\S+\s+){' + str(indexNumber - 10) + '}(\S+)'
						fields3 = re.match(regex,  line)
						print(fields3.group(1), fields3.group(4), sep = "")
						switch = False
						break
					if switch == True:
						#Denisovan
						indexNumber = 460
						regex = '((\S+\s+){9})(\S+\s+){' + str(indexNumber - 10) + '}(\S+)'
						fields3 = re.match(regex,  line)
						print(fields3.group(1), fields3.group(4), sep = "")
						switch = False
						break	




if sys.stdin:
	parseVCF(sys.stdin, sys.argv[1])
else:
	print("You need to pipe in the human-Neandertal data", file=sys.stderr)
