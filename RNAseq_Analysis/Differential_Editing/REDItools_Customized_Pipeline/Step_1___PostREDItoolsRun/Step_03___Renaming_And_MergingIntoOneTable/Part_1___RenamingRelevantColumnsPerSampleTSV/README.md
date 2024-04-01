# Step 03: Renaming And Merging In Relevant Columns Into One Table
# Part 1: Renaming Relevant Colummns Per Sample `tsv`

## Protocol:

**Note(s):**

* This will extract the name of the file based on the first `_`

**Description:**

This part renames 3 columns the Non_Edited_Count, Edited_Count and the Edited_Count_Proportion to contain the sample id/name/identifier as a prefix. 

1) Edit the `input_directory_path` in the R script (found in Step 3 Merging Into One Tables Part 1 subfolder) to have the path to the Step_02 Removal Of K Contigs And Mitochondrial Transcripts directory.
2) Edit the bash script (found in the `Part_1___RenamingRelevantColumnsPerSampleTSV` directory) used to execute the Rscript. It requires one path in the variable `RSCRIPT_DIR` which is the path to the directory containing the R script. After the `Rscript` command you need to put the name of the R script in this case `Part_1___SubPart_2___RenamingRelevantColumnsPerSampleTSV.R`. 
3) Run the bash script and this bash script will execute the R script.
