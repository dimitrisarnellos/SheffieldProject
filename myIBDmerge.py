import sys,re


def merge(input):
	begin = True
	previousStart = 0
	previousEnd = 0
	for line in input:
		if re.match('(\S+\s+){5}(\S+)\s+(\S+)',  line):
			fields = re.match('(\S+\s+){5}(\S+)\s+(\S+)',  line)
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
