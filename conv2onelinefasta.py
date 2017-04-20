# Programme that converts multiline FASTA to one-line FASTA
# User should provide the file as the first argument. One-line FASTA conversion is outputed to stdout.

import sys, re

seq = ''
with open(sys.argv[1], 'r') as f:
	for line in f:
		if re.match('\>', line):
			line = line.rstrip()
			if seq != '':
				print(seq)
				seq = ''
			print(line)
		else:
			line = line.rstrip()
			seq += line
	print(seq)
