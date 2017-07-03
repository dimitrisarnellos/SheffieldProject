import sys,re

def trackedMerge(input):
	begin = True
	previousInd = ""
	previousStart = 0
	previousEnd = 0
	neaStart = 0
	neaEnd = 0
	indiv = []
	indivStart = []
	indivEnd = []
	for line in input:
		fields = re.match('(\S+)\s+(\S+)\s+(\S+)',  line)
		ind = fields.group(1)
		segStart = int(fields.group(2))
		segEnd = int(fields.group(3))
		if begin == True:
			indiv.append(ind)
			previousInd = ind
			indivStart.append(segStart)
			previousStart = segStart
			previousEnd = segEnd
			if ind == "Neandertal":
				neaStart = segStart
				neaEnd = segEnd
		#	#indivEnd.append(previousEnd)
			begin = False
		elif begin == False:
			if ind == "Neandertal":
				if neaStart == 0 and neaEnd == 0:
					neaStart = segStart
					neaEnd = segEnd
				if previousInd == "Neandertal":
					indivEnd.append(neaEnd)

					if segStart > neaEnd:
						neaStart = segStart
					if segEnd > neaEnd:
						neaEnd = segEnd
					indiv.append(ind)
					indivStart.append(neaStart)
					previousInd = ind
					previousStart = neaStart
				else:
					indivEnd.append(previousEnd)
					if previousEnd > segStart and previousEnd < segEnd:
						neaStart = previousEnd + 1
						neaEnd = segEnd
						indiv.append(ind)
						indivStart.append(neaStart)
						previousStart = neaStart
						previousInd = ind
					elif previousEnd > segStart and previousEnd > segEnd:
						continue
					elif previousEnd < segStart:
						neaStart = segStart
						neaEnd = segEnd
						indiv.append(ind)
						indivStart.append(neaStart)
						previousStart = neaStart
						previousInd = ind
				previousEnd = segEnd
			else:
				if neaEnd !=0 and neaStart != 0 and neaEnd >= previousEnd:
					if neaEnd < segStart:
						indivEnd.append(neaEnd)

						indiv.append(ind)
						indivStart.append(segStart)
						previousInd = ind
						previousStart = segStart
						previousEnd = segEnd
					elif segStart > neaStart and neaEnd > segStart:
						indivEnd.append(segStart - 1)

						indiv.append(ind)
						indivStart.append(segStart)
						previousInd = ind
						previousStart = segStart
						previousEnd = segEnd
				else:
					indivEnd.append(previousEnd)

					indiv.append(ind)
					indivStart.append(segStart)
					previousInd = ind
					previousStart = segStart
					previousEnd = segEnd

	return indiv, indivStart, indivEnd					


if sys.stdin:
	indiv, indivStart, indivEnd = trackedMerge(sys.stdin)
	#print(len(indiv),len(indivStart),len(indivEnd))	
	for i in range(len(indiv)):
		print(indiv[i], indivStart[i], indivEnd[i])
else:
	print("You need to pipe in the data")
