import sys,re

'''
I made the mainLogic function so that I dont have to repeat two times the same thing if the source file is in different format but I didnt make it work
'''
def mainLogic(fields, prevst, prevend, type):
	reIndex = []
	if type == "ibd":
		reIndex.append(2)
		reIndex.append(3)
	else:
		reIndex.append(1)
		reIndex.append(2)
	if prevst == 0:
		#print(fields.group(reIndex[0]))
		prevst = int(fields.group(reIndex[0]))
		prevend = int(fields.group(reIndex[1]))
		next
	elif int(fields.group(2)) <= prevend:
		prevend == int(fields.group(reIndex[0]))
	else:
		print(prevst, prevend)
		prevst = int(fields.group(reIndex[0]))
		prevend = int(fields.group(reIndex[1]))

def merge(input):
	begin = True
	previousStart = 0
	previousEnd = 0
	for line in input:
		if re.match('(\S+\s+){5}(\S+)\s+(\S+)',  line):
			fields = re.match('(\S+\s+){5}(\S+)\s+(\S+)',  line)
			#mainLogic(fields, previousStart, previousEnd, "ibd")
			if begin == True:
				previousStart = int(fields.group(2))
				previousEnd = int(fields.group(3))
				begin = False
			elif int(fields.group(2)) <= previousEnd and int(fields.group(3)) <= previousEnd:
				continue
			elif int(fields.group(2)) <= previousEnd and int(fields.group(3)) > previousEnd:
				previousEnd = int(fields.group(3))
			else:
				print(previousStart, previousEnd)
				previousStart = int(fields.group(2))
				previousEnd = int(fields.group(3))
		else:
			fields = re.match('(\S+)\s+(\S+)', line)
			#mainLogic(fields, previousStart, previousEnd, "noibd")
			if begin == True:
				previousStart = int(fields.group(1))
				previousEnd = int(fields.group(2))
				begin = False
			elif int(fields.group(1)) <= previousEnd and int(fields.group(2)) <= previousEnd:
				continue
			elif int(fields.group(1)) <= previousEnd and int(fields.group(2)) > previousEnd:
				previousEnd = int(fields.group(2))
			else:
				print(previousStart, previousEnd)
				previousStart = int(fields.group(1))
				previousEnd = int(fields.group(2))
	print(previousStart, previousEnd)

if len(sys.argv) > 1:
	with open(sys.argv[1], 'r') as f:
		merge(f)

if sys.stdin:
	merge(sys.stdin)
