import sys,re

'''
Usage: sort -u -k6 -k7 -n denSegs.txt | python /home/bo4da/Scripts/myHyAlgo.py neandertalSegments.txt .vcf
Design: 1) Merge human segments while kwwping track the humans that the segments come from, keep track of
	one human in place of overlapping segments, 2) merge output of 1) the neadertal segments, 3) sort list
	from 2), 4) merge as in one only that we keep the human name in the overlap of human and neandertal
'''

def trackedMerge(input):
	begin = True
	previousStart = 0
	previousEnd = 0
	indiv = []
	indivStart = []
	indivEnd = []
	for line in input:
		fields = re.match('(\S+)\s+(\S+\s+){4}(\S+)\s+(\S+)',  line)
		if begin == True:
			indiv.append(fields.group(1))
			previousStart = int(fields.group(3))
			indivStart.append(previousStart)
			previousEnd = int(fields.group(4))
			indivEnd.append(previousEnd)
			begin = False
		elif int(fields.group(3)) <= previousEnd and int(fields.group(4)) <= previousEnd:
			continue
		elif int(fields.group(3)) <= previousEnd and int(fields.group(4)) > previousEnd:
			indiv.append(fields.group(1))
			indivStart.append(previousEnd + 1)
			previousEnd = int(fields.group(4))
			indivEnd.append(previousEnd)
			
		else:
			previousStart = int(fields.group(3))
			previousEnd = int(fields.group(4))
			indiv.append(fields.group(1))
			indivStart.append(previousStart)
			indivEnd.append(previousEnd)
	return indiv, indivStart, indivEnd

def neaAfterHum(indiv, indivStart, indivEnd, neaSegs):
	#add neandertal segments in list from trackedMerge()

	with open(neaSegs, 'r') as f:
		begin = True
		casePrev = False
		previousHumanEnd = 0
		for line in f:
			fields = re.match('(\S+)\s+(\S+)',  line)
			neaStart = int(fields.group(1))
			neaEnd = int(fields.group(2))
			indiv.append("Neandertal")
			indivStart.append(neaStart)
			indivEnd.append(neaEnd)
	return indiv, indivStart, indivEnd
if sys.stdin:
	#Like Main function
	indiv, indivStart, indivEnd = trackedMerge(sys.stdin)
	#neaAfterHum(indiv, indivStart, indivEnd, sys.argv[1])
	indiv, indivStart, indivEnd = neaAfterHum(indiv, indivStart, indivEnd, sys.argv[1])
	for i in range(len(indiv)):
		print(indiv[i], indivStart[i], indivEnd[i])
