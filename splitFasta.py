import sys, re

with open(sys.argv[1], 'r') as f:
	chr = ""
	for line in f:
		if re.match('\>', line):
			line = line.rstrip()
			chr = line.strip(">")
			with open(chr + ".fa", 'a') as out:
				out.write(">" + chr + '\n')
		else:
			with open(chr + ".fa", 'a') as out:
				out.write(line)
