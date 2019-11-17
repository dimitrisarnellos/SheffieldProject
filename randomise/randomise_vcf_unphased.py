import sys
import csv
import itertools
import argparse
import numpy
import pandas as pd

parser = argparse.ArgumentParser(description='Randomise genotypes of all populations in a VCF file.')
parser.add_argument('--vcf', help='VCF file', required=True)
parser.add_argument('-o', '--output', help='Output file')
args = parser.parse_args()


def remove_vcf_header(vcf_file):
	for line in vcf_file:
		if line[0] == '#':
			continue
		yield line


def init_variables(data):
	for row in data:
		row_len = len(row)
		break
	column = []
	for i in range(row_len - 9):
		column.append([])
	first9 = []
	count = 0
	return column, first9, count, row_len


def randomise_genotypes(vcf_file):
	'''
	Counts the thre genotype types of each individual to have a matrix
	of genotype probabilities so that later the genotype occurence
	is being taking into account when repopulating by randomisation.
	So for individual j, the probability is column[j][0]/count for
	genotype 0|0 in a certain position to be picked.
	'''
	data = csv.reader(remove_vcf_header(open(vcf_file, 'r')), delimiter="\t", )
	data_first_row, data_all_rows = itertools.tee(data)
	column, first9, count, row_len = init_variables(data_first_row)
	del(data_first_row)
	# row_len - 9 for the 9 first non genotype columns
	individuals = row_len - 9
	zero_zero = 0
	zero_one = 0
	one_one = 0
	for i in column:
		i.append(zero_zero)
		i.append(zero_one)
		i.append(one_one)

	# this part counts occurences of genotypes in individuals. I need to break up this function
	for row in data_all_rows:
		first9_row = []
		for initial_column_no in range(9):
			first9_row.append(row[initial_column_no])
		first9.append(first9_row)


		for individual_no in range(individuals):
			#column[i].append(row[9+i])
			if row[9 + individual_no] == "0/0":
				column[individual_no][0] += 1
			elif row[9 + individual_no] == "0/1":
				column[individual_no][1] += 1
			elif row[9 + individual_no] == "1/1":
				column[individual_no][2] += 1
		count += 1
		sys.stderr.write("\r" + "Lines processed: " + str(count))
		sys.stderr.flush()
	df9 = pd.DataFrame(first9)

	sys.stderr.write("\n")

	# this part populates the randomised individuals based on their genotype frequences
	for individual_no in range(individuals):
		gt = numpy.random.choice(["0/0", "0/1", "1/1"], count, p=[column[individual_no][0]/count, column[individual_no][1]/count, column[individual_no][2]/count])

		# append to dataframe
		df9['c' + str(individual_no)] = ""
		df9['c' + str(individual_no)] = pd.Series(gt).values

		sys.stderr.write("\r" + "Individuals randomised: " + str(individual_no + 1))
		sys.stderr.flush()
	
	sys.stderr.write("\n")

	# output to file
	with open(args.output, 'w') as output_file:
		# output header
		with open(args.vcf, 'r') as vcf_file:
			for line in vcf_file:
				if line[0] == '#':
					 output_file.write(line)
				# once line not header, stop loop
				else:
					break
		# output body
		df9.to_csv(output_file, header=False, sep='\t', index=False)


if __name__ == '__main__':

	randomise_genotypes(args.vcf)
