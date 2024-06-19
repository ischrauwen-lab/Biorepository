# SE Fraction Expressed:

## Protocol:

1) Make sure you have an rMats Output directory already created for your experimental groups (such as Timepoint1/Timepoint2, KnockIn/KnockOut etc.).
2) Modify the SEFractionExpressed script so that it has the following inputs (described below):

| Variables | Description |
|----------|----------|
| `rMats_Output_Directory`    | The path to the rMats output directory for your experimental group.   |
| `expression_file`    | The path to your expression file.   |
| `sample_numbers`    | Your control and experimental sample numbers.   |
| `min_tpms_condition`    | Your minimum tpms per condition.   |
| `fdr`    | Your FDR cutoff.  |
| `Splice_Tools_Github_Cloned_Directory`    | The path to your cloned Splicetools Directory.   |


3) Modify the job scheduling directives as needed.
4) Submit the script to the HPC queue/run the script.

**Note:** Your output will be located in your rMats output directory.
