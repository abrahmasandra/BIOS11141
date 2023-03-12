#!/bin/bash
#SBATCH --job-name=test_script
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --account=bios11141
#SBATCH --mem-per-cpu=8192

# Load R
module load R

Rinfile="./CompAsn7source.R"


# Run R
Rscript $Rinfile Homo_sapiens_Chr1.fasta 


#notice how we put "Homo_sapiens_Chr1.fasta" after $Rinfile.  This means that "Homo_sapiens_Chr1.fasta" is an input to our Rscript
