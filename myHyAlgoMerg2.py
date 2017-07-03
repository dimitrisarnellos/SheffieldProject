'''
If human, push in human list. If nea, push in nea list. If neaEnd of first nea in list less than
humStart of last hum in list: compare first nea with all humans, build combined list and pop out
the compared indivs from hum and nea list.
'''
import sys,re,copy

def mainAlgo(humList, neaList, combinedList):
	humTemp = copy.deepcopy(humList)
	for i in range(len(humTemp[0])):
		#case 3 - leaves the neaEnd lingering so needs to be treated from other cases
		if len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] < humTemp[1][i] and neaList[1][0] > humTemp[2][i]:
			if	neaList[0][0] > combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(neaList[0].pop(0))
				combinedList[2].append(humTemp[1][i] - 1)
				combinedList[0].append(humTemp[0][i])
				combinedList[1].append(humTemp[1][i])
				combinedList[2].append(humTemp[2][i])
				humList[0].pop(0)
				humList[1].pop(0)
				humList[2].pop(0)
			elif neaList[0][0] <= combinedList[2][-1]: #i dont know if its needed i need to think about it
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(humTemp[1][i] - 1)
				combinedList[0].append(humTemp[0][i])
				combinedList[1].append(humTemp[1][i])
				combinedList[2].append(humTemp[2][i])
				humList[0].pop(0)
				humList[1].pop(0)
				humList[2].pop(0)
				neaList[0].pop(0)
		#case 4 - leaves the neaEnd lingering so needs to be treated from other cases
		elif len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] >= humTemp[1][i] and neaList[0][0] <= humTemp[2][i] and neaList[1][0] > humTemp[2][i]:
			combinedList[0].append(humTemp[0][i])
			combinedList[1].append(humTemp[1][i])
			combinedList[2].append(humTemp[2][i])
			humList[0].pop(0)
			humList[1].pop(0)
			humList[2].pop(0)
			neaList[0].pop(0)
		#case 7 - secondary derived, leaves the neaEnd lingering so needs to be treated from other cases
		elif len(neaList[0]) != len(neaList[1]) and humTemp[2][i] < neaList[1][0]:
			if combinedList[2][-1] < humTemp[1][i] and combinedList[2][-1] + 1 < humTemp[1][i] - 1:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(humTemp[1][i] - 1)
			combinedList[0].append(humTemp[0][i])
			combinedList[1].append(humTemp[1][i])
			combinedList[2].append(humTemp[2][i])
			humList[0].pop(0)
			humList[1].pop(0)
			humList[2].pop(0)
		#case 6
		elif len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] > humTemp[2][i] and neaList[1][0] > humTemp[2][i]:
			combinedList[0].append(humTemp[0][i])
			combinedList[1].append(humTemp[1][i])
			combinedList[2].append(humTemp[2][i])
			humList[0].pop(0)
			humList[1].pop(0)
			humList[2].pop(0)
		#neastart neaend before humstart, case 1
		elif len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] < humTemp[1][i] and neaList[1][0] < humTemp[1][i]:
			if neaList[0][0] > combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(neaList[0].pop(0))
				combinedList[2].append(neaList[1].pop(0))
			elif neaList[0][0] <= combinedList[2][-1] and neaList[0][0] > combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(neaList[1].pop(0))
				neaList[0].pop(0)
			elif neaList[0][0] < combinedList[2][-1] and neaList[0][0] <= combinedList[2][-1]:
				neaList[0].pop(0)
				neaList[1].pop(0)
			break
		#case 10 - like case 1 but neaEnd = humStart
		elif len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] < humTemp[1][i] and neaList[1][0] == humTemp[1][i]:
			if neaList[0][0] > combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(neaList[0].pop(0))
				combinedList[2].append(humTemp[1][i] - 1)
				neaList[1].pop(0)
			elif neaList[0][0] <= combinedList[2][-1] and neaList[1][0] > combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(humTemp[1][i] - 1)
				neaList[0].pop(0)
				neaList[1].pop(0)
			break
		#case 2
		elif len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] < humTemp[1][i] and humTemp[1][i] < neaList[1][0] and neaList[1][0] <= humTemp[2][i]:
			if neaList[0][0] > combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(neaList[0].pop(0))
				combinedList[2].append(humTemp[1][i] - 1)
				combinedList[0].append(humTemp[0][i])
				combinedList[1].append(humTemp[1][i])
				combinedList[2].append(humTemp[2][i])
				neaList[1].pop(0)
				humList[0].pop(0)
				humList[1].pop(0)
				humList[2].pop(0)
			elif neaList[0][0] <= combinedList[2][-1]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(humTemp[1][i] - 1)
				combinedList[0].append(humTemp[0][i])
				combinedList[1].append(humTemp[1][i])
				combinedList[2].append(humTemp[2][i])
				neaList[0].pop(0)
				neaList[1].pop(0)
				humList[0].pop(0)
				humList[1].pop(0)
				humList[2].pop(0)
			break
		#case 5
		elif len(neaList[0]) == len(neaList[1]) and len(neaList[0]) != 0 and neaList[0][0] >= humTemp[1][i] and neaList[1][0] <= humTemp[2][i]:
			combinedList[0].append(humTemp[0][i])
			combinedList[1].append(humTemp[1][i])
			combinedList[2].append(humTemp[2][i])
			neaList[0].pop(0)
			neaList[1].pop(0)
			humList[0].pop(0)
			humList[1].pop(0)
			humList[2].pop(0)
			break
		#case 8 - dealing with last neaEnd
		elif len(neaList[0]) != len(neaList[1]) and humTemp[1][i] <= neaList[1][0] and humTemp[2][i] >= neaList[1][0]:
			if combinedList[2][-1] < humTemp[1][i]  and combinedList[2][-1] + 1 < humTemp[1][i] - 1:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(humTemp[1][i] - 1)
			combinedList[0].append(humTemp[0][i])
			combinedList[1].append(humTemp[1][i])
			combinedList[2].append(humTemp[2][i])
			humList[0].pop(0)
			humList[1].pop(0)
			humList[2].pop(0)
			neaList[1].pop(0)
			break
		#case 9 - dealing with last neaEnd
		elif len(neaList[0]) != len(neaList[1]) and humTemp[1][i] > neaList[1][0]:
			if combinedList[2][-1] < neaList[1][0]:
				combinedList[0].append("AltaiNea")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(neaList[1].pop(0))
			#we don't want to append the human after the last neandertal yet, it should happen at a later iteration
			break
	return humList, neaList, combinedList


def remainingItems(humList, neaList, combinedList):
	#case 2
	if len(neaList[0]) != 0 and len(humList[0]) != 0:
		humList, neaList, combinedList = mainAlgo(humList, neaList, combinedList)
	#case 3
	elif len(neaList[0]) != 0 and len(humList[0]) == 0:
		neaTemp = copy.deepcopy(neaList)
		for i in range(len(neaTemp[0])):
			if combinedList[2][-1] < neaTemp[1][i]:
				combinedList[0].append("Neandertal")
				combinedList[1].append(combinedList[2][-1] + 1)
				combinedList[2].append(neaList[1].pop(0))
				neaList[0].pop(0)
			else:
				combinedList[0].append("Neandertal")
				combinedList[1].append(neaList[0].pop(0))
				combinedList[2].append(neaList[1].pop(0))
	#case 1
	elif len(neaList[0]) == 0 and len(humList[0]) != 0:
		humTemp = copy.deepcopy(humList)
		for i in range(len(humTemp[0])):
			combinedList[0].append(humList[0].pop(0))
			combinedList[1].append(humList[1].pop(0))
			combinedList[2].append(humList[2].pop(0))
	#re-iterate
	if len(neaList[0]) != 0 or len(humList[0]) != 0:
		humList, neaList, combinedList = remainingItems(humList, neaList, combinedList)
	return humList, neaList, combinedList

		
def mergeHumansOverNea(input):
	humList = [[], [], []]
	neaList = [[], []]
	combinedList = [[], [], []]
	for line in input:
		fields = re.match('(\S+)\s+(\S+)\s+(\S+)',  line)
		ind = fields.group(1)
		segStart = int(fields.group(2))
		segEnd = int(fields.group(3))
		if ind == "Neandertal":
			neaList[0].append(segStart)
			neaList[1].append(segEnd)
		elif ind != "Neandertal":
			humList[0].append(ind)
			humList[1].append(segStart)
			humList[2].append(segEnd)
		if len(neaList[0]) != 0 and len(humList[0]) != 0:
			#if neaEnd < lasthumStart, then compare
			if neaList[1][0] <= humList[1][-1]:
				humList, neaList, combinedList = mainAlgo(humList, neaList, combinedList)
	#after having finished appending from stdin to humList and neaList, applying the algorithm to the remaining parts
	#while len(neaList[0]) > 0 and len(humList[0]) > 0:
	#	if neaList[1][0] < humList[1][0]:
	humList, neaList, combinedList = remainingItems(humList, neaList, combinedList)
	return combinedList


if sys.stdin:
	indiv, indivStart, indivEnd = mergeHumansOverNea(sys.stdin)
	#print(len(indiv),len(indivStart),len(indivEnd))	
	for i in range(len(indiv)):
		print(indiv[i], indivStart[i], indivEnd[i])
else:
	print("You need to pipe in the data", file=sys.stderr)
