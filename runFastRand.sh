#!/bin/bash

#$ -m ea
#$ -M bo4da@sheffield.ac.uk

module load apps/python/anaconda3-4.2.0
python /home/bo4da/Scripts/randFast.py ../nomultiBodyfinal fast > vcfbod
