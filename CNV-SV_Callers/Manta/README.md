This folder contains the script used to run Manta on a group of samples. For the Illumina Manta documentation please look [here](https://github.com/Illumina/manta).

In order to run the script you can `qsub` or `./` but the first path that needs to be provided when running it is the path to the reference fasta and the the second path that needs to be provided is the path to the folder containing the `.bam` files.

**Scaffold:**

```bash
./script.sh /path/to/reference.fa /path/to/bam_folder
```

The output will be in a sub-directory of the bam folder and the sub-directory will be called `Manta_Outputs`.
