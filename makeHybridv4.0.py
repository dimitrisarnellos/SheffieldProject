'''
Author: Dimitris Arnellos
Purpose: Takes output from myIBDmerge.py and creates a hybrid based on these segments
'''

import sys, re

segments = {}
counter = 0
for line in sys.stdin:
	segments[counter] = []
	fields = re.match('(\S+)\s+(\S+)', line)
	segments[counter].append(fields.group(1))
	segments[counter].append(fields.group(2))
	counter  += 1
#print(segments)
with open(sys.argv[1], 'r') as f:
	for line in f:
		#output header
		if re.match('##', line):
			print(line.rstrip())
		elif re.match('#', line):
			header = re.match('((\S+\s+){9})', line)
			print(header.group(1), "Hybrid", sep = "")
		else:
			#output body
			switch = False
			fields = re.match('(\S+\s+(\S+)\s+(\S+\s+){7})(\S+)\s+(\S+)', line)
			for i in segments:
				#print(fields.group(2))
				if int(fields.group(2)) >= int(segments[i][0]) and int(fields.group(2)) <= int(segments[i][1]):
					print(fields.group(1), fields.group(4), sep = "")
					switch = True
					break
			if switch == False:
				print(fields.group(1), fields.group(5), sep = "")
