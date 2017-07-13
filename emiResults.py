'''
removeDup chrNum.result | python emiResult.py [afr|nonafr] [strict|50]
'''

afrFile = "/fastdata/bo4da/Data/1000genomes/byPopulation/afr.list"
eurFile = "/fastdata/bo4da/Data/1000genomes/byPopulation/eur.list"
easFile = "/fastdata/bo4da/Data/1000genomes/byPopulation/eas.list"

import sys,re

afr = []
with open(afrFile, 'r') as f:
	for line in f:
		afr.append(line.rstrip())
afr = set(afr)

eur = []
with open(eurFile, 'r') as f:
	for line in f:
		eur.append(line.rstrip())
eur = set(eur)

eas = []
with open(easFile, 'r') as f:
	for line in f:
		eas.append(line.rstrip())
eas = set(eas)

#print("SegStart", "SegEnd", "AFR", "EUR", "EAS")
if sys.stdin:
	for line in sys.stdin:
		afrCount = 0
		eurCount = 0
		easCount = 0
		line = line.rstrip().split("\t")
		for i in range(len(line)):
			if i > 2:
				if line[i].split(' ')[0] in afr:
					afrCount += 1
				elif line[i].split(' ')[0] in eur:
					eurCount += 1
				elif line[i].split(' ')[0] in eas:
					easCount += 1
		pop = ""
		if afrCount > eurCount and afrCount > easCount:
			pop = "AFR"
		elif eurCount > afrCount and eurCount > easCount:
			pop = "EUR"
		elif easCount > afrCount and easCount > eurCount:
			pop = "EAS"
		elif easCount == eurCount and easCount > afrCount:
			pop = "nonAfr"
		else:
			pop = "Umbiguous"
		if len(sys.argv) == 3:
			if sys.argv[2] == "strict":
				if afrCount > 0 and eurCount == 0 and easCount == 0 and sys.argv[1] == "afr":
					print("\t".join(line))
				elif (eurCount != 0 or easCount != 0) and afrCount == 0 and sys.argv[1] == "nonafr":
					print("\t".join(line))
			elif afrCount + eurCount + easCount > 0 and sys.argv[2] == "50":
				if afrCount/(afrCount + eurCount + easCount) > 0.5 and sys.argv[1] == "afr":
					print("\t".join(line))
				elif (eurCount + easCount)/(afrCount + eurCount + easCount) > 0.5 and sys.argv[1] == "nonafr":
					print("\t".join(line))
		elif (eurCount != 0 or easCount != 0) and afrCount != 0 and sys.argv[1] == "common":
			print("\t".join(line))
			
		#print(line[1], line[2], afrCount, eurCount, easCount, sep="\t")

