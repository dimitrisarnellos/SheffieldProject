import sys, re

'''
Author: Dimitris Arnellos
Purpose: Makes haploid male non-psedoautosomal X chromosome regions as homozygous diploid in vcf file
Usage: Provide vcf file as argument to the script
'''

with open(sys.argv[1], 'r') as f:
	for line in f:
		if re.match('#', line):
			line = line.rstrip()
			print(line)
		else:
			counter = 0
			line = line.rstrip()
			fields = re.findall('(\S+\s+)', line)
			last = re.search('(\S+$)', line)
			for i in fields:
				counter += 1
				if counter < 10:
					i = i.rstrip()
					print(i, end="\t")
				elif len(i) > 3:
					i = i.rstrip()
					print(i, end="\t")
				else:
					i = i.rstrip()
					print(i,"|",i, sep="", end="\t")
			print(last.group()) # Last indiv is female so I don't have to fix this line UNLESS I use this script to a different vcf file
