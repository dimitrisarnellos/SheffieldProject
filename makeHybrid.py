'''
Author: Dimitris Arnellos
Purpose: Imput 2 vcf files, make a hybrid vcf from given sequences with alterating windows for a given window length
Usage: python makeHybrid.py vcffile > hybridised.vcf # vcffile should only contain the 2 indivs that are for hybridasation
'''

import sys,re

window = sys.argv[2]
firstPos = 0
firstLineSwitch = True
windowCount = 0
with open(sys.argv[1], 'r')  as f:
	for line in f:
		if re.match('##', line):
			print(line.rstrip())
		elif re.match('#', line):
			header = re.match('((\S+\s+){9})', line)
			print(header.group(1), "Hybrid", sep="")
		elif firstLineSwitch == True:
			firstPos = re.match('\S+\s+(\S+)', line)
			firstLineSwitch = False
			firstLine = re.match('((\S+\s+){9})(\S+)', line)
			print(firstLine.group(1), firstLine.group(3), sep="")

		else:
			field = re.match('(\S+\s+(\S+)\s+(\S+\s+){7})(\S+\s+)(\S+\s+)', line)
			##TODO
			if int(field.group(2)) > int(window) * windowCount + int(firstPos.group(1)):
				windowCount = windowCount + 1
			if windowCount % 2 == 1:
				print(field.group(1), field.group(4).rstrip(), sep = "")
			if windowCount %2 == 0:
				print(field.group(1), field.group(5).rstrip(), sep = "")
			##

#print(window, firstPos.group(1))

