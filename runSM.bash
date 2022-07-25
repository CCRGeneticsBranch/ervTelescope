#!/usr/bin/env bash


module load snakemake/5.5.2 
module load singularity
snakemake --use-singularity --singularity-args " -B /data/khanlab/ "  -s workflow/Snakefile --printshellcmds -j 50 --rerun-incomplete --keep-going --cluster "sbatch  --cpus-per-task 24 -t 120:00:00 --mem 96g" --directory "/data/khanlab/projects/singularity_erv" --configfile "/data/khanlab/projects/testing_ERV_pipeline/ervTelescope/config/config.yaml"


