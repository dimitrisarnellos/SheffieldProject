'''
Author: Dimitris Arnellos
Purpose: Converts base pair lengths to centimorgans
Usage: python bp2cM.py ibdResultsFile plink.map > out.file
'''
import sys, re

firstIndiv = []
secondIndiv = []
segStart = []
segEnd = []
with open(sys.argv[1], 'r') as f:
	for line in f:
		line = re.match('(\S+)\s+\S+\s+(\S+)\s+\S+\s+\S+\s+(\S+)\s+(\S+)', line)
		firstIndiv.append(line.group(1))
		secondIndiv.append(line.group(2))
		segStart.append(int(line.group(3)))
		segEnd.append(int(line.group(4)))

cM = []
bp = []
with open(sys.argv[2], 'r') as f:
	for line in f:
		line = re.match('\S+\s+\S+\s+(\S+)\s+(\S+)', line)
		cM.append(float(line.group(1)))
		bp.append(int(line.group(2)))


for i in range(0, len(segEnd)):
	cmStart = ""
	cmEnd = ""
	for j in range(0, len(cM)):
		if (j == 0 and segStart[i] < bp[j]):
			cmStart = cM[j]
		elif (cmStart == "" and segStart[i] < bp[j]):
			cmStart = (cM[j-1] + cM[j])/2
		elif (cmStart == "" and segStart[i] == bp[j]):
			cmStart = cM[j]
		if (segEnd[i] < bp[j]):
			cmEnd = (cM[j-1] + cM[j])/2
			break
		elif (segEnd[i] == bp[j]):
			cmEnd = cM[j]
			break
	print(firstIndiv[i], secondIndiv[i], cmEnd - cmStart, sep="\t")
