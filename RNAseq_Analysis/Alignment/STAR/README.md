# STAR Scripts

## Protocol:

### Step 1: Generating The STAR Reference

1) The necessary paths are described below:

| **Variable**            | **Description**                                                                                   | **Example Inputs**                |
|-------------------------|---------------------------------------------------------------------------------------------------|----------------------------------|
| `Genome_FASTA`          | Path to the fasta reference genome for alignment from Ensembl.                                    | `"/path/to/genome_fasta.fa"`     |
| `Annotation_GTF`        | Path to the annotation GTF file.                                                                  | `"/path/to/annotation.gtf"`      |
| `Reference`             | Path to the reference genome directory.                                                           | `"/path/to/reference_dir"`       |

2) Modify the versions of the modules for STAR and SAMtools for the latest version as needed.

3) Edit the job scheduling directives as needed.
4) `chmod +x` the script.
5) Run the script.

### Step 2: Re-alignment

1) The necessary paths are described below:
 
| **Variable**            | **Description**                                                                           | **Example Inputs**                |
|-------------------------|-------------------------------------------------------------------------------------------|----------------------------------|
| `Genome_FASTA`          | Path to the genome FASTA file.                                                             | `"/path/to/genome_fasta.fa"`     |
| `Annotation_GTF`        | Path to the annotation GTF file.                                                            | `"/path/to/annotation.gtf"`      |
| `Input_Directory`       | Path to the input directory containing FASTQ files.                                        | `"/path/to/input_directory"`     |
| `Output_Directory`      | Output directory for alignment results.                                                     | `"/path/to/output_directory"`    |
| `Reference`             | Created STAR reference genome directory.                                                    | `"/path/to/star_reference_dir"`  |
| `Number_Of_Threads`     | Choose the number of threads for alignment (15 is placed here but it can be changed).       | `15`                             |

2) Modify the versions of the modules as needed.
3) Edit the job scheduling directives as needed.
4) `chmod +x` the script.
5) Run the script.
