import sys,re

if sys.stdin:
	for line in sys.stdin:
		line = re.split(r'\s+', line.rstrip())
		for i in range(len(line)):
			if i > 2 and line[i] != "DenisovaPinky" and line[i] != "AltaiNea" and not re.match('.*(\.){1}.{1}$', line[i]):
				print(line[1], line[2], line[i], sep = "\t")
