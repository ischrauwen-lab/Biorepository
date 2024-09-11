# CuffDiff

Here we used the software [Cufflinks](http://cole-trapnell-lab.github.io/cufflinks/install/) and in particular CuffDiff.

## Scaffold Protocol For CuffDiff

1) Modify the script to have the inputs described below:

| **Variable**           | **Description**                                                          |
|------------------------|--------------------------------------------------------------------------|
| `bam_directory`        | The full path to the directory containing the BAM & BAI files.     |
| `output_directory`     | The full path to the output directory.                             |
| `reference_genome`     | The full path to the reference FASTA.                              |
| `annotation_gtf`       | The full path to the GTF file.                                     |


2) Modify the module `Cufflinks` for the latest version.
3) Add job scheduling directives.
4) `chmod +x` the script.
5) Run the script.
