# Manta

Manta is useful for CNV calling. Please refer to the [Illumina Manta github repository](https://github.com/Illumina/manta/tree/master) for more specific information on the software.


## Scaffold Protocols:

These protocols are intended to inform users how to use the scripts we created to run Manta on our data.

### Regular Version Scaffold Protocol:

1) The inputs for the regular versiona are as follows:

| **Variable**            | **Description**                                              | **Example Path**                                                      |
|-------------------------|--------------------------------------------------------------|------------------------------------------------------------------------|
| `reference`             | Path to the reference FASTA file                             | `/path/to/your/reference.fasta`                                       |
| `input_dir`             | Directory where filtered BAM files are located              | `/path/to/filtered/bams`                                               |
| `MANTA_INSTALL_PATH`    | Hard-coded installation path for Manta software             | `/path/to/manta-version.release_src/install`                            |


2) Adjust the job scheduling directives as needed.
3) Run the script.

### Parallelized Version Scaffold Protocol:

* Comments used in each script are relatively self explanatory however, in the parallel there is one job directive that specifies an array `#SBATCH --array=1-n` here n is equal to the number of bams.

1) The inputs for the parallelized versiona are as follows:

| **Variable**            | **Description**                                              | **Example Path**                                                      |
|-------------------------|--------------------------------------------------------------|------------------------------------------------------------------------|
| `input_dir`             | Directory where original BAM files are located                                          | `/path/to/Manta/Batch_Run`                                             |
| `output_dir`            | Directory for outputs, including genomes without Manta Exome Flag and Evidence BAM Flag | `/path/to/directory/of/your/choice/Manta_Genome_Outputs_Plus_EvidenceBAMFlag` |
| `table_file`            | Path for the Markdown table output                                                      | `/path/to/choose/for/your/md/table/Descriptor___WithEvidenceBAMsAdded.md` |
| `reference`             | Path to the reference FASTA file                                                        | `/path/to/your/reference.fasta`                                       |
| `MANTA_INSTALL_PATH`    | Installation path for Manta software                                                    | `/path/to/manta-1.6.0.release_src/install`                             |

2) Adjust the job scheduling directives as needed. *WARNING:* The job scheduling directives for SGE are significantly different.
3) Run the script. 
