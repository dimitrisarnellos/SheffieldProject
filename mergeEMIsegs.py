import sys,re


def merge(input):
	begin = True
	previousStart = 0
	previousEnd = 0
	previousIndiv = ""
	for line in input:
		fields = re.match('(\S+)\s+(\S+)\s+(\S+)', line)
		if begin == True:
			previousStart = int(fields.group(1))
			previousEnd = int(fields.group(2))
			previousIndiv = fields.group(3)
			begin = False
		elif int(fields.group(1)) <= previousEnd and int(fields.group(2)) <= previousEnd and previousIndiv == fields.group(3):
			continue
		elif int(fields.group(1)) <= previousEnd and int(fields.group(2)) > previousEnd and previousIndiv == fields.group(3):
			previousEnd = int(fields.group(2))
		else:
			print(previousStart, previousEnd, previousIndiv, sep="\t")
			previousStart = int(fields.group(1))
			previousEnd = int(fields.group(2))
			previousIndiv = fields.group(3)
	print(previousStart, previousEnd, previousIndiv, sep="\t")

if len(sys.argv) > 1:
	with open(sys.argv[1], 'r') as f:
		merge(f)

if sys.stdin:
	merge(sys.stdin)
