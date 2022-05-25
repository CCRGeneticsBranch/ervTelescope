# CCRGenetics Branch Snakemake Pipeline Telescope

Transposable element annotations used by [Telescope](https://journals.plos.org/ploscompbiol/article?id=10.1371/journal.pcbi.1006453).

Telescope is a [computational method](https://github.com/mlbendall/telescope) that provides accurate estimation of transposable element expression. 
It directly addresses uncertainty in fragment assignment by reassigning ambiguously mapped fragments to 
the most probable source transcript as determined within a Bayesian statistical model.


# Running the pipeline on [Biowulf](https://hpc.nih.gov/) 

1. Create a folder fastq and add all compressed RNA-seq fastq files to be run with extensions `_R1.fastq.gz` and `_R2.fastq.gz`. Hardlinks and symlinks will also work.

2. The wrapper script `run_ervTelescope.sh` can be used to a. initialize output folder, b. dryrun and c. submit run to cluster
```bash
 % ./run_ervTelescope.sh
Pipeline Dir: /gpfs/gsfs10/users/CCBR_Pipeliner/Pipelines/ervTelescope
Git Commit/Tag: 65f31ef9dad234266f456f37bc984886a7f56216

run_ervTelescope.sh
--> run ervTelescope pipeline

USAGE:
  bash ./run_ervTelescope.sh -m/--runmode=<RUNMODE> -w/--workdir=<WORKDIR>
Required Arguments:
1.  RUNMODE: [Type: String] Valid options:
    *) init : initialize workdir
    *) run : run with slurm
    *) reset : DELETE workdir dir and re-init it
    *) dryrun : dry run snakemake to generate DAG
    *) unlock : unlock workdir if locked by snakemake
    *) runlocal : run without submitting to sbatch
2.  WORKDIR: [Type: String]: Absolute or relative path to the output folder with write permissions.
```

  a. _initialize output folder_

  Output folder needs to be initialized with the following command:

```bash
% bash ./run_ervTelescope.sh -m/--runmode=init -w/--workdir=<PathToOutdir>
```

  b. _dryrun_

  Next, we `cd` to the output folder and edit the `config.yaml` to provide the run-specific user defined data like location of input fastqs, location of bowtie2 reference, genome annotations in GTF format etc. Then, we can dryrun the pipeline to verify that we are ready to submit the run to the cluster with the following command:

```bash
% bash ./run_ervTelescope.sh -m/--runmode=dryrun -w/--workdir=<PathToOutdir>
```

  c. _submit to cluster_

  The pipeline can be submitted to cluster using the following command:

```bash
% bash ./run_ervTelescope.sh -m/--runmode=run -w/--workdir=<PathToOutdir>
```
  
  The above command will submit the master job to the cluster which will the spawn individual snakemake rule-jobs. It returns the master jobid which can be used to track the progress pipeline using a command similar to :

```bash
% squeue -u $USER -j <JOBID>
```