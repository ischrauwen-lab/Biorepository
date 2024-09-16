# Step 13: Merging In Strand Information

* This is used on REDItools Stranded data only. It is optional.

## Scaffold Protocol:

### Protocol For Part 1: Merging In First Four Columns From Step 1:

1) Editing R script to have the following inputs described in detail below:

| Variable(s)                    | Description(s)                                                                                        | 
|----------|----------|
| `input_directory`              | Path to your Step 1 Removal Of K And Mitochondrial regions folder                                     | 
| `output_directory`             | Path to your Step 13 Merging In Strand Information Part 1 Merging In First Four Columns From Step 1   |
| `base_file_name`               | Descriptor of your choice                                                                             | 
| `Control_File_Prefix`          | Descriptor used for your control sample data                                                          | 
| `Experiment_File_Prefix`       | Descriptor used for your experimental sample data                                                     | 
| `lowest_number_experiment`     | Lowest experimental sample number                                                                     | 
| `highest_number_experiment`    | Highest experimental sample number                                                                    | 
| `lowest_number_control`        | Lowest control sample number                                                                          | 
| `highest_number_control`       | Highest control sample number                                                                         |

2) Edit the bash script to have the following path(s):

| Variable(s)          | Description(s)                  | 
|----------|----------|
| `RSCRIPT_PATH`       | Path to the relevant R script   | 

3) Edit the job scheduling directives as necessary.
4) Edit the loaded R version as needed.
5) Submit the bash script to the HPC queue.

### Protocol For Part 2: Breakdown By Pre-Filtration Type Per Pre-Filtration

1) Edit the `ipynb` in this folder to have the following:

| Variable | Description |
|----------|----------|
| `Step_12_TSV`    | Path to the `tsv` created in Step 12   | 
| `file_path_tsv`    | Path to the Step 13 Part 1 `.tsv` file   | 
| `output_directory`    | Path to the output directory `/Step_13___Merging_In_Strand_Information/Part_2___BreakDown_Via_PreFiltration_Type/Pre-Filtration_Type/`   | 


2) Run the `ipynb`. 

