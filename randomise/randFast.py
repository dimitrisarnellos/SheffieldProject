import sys,csv,numpy
from random import shuffle

data = csv.reader(open(sys.argv[1], 'r'), delimiter="\t")
#column = [[] for i in range(444)]
column = []
for i in range(450):
	column.append([])
first9 = []
count = 0

def memEfficient(column, first9, count):
	zero_zero = 0
	zero_one = 0
	one_zero = 0
	one_one = 0
	for i in column:
		i.append(zero_zero)
		i.append(zero_one)
		i.append(one_zero)
		i.append(one_one)



	for row in data:
		first9.append(row[0] + "\t" + row[1] + "\t" + row[2] + "\t" + row[3] + "\t" + row[4] + "\t" + row[5] + "\t" + row[6] + "\t" + row[7] + "\t" + row[8] + "\t")
		for i in range(len(row) - 9):
			#column[i].append(row[9+i])
			if row[9+i] == "0|0":
				column[i][0] += 1
			elif row[9+i] == "0|1":
				column[i][1] += 1
			elif row[9+i] == "1|0":
				column[i][2] += 1
			elif row[9+i] == "1|1":
				column[i][3] += 1
		count += 1
		sys.stderr.write("\r" + "Lines processed: " + str(count))
		sys.stderr.flush()

	sys.stderr.write("\n")

	count2 = 0
	with open('first9', 'a') as out:
		for i in range(len(first9)):
			#print(first9[i], end="")
			out.write(first9[i] + '\n')
	for j in range(450):
		gt = numpy.random.choice(["0|0", "0|1", "1|0", "1|1"], len(first9), p=[column[j][0]/count, column[j][1]/count, column[j][2]/count, column[j][3]/count])
		with open('c' + str(j), 'a') as out:
			if j < 449:
				for k in gt:
					out.write(k + "\t" + "\n")
			else:
				for k in gt:
					out.write(k + "\n")
		#count2 += 2
		sys.stderr.write("\r" + "Individuals randomised: " + str(j))
		sys.stderr.flush()
	
	sys.stderr.write("\n")

def timeEfficient(column, first9, count):
	for row in data:
		first9.append(row[0] + "\t" + row[1] + "\t" + row[2] + "\t" + row[3] + "\t" + row[4] + "\t" + row[5] + "\t" + row[6] + "\t" + row[7] + "\t" + row[8] + "\t")
		for i in range(len(row) - 9):
			column[i].append(row[9+i])
		count += 1
		sys.stderr.write("\r" + "Lines processed: " + str(count))
		sys.stderr.flush()
	for i in range(len(column)):
		shuffle(column[i])
		sys.stderr.write("\r" + "Shuffling column: " + str(i))
		sys.stderr.flush()
	for i in range(len(first9)):
		print(first9[i], end="")
		for j in range(450):
			if j < 449:
				print(column[j][i], end="\t")
			else:
				print(column[j][i])
				
if sys.argv[2] == "mem":
	memEfficient(column, first9, count)
elif sys.argv[2] == "fast":
	timeEfficient(column, first9, count)
else:
	sys.stderr.write('You need to specify "mem" or "fast" if you want the run to be memory or time efficient.' + "\n")