'''
Usage: Pipe-in human-Neandertal segments from algo part2, read default idividual as first argument, read superpopulation specific 
segments as second argument and read vcf as third argument
'''
import sys,re

def parseVCF(input, defaultIndiv, superpop, vcf):
	#read-in the all-human segments
	segments = []
	for i in input:
		segments.append(i.rstrip())
	mapIndivs = {}
	
	#read-in the superpopulation specific segments
	specSegments = []
	with open(superpop, 'r') as f:
		for i in f:
			specSegments.append(i.rstrip())
	#segments = set(segments)
	#specSegments = set(specSegments)
	#parse-vcf and output the hybrid
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
				for line2 in specSegments:
					fields2 = re.match('(\S+)\s+(\S+)\s+(\S+)',  line2)
					ourIndivs.append(fields2.group(1))
				ourIndivs = set(ourIndivs)
				#for i in ourIndivs:
				for i in indivs:
					mapIndivs[i] = indivs.index(i) + 1
				#break
			else:
				switch = True
				fields = re.match('\S+\s+(\S+)',  line)
				for line3 in specSegments:
					fields3 = re.match('(\S+)\s+(\S+)\s+(\S+)',  line3)
					if int(fields.group(1)) >= int(fields3.group(2)) and int(fields.group(1)) <= int(fields3.group(3)):
						indexNumber = mapIndivs[fields3.group(1)]
						#print(indexNumber)
						regex = '((\S+\s+){9})(\S+\s+){' + str(indexNumber - 10) + '}(\S+)'
						fields4 = re.match(regex,  line)
						print(fields4.group(1), fields4.group(4), sep = "")
						switch = False
						break
					elif int(fields.group(1)) > int(fields3.group(3)):
						specSegments.pop(0)
					for line2 in segments:
						fields2 = re.match('(\S+)\s+(\S+)\s+(\S+)',  line2)
						if int(fields.group(1)) >= int(fields2.group(2)) and int(fields.group(1)) <= int(fields2.group(3)):
							indexNumber = mapIndivs[defaultIndiv]
							#print(indexNumber)
							regex = '((\S+\s+){9})(\S+\s+){' + str(indexNumber - 10) + '}(\S+)'
							fields4 = re.match(regex,  line)
							print(fields4.group(1), fields4.group(4), sep = "")
							switch = False
							break
						elif int(fields.group(1)) > int(fields2.group(3)):
							segments.pop(0)
						elif int(fields.group(1)) < int(fields2.group(3)):
							break
					if switch == False:
						break
					else:
						#Denisovan
						indexNumber = 460
						regex = '((\S+\s+){9})(\S+\s+){' + str(indexNumber - 10) + '}(\S+)'
						fields4 = re.match(regex,  line)
						print(fields4.group(1), fields4.group(4), sep = "")
						switch = False
						break	
				if switch == True:
					#Denisovan
					indexNumber = 460
					regex = '((\S+\s+){9})(\S+\s+){' + str(indexNumber - 10) + '}(\S+)'
					fields4 = re.match(regex,  line)
					print(fields4.group(1), fields4.group(4), sep = "")



if sys.stdin:
	parseVCF(sys.stdin, sys.argv[1], sys.argv[2], sys.argv[3])
else:
	print("You need to pipe in the human-Neandertal data", file=sys.stderr)
