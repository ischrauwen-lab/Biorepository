## Protocol For Step 00: Consolidating Files Into One Directory

1) Run the `Step_0___ConsolidatingFiles.sh` found in the `Step_00___Consolidation_Of_Files_To_One_Folder` folder where `*` is a description.

**Note:** The it required a path in `main_directory` (the path to the main directory for the REDItools Denovo output) and a path to the output folder in `output_directory`.

2) You will need to `cd` into the output directory and rename each file to have `.tsv` at the end. The `.tsv` was added as an ending to each file using the following command in the Step 0 directory:

```bash
for file in *; do mv "$file" "${file%.tsv}.tsv"; done
```
