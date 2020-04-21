#!/usr/bin/env python

import drmaa
import os
import argparse
import subprocess
import csv
from collections import Counter

parser = argparse.ArgumentParser(description='Builds dataset from 1000genomes together with the Denisovan.')
parser.add_argument('-n', '--number', help='Number of individuals per population', required=True)
parser.add_argument('-m', '--mode', choices=['vanilla', 'full'], default='vanilla', help='Vanilla mode for selecting panel of default 15 populations, full mode for selecting all individuals', required=True)
args = parser.parse_args()


def write_to_file(population_file, individual):
    with open(population_file, 'a') as f:
        print(individual, file=f)


def population_lists(individuals_file):
    with open(individuals_file) as csvfile:
        f = csv.reader(csvfile, delimiter='\t')
        population = Counter()
        for row in f:
            population[row[1]] += 1
            population_file = row[1] + '.list'
            individual = row[0]

            if os.path.exists(population_file) and population[row[1]] == 1:
                os.remove(population_file)
            write_to_file(population_file, individual)


def get_source_files(chromosome):
    chromosome_file = 'ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr' + str(chromosome) + '.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz'

    if not os.path.exists('../ALL.chr' + str(chromosome) + '.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz'):
        subprocess.run('wget -P ../ ' + chromosome_file, check=True, shell=True)
        subprocess.run('wget -P ../ ' + chromosome_file + '.tbi', check=True, shell=True)

 
def main():
    """
    Create a DRMAA session then submit a job.s
    """
    individuals_file = 'integrated_call_samples_v3.20130502.ALL.panel'
    individuals_file_url = 'ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel'
    if not os.path.exists(individuals_file):
        subprocess.run('wget ' + individuals_file_url, check=True, shell=True)

    population_lists(individuals_file)

    workdir = 'Global' + args.mode + args.number

    os.makedirs(workdir, exist_ok=True)
    os.chdir(workdir)

    with drmaa.Session() as s:
        for chromosome in range(1, 23):

            get_source_files(chromosome)
            jt = s.createJobTemplate()
            # The job is to run an executable in the current working directory
            jt.remoteCommand = '/home/bo4da/Scripts/create_datasets/create-global-dataset-job.sh'
            # Arguments to the remote command
            jt.args = [str(chromosome), args.mode, args.number]
            # Join the standard output and error logs
            jt.joinFiles = True
            # jt.nativeSpecification = '-l h_rt=03:00:00 -l rmem=8G'
            jt.jobName = 'Global' + args.mode + 'chr' + str(chromosome)

            job_id = s.runJob(jt)
            print('Job {} submitted'.format(job_id))

            s.deleteJobTemplate(jt)


if __name__ == '__main__':
    main()
