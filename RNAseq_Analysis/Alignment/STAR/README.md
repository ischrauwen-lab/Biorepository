# STAR (Spliced Transcripts Alignment to a Reference) Pipleine Scripts

Here we used [STAR](https://github.com/alexdobin/STAR) (Spliced Transcripts Alignment to a Reference) to create a small pipeline for alignment of files.

## Protocol:

### Step 1: Generating The STAR Reference

1) The necessary paths are described below:

| **Variables**            | **Descriptions**                                                                                   | **Example Inputs**                |
|-------------------------|---------------------------------------------------------------------------------------------------|----------------------------------|
| `Genome_FASTA`          | Full path to the fasta reference genome for alignment from Ensembl.                                    | `"/path/to/genome_fasta.fa"`     |
| `Annotation_GTF`        | Full path to the GTF file.                                                                             | `"/path/to/annotation.gtf"`      |
| `Reference`             | Full path to the reference genome directory.                                                           | `"/path/to/reference_dir"`       |

2) Modify the versions of the modules (STAR and SAMtools for the latest version) as needed.

3) Edit the job scheduling directives as needed.
4) `chmod +x` the script.
5) Run the script.

### Step 2: Re-alignment

1) The necessary paths are described below:
 
| **Variables**            | **Descriptions**                                                                           | **Example Inputs**                |
|-------------------------|-------------------------------------------------------------------------------------------|----------------------------------|
| `Genome_FASTA`          | Full path to the genome FASTA file.                                                              | `"/path/to/genome_fasta.fa"`     |
| `Annotation_GTF`        | Full path to the annotation GTF file.                                                            | `"/path/to/annotation.gtf"`      |
| `Input_Directory`       | Full path to the input directory containing FASTQ files.                                         | `"/path/to/input_directory"`     |
| `Output_Directory`      | Full path to the output directory for alignment results.                                         | `"/path/to/output_directory"`    |
| `Reference`             | Full path to the created STAR reference genome directory in Step 1.                              | `"/path/to/star_reference_dir"`  |
| `Number_Of_Threads`     | Choose the number of threads for alignment (15 is placed here but it can be changed).            | `15`                             |

2) Modify the versions of the modules (STAR and SAMtools for the latest version) as needed.
3) Edit the job scheduling directives as needed.
4) `chmod +x` the script.
5) Run the script.
