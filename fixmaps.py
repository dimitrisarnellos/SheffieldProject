import sys, re

'''
Author: Dimitris Arnellos
Purpose: Renames variant ID of one plink map file based on another map file for the same position
Usage: join -j 4 <(sort -k4,4 my.map) <(sort -k4,4 reference.map) -o '1.1,2.2,1.3,2.4' > correctRS.map
	python fixmaps.py correctRS.map mapToBeChanged > changedMap
'''

ref = [[],[]]
with open(sys.argv[1], 'r') as f:
	for line in f:
		fields = re.match('\S+\s+(\S+)\s+\S+\s+(\S+)\s+', line)
		ref[0].append(fields.group(1))
		ref[1].append(fields.group(2))
#print(ref)

with open(sys.argv[2], 'r') as f:
	for line in f:
		fields = re.match('(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+', line)
		if fields.group(4) in ref[1]:
			print(fields.group(1), ref[0][ref[1].index(fields.group(4))], fields.group(3), fields.group(4), sep="\t")
		else:
			fields = fields.group(0).rstrip()
			print(fields)
