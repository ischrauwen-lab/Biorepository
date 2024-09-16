# Step 07: Merge In

This can be done per pre-filtration type.

## Scaffold Protocol For Step 07: Merge In

### Part 0: Merging In Step 1 Files

#### SubPart 1: Renamine Relevant Column Names Per Sample Data

1) Edit the bash script in the Step 07 Merge In Part 0 Merge In Step 1 Files SubPart 1 Renaming Relevant Columns directory to have the information described below:

| Variables       | Descriptions |
|----------------|----------|
| `input_directory`     | Path to the Step 1 Removed K And Mitochondrial contigs directory   | 
| `output_directory`    | Path to the output directory   |

2) Edit the job scheduling directives as needed.
3) Run the bash script.

#### SubPart 2: Merging In Step 1 Files Main

1) Edit the R script in the relevant directory to have the following inputs:

| Variable | Description |
|-----------------|-----------------|
| `input_directory`           | Path to the step 7 part 1 subpart 1 folder         |
| `output_directory`          | Path to the step 7 part 1 subpart 2 folder         | 
| `base_file_name`            | The basname you wish to use for your output        |
| `Control_File_Prefix`       | The prefix used for control samples only           |
| `Experiment_File_Prefix`    | The prefix used for experimental samples only      |
| `lowest_number_experiment`  | The lowest number/ID for the experimental samples  | 
| `highest_number_experiment` | The highest number/ID for the experimental samples |
| `lowest_number_control`     | The lowest number/ID for controls                  |
| `highest_number_control`    | The highest number/ID for controls                 |

2) Edit the bash script job directives as needed.
3) Edit the input in the bash script:

| Variable       | Description |
|----------------|----------|
| `RSCRIPT_PATH`     | The full path to the R script |

4) Run the bash script.

### Part 1: Breakdown Via Pre-Filtration Type

#### SubPart 0: Merge In Proportions

1) Edit the SubPart 0 `ipynb` to have the following:

| Variable       | Description |
|----------------|----------|
| `Step_3___Part_2_Directory`     | The full path to the Step 3 Part 2 directory |
| `Step_6___Output_TSV`     | The full path to the Step 06 REDITs Regression Pre-Filtration type `tsv` |
| `output_directory`     | The full path to the `Step_07___MergeIn/Part_1___BreakDown_By_PreFiltration_Type/PreFiltration_Type` |
| `subfolder_name`     | Name of your subfolder |

2) Run the `ipynb`. 

#### SubPart 1: Merge In Outputs

1) Edit the R script in this directory:

| Variable       | Description |
|----------------|----------|
| `Step_1___Merged`                                 | Path to the Step 07 Part 0 SubPart 2 `tsv` file   |
| `MergedInEditedNonEditedCountsAndProportions`     | Path to the Step 07 Part 1 SubPart 0 tsv file     | 
| `output_directory`                                | Path to the output directory                      |

2) Edit the bash script to have the following:

| Variable       | Description |
|----------------|----------|
| `RSCRIPT_PATH`     | Path to the R script |

3) Run the bash script to run the R script.
