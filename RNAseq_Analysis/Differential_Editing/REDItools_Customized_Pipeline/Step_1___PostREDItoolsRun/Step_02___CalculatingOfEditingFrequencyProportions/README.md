# Step 2: Calculating The Editing Frequency

**Description:**

The Editing Frequency proportions are calculated by doing the (Edited Count)/(Edited Count + NonEdited Count). This is done for each per Region_Position (Region and Position are merged into one column). 
Each output will be per sample and have the following columns `Region_Position` (chromosome and postion merged with an `_`), `Non_Edited_Count` (the count for non-editing at that `Region_Position`), `Edited_Count` (the edited count at that `Region_Position`) `Edited_Count_Proportion` (which is the (Edited Count)/(Edited Count + NonEdited Count) as float).

## Protocol Step 2: Calculating The Editing Frequency Proportions Per Sample:

1) Edit the R script (`Part_2___Rscript_CalculatingEditingFrequencyProportionPerSample.R`) in the `Step_02___CalculatingOfEditingFrequencyProportions` directory. It will require inputs. The input is shown below in a table format with a description of what paths are required:

| Variable | Description Of Required Path |
| --------------- | --------------- |
| `input_directory_path`    | Path to the directory with files that do not contain mitochondiral and K regions created in the previous step    |

2)  Edit the bash script (found in the `Step_02___CalculatingOfEditingFrequencyProportions` directory) used to execute the Rscript. It requires one path in the variable `RSCRIPT_PATH` which is the path to the R script in this case `Part_2___CalculatingEditingFrequencyProportionPerSample.R`.

3)  Run the bash script and it will execute the R script. 
