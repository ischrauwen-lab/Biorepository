# rMats2sashimiPlot

This script uses the software [rMats2sashimiPlot](https://github.com/Xinglab/rmats2sashimiplot). It uses it via the [McFonsecaLab/rMats docker](https://hub.docker.com/r/mcfonsecalab/rmats) which was pulled via singularity.

## Scaffold Protocol For rMats2sashimiPlot:

1) Edit the script to have the inputs described below:

| **Variable**                | **Description**                                                                           |
|-----------------------------|-------------------------------------------------------------------------------------------|
| `bam_directory`             | The full path to the directory containing BAM files.                                                |
| `output_directory`          | The full path to the output directory.                    |
| `rMats_Output_Directory`    | The full path to the directory where the rMats output is located.                                    |
| `singularity_image`         | The full path to the rMats2sashimiplot Singularity image.                                           |
| `event_type`                | The event type. We used `SE`.             |
| `exon_skip`                 | How much to scale down exons                                               |
| `intron_skip`               | How much to scale down introns                                              |

2) Add in the job scheduling directives.
3) `chmod +x` the script.
4) Run the script.
