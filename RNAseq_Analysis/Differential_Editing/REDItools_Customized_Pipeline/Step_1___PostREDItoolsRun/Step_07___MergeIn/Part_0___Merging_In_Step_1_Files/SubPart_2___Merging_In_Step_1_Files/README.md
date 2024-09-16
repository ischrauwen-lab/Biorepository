# Step 07 Merge In Part 0 Merging In Step 1 Files SubPart 2 Merging In Step 1 Files Main

## Protocol Step 07 Merge In Part 0 Merging In Step 1 Files SubPart 2 Merging In Step 1 Files Main

1) Edit the R script in the relevant directory to have the following inputs:

| Variable | Description | Scaffold/Example Inputs Used |
|-----------------|-----------------|-----------------|
| `input_directory` | Path to the step 7 part 1 subpart 1 folder  | `"/path/to/Step_07___MergeIn/Part_0___MergingInStep1Files/SubPart_1___RenamingRelevantColumnsDirectory"` |
| `output_directory` | Path to the step 7 part 1 subpart 2 folder | `"/path/to/Step_07___MergeIn/Part_0___MergingInStep1Files/SubPart_2___MergeAllStep1___Final"` |
| `base_file_name` | The basname you wish to use for your output  | `"DescriptorOfYourChoice"` |
| `Control_File_Prefix` | The prefix used for control samples only         | `"Control"` |
| `Experiment_File_Prefix` | The prefix used for experimental samples only | `"Experimental"` |
| `lowest_number_experiment` | The lowest number/ID for the experimental samples   | `1` |
| `highest_number_experiment` | The highest number/ID for the experimental samples | `3` |
| `lowest_number_control` | The lowest number/ID for controls                      | `1` |
| `highest_number_control` | The highest number/ID for controls                    | `3` |

2) Edit the bash script job directives as needed.
3) Edit the R module information as needed in the bash script.
4) Edit the input in the bash script:

| Variable       | Description | Example Path   |
|----------------|----------|------------|
| `RSCRIPT_PATH`     | Path to the R script | `"/the/full/path/to/Step_07___Merge_In/Part_0___Merging_In_Step_1_Files/SubPart_2___Merging_In_Step_1_Files/Script.R"` |

4) Run the bash script.
