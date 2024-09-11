# CuffDiff

## Scaffold Protocol For CuffDiff

1) Modify the script to have the inputs described below:

| **Variable**           | **Description**                                                          |
|------------------------|--------------------------------------------------------------------------|
| `bam_directory`        | Specify the directory containing the BAM files.                          |
| `output_directory`     | Specify the output directory.                                              |
| `reference_genome`     | Specify the path to the reference FASTA file.                              |
| `annotation_gtf`       | Specify the path to the annotation GTF file.                               |


2) Modify the module `Cufflinks` for the latest version.
3) Add job scheduling directives.
4) `chmod +x` the script.
5) Run the script.
