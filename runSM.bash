#!/usr/bin/env bash

conda env create -f workflow/envs/environment_telescope.yml --force
source /data/$USER/conda/etc/profile.d/conda.sh
conda activate telescope_env

module load snakemake/5.5.2 

snakemake  -s workflow/Snakefile --printshellcmds -j 50 --rerun-incomplete --keep-going --cluster "sbatch  --cpus-per-task 24 -t 120:00:00 --mem 96g"


