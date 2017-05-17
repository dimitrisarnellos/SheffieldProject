'''
Author: Dimitris
Purpose: Parse fastIBD output
'''
import sys,re

pos = []
with open(sys.argv[2], 'r') as f:
	for line in f:
		position = re.match('\S+\s+(\S+)', line)
		pos.append(position.group(1))

with open(sys.argv[1], 'r') as f:
	for line in f:
		markers = re.match('(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+', line)
		print(markers.group(1), markers.group(2), pos[int(markers.group(3))], pos[int(markers.group(4)) - 1], int(pos[int(markers.group(4)) - 1]) - int(pos[int(markers.group(3))]), sep="\t")
