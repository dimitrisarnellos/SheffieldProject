'''
Author: Dimitris Arnellos
Purpose: Imput 2 vcf files, make a hybrid vcf from given sequences with alterating windows for a given window length and a given percentage of admixture
	of the first individual in the vcf file to the hybrid
Usage: python makeHybridv2.0.py vcffile window percentage > hybridised.vcf # the hybridization occurs between the first two indivs of vcf file
'''

import sys,re

window = int(sys.argv[2])
percentage = float(sys.argv[3])
firstPos = 0
firstLineSwitch = True
windowCount = 0
secondWindow = ((1 - percentage)*window)/percentage
windowRegion = 0

with open(sys.argv[1], 'r')  as f:
	for line in f:

		#outputing header
		if re.match('##', line):
			print(line.rstrip())
		elif re.match('#', line):
			header = re.match('((\S+\s+){9})', line)
			print(header.group(1), "Hybrid", sep = "\t")
		
		#outputing body
		else:
			field = re.match('(\S+\s+(\S+)\s+(\S+\s+){7})(\S+\s+)(\S+\s+)', line)

			#capturing beginning position
			if firstLineSwitch == True:
				firstPos = int(field.group(2))
				firstLineSwitch = False

			
			##evaluating which window do the positions belong to and output the corresponding genotype
			if windowCount == 0:
				windowRegion = firstPos + window
			if int(field.group(2)) < windowRegion:
				if windowCount % 2 == 0:
					print(field.group(1), field.group(4), sep = "\t")
				if windowCount %2 == 1:
					print(field.group(1), field.group(5), sep = "\t")
			else:
				windowCount = windowCount + 1
				if windowCount % 2 == 0:
					windowRegion = windowRegion + window
					print(field.group(1), field.group(4), sep = "\t")
				if windowCount %2 == 1:
					windowRegion = windowRegion + secondWindow
					print(field.group(1), field.group(5), sep = "\t")

