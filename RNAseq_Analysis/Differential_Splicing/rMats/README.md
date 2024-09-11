# rMats

This script uses the software [rMats-turbo](https://github.com/Xinglab/rmats-turbo). It uses it via the [McFonsecaLab/rMats docker](https://hub.docker.com/r/mcfonsecalab/rmats) which was pulled via singularity.

## Scaffold Protocol For rMats Script:

1) Edit the script to have the inputs described below:

| **Variable**              | **Description**                                                                  |
|---------------------------|----------------------------------------------------------------------------------|
| `s1_file`                 | Paths to control fq files reference file.                                         |
| `s2_file`                 | Paths to experiment fq files reference file.                                      |
| `gtf_file`                | The full path to the GTF file.                                                                     |
| `output_directory`        | The full path to the output directory.                                                          |
| `star_binary_index`       | The full path to the STAR Binary (Ensembl), sometimes referred to as STAR reference.                    |
| `singularity_image`       | The full path to the rmats-turbo singularity image.                              |
| `RMATS_SCRIPT`            | The relative path to the rmats.py script within the Singularity container.            |

2) Add in the job scheduling directives.
3) Edit the modules loaded. We used the following:

| **Software**   | **Version** |
|----------------|-------------|
| Samtools       | 1.17        |
| Singularity    | 3.9.4       |
| STAR           | 2.7.10b     |


4) `chmod +x` the script.
5) Run the script. 
