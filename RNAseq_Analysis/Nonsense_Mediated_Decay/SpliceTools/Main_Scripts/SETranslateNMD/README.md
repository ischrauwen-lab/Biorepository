# SETranslateNMD

## Basic Protocol For SETranslateNMD Script:

1) Make sure you have an rMats Output directory already created for your experimental groups (such as KnockIn/KnockOut, Timepoint1/Timepoint2 etc.).
2) Modify the SETranslateNMD script so that it has the following inputs (described below):

| Variables | Description |
|----------|----------|
| `rMats_Output_Directory`                  | The path to the rMats output directory for your experimental group.   |
| `bed12_annotation_file`                   | The path to your bed12 annotation file.                               |
| `genome_fasta`                            | Your genome fasta with `chr` added to it.                             |
| `FDR_Value`                               | Your FDR cutoff.                                                      |
| `Splice_Tools_Github_Cloned_Directory`    | The path to your cloned Splicetools Directory.                        |

3) Modify the job scheduling directives as needed.
4) Submit the script to the HPC queue/run it.

**Note:** Your output will be located in your rMats output directory.
