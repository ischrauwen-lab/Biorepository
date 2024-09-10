# Step 03: Renaming And Merging In Relevant Columns Into One Table

## Protocol For Step 03: Renaming And Merging In Relevant Columns Into One Table:

### Step 03 Part 1: Rename Individual Sample Files To Have The Sample Name In The Column Name

**Note(s):**

* This will extract the name of the file based on the first `_`

**Description:**

This part renames 3 columns the Non_Edited_Count, Edited_Count and the Edited_Count_Proportion to contain the sample id/name/identifier as a prefix. 

1) Edit the `input_directory_path` in the R script (found in Step 3 Merging Into One Tables Part 1 subfolder) to have the path to the Step_02 Removal Of K Contigs And Mitochondrial Transcripts directory.
2) Edit the bash script used to execute the Rscript. It requires one path in the variable `RSCRIPT_DIR` which is the path to the directory containing the R script. After the `Rscript` command you need to put the name of the R script in this case `Part_2___RenamingColumnsFor_NonEditedCount_EditedCount_And_EditedCountProportion.R`. 
3) Run the bash script and this bash script will execute the R script.

### Step 3 Part 2: The Main Merge Step

**Description:**

This part merges all the SampleNameNon_Edited_Count, SampleNameEdited_Count and the SampleNameEdited_Count_Proportion together via an inner join effectively retaining only the rows that intersect by Region_Position for all the samples.

1) Edit the R script found in the step 03 part 2 directory to have the following inputs:

| Variable | Description |
| --------------- | --------------- |
| `output_directory_path`    | The path to the merging into one table directory    |
| `subfolder_name_part_1`    | The name of the Part 1 folder in this case `Part_1___RenamingRelevantColumnsPerSampleTSV"`    |
| `subfolder_name_part_2`    | The name of the Part 2 subfolder that you want in this case `"Part_2___MergedSamplesIntoOneTable"`. This will be the folder created in the `output_directory_path` folder for your outputs.    |

2) Edit the bash script (found in the `Part_2___MergingAllSampleTSVsIntoOneTable` directory) used to execute the Rscript. It requires one path in the variable `RSCRIPT_DIR` which is the path to the directory containing the R script. After the `Rscript` command you need to put the name of the R script in this case `Part_2___Rscript_MergingAllTSVsIntoOneTable.R`. 
3) Run the bash script and this bash script will execute the R script.
