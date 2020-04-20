#!/usr/bin/env python

import drmaa
import os
import argparse
import subprocess
import csv

parser = argparse.ArgumentParser(description='Randomise genotypes of all populations in a VCF file.')
parser.add_argument('-p', '--population', help='Population abbreviation', required=True)
parser.add_argument('-n', '--number', help='Number of individuals')
args = parser.parse_args()

individuals_file = 'integrated_call_samples_v3.20130502.ALL.panel'
individuals_file_url = 'ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/integrated_call_samples_v3.20130502.ALL.panel'


def exract_individuals(individuals_file, population, individuals_number):

    individuals_to_keep = []
    with open(individuals_file) as csvfile:
        f = csv.reader(csvfile, delimiter='\t')
        counter = 0
        for row in f:
            if row[1] == population:
                counter += 1
                if counter <= individuals_number:
                    individuals_to_keep.append(row[0])
        individuals_to_keep.append('DenisovaPinky')
    
    return write_to_file(individuals_to_keep, population, individuals_number)


def write_to_file(individuals_to_keep, population, individuals_number):
    list_name = str(population) + str(individuals_number) + 'Den' + '.list'
    with open(list_name, 'w') as f:
        print(*individuals_to_keep, file=f, sep='\n')

    return list_name


def create_individuals_list(population, individuals_number):
    if not os.path.exists('integrated_call_samples_v3.20130502.ALL.panel'):
        subprocess.run('wget ' + individuals_file_url, check=True, shell=True)

    return exract_individuals(individuals_file, population, individuals_number)


def decide_source_dataset(individuals_number, chromosome):
    if int(individuals_number) > 30:
        chromosome_file = 'ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.chr' + str(chromosome) + '.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz'
        if not os.path.exists('../ALL.chr' + str(chromosome) + '.phase3_shapeit2_mvncall_integrated_v5a.20130502.genotypes.vcf.gz'):
            subprocess.run('wget -P ../ ' + chromosome_file, check=True, shell=True)
            subprocess.run('wget -P ../ ' + chromosome_file + '.tbi', check=True, shell=True)

        return '/home/bo4da/Scripts/create-dataset-job.sh'
    else:
        return '/home/bo4da/Scripts/bcftools-job.sh'


def main():
    """
    Create a DRMAA session then submit a job.s
    """

    list_name = create_individuals_list(args.population, int(args.number))
    workdir = args.population + args.number

    os.makedirs(workdir, exist_ok=True)
    os.chdir(workdir)

    with drmaa.Session() as s:
        for chromosome in range(1, 23):

            jt = s.createJobTemplate()
            # The job is to run an executable in the current working directory
            jt.remoteCommand = decide_source_dataset(args.number, chromosome)
            # Arguments to the remote command
            jt.args = [str(chromosome), '../' + list_name]
            # Join the standard output and error logs
            jt.joinFiles = True
            # jt.nativeSpecification = '-l h_rt=03:00:00 -l rmem=8G'
            jt.jobName = args.population + args.number + 'chr' + str(chromosome)

            job_id = s.runJob(jt)
            print('Job {} submitted'.format(job_id))

            s.deleteJobTemplate(jt)


if __name__ == '__main__':
    main()