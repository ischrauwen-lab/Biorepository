# Step 3: Renaming Relevant Columns And Merging Into One Table
# Step 3 Part 2: Merging All Part 1 Samples Into One Table

**Description:**

This part merges all the SampleNameNon_Edited_Count, SampleNameEdited_Count and the SampleNameEdited_Count_Proportion together via an inner join effectively retaining only the rows that intersect by Region_Position for all the samples.

## Protocol

1) Edit the R script found in the `Part_2___MergingAllSampleTSVsIntoOneTable` to have the following inputs:

| Variable | Description |
| --------------- | --------------- |
| `output_directory_path`    | The path to the merging into one table directory    |
| `subfolder_name_part_1`    | The name of the Part 1 folder in this case `Part_1___RenamingRelevantColumnsPerSampleTSV"`    |
| `subfolder_name_part_2`    | The name of the Part 2 subfolder that you want in this case `"Part_2___MergedSamplesIntoOneTable"`. This will be the folder created in the `output_directory_path` folder for your outputs.    |

2) Edit the bash script (found in the `Part_2___MergingAllSampleTSVsIntoOneTable` directory) used to execute the Rscript. It requires one path in the variable `RSCRIPT_DIR` which is the path to the directory containing the R script. After the `Rscript` command you need to put the name of the R script in this case `Part_2___Rscript_MergingAllTSVsIntoOneTable.R`. 
3) Run the bash script and this bash script will execute the R script.
