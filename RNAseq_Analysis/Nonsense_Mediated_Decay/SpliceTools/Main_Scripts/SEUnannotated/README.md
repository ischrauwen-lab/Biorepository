# SE UnAnnotated:

## Basic Protocol:

1) Make sure you have an rMats Output directory already created for your experimental groups (such as Timepoint1/Timepoint2, KnockIn/KnockOut etc.).
2) Modify the SEUnannotated script so that it has the following inputs (described below):

| Variables | Description |
|----------|----------|
| `rMats_Output_Directory`    | The path to the rMats output directory for your experimental group.   |
| `bed12_annotation_file`    | The path to the bed12 file.   |
| `fdr`    | Your FDR cutoff.  |
| `Splice_Tools_Github_Cloned_Directory`    | The path to your cloned Splicetools Directory.   |


3) Modify the job scheduling directives as needed.
4) Submit the script to the HPC queue/run it.

**Note:** Your output will be located in your rMats output directory.
