import sys,csv
from random import shuffle

data = csv.reader(open(sys.argv[1], 'r'), delimiter="\t")
column = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], [], []]

first9 = []
count = 0
for row in data:
	first9.append(row[0] + "\t" + row[1] + "\t" + row[2] + "\t" + row[3] + "\t" + row[4] + "\t" + row[5] + "\t" + row[6] + "\t" + row[7] + "\t" + row[8] + "\t")
	for i in range(30):
		column[i].append(row[340+i])
	count += 1
	sys.stderr.write("\r" + "Lines processed: " + str(count))
	sys.stderr.flush()

for i in range(len(column)):
	shuffle(column[i])
for i in range(len(first9)):
	print(first9[i], end="")
	for j in range(30):
		if j < 29:
			print(column[j][i], end="\t")
		else:
			print(column[j][i])