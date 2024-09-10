# Manta

* Comments used in each script are relatively self explanatory however, in the parallel there is one job directive that specifies an array `#SBATCH --array=1-n` here n is equal to the number of bams.


## Parallelized Version Scaffold Protocol:


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
