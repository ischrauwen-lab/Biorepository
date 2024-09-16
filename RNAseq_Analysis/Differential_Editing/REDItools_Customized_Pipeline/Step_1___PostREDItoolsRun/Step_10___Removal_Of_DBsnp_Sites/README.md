# Step 10: Removal Of DBsnp Sites

## Scvaffold Protocol For Step 10: Removal Of DBsnp Sites Per Pre-Filtration Type

1) Edit the R script for Step 10: Removal Of DBsnp Sites Per Pre-Filtration Type to have the following:

| Variable    | Description     |
|-------------|--------------|
| `visual_file` | The path to the `Full_Merged.tsv` created in Step 07  | 
| `output_directory` | The Step 10 Pre-Filtration Type output directory  |
| `output_file_basename` | An output file basename of your choice. It is suggested that you add `"Step_10___*"` where the `*` could include any descriptor of your choice.   | 
| `tab_separated_file` | The file with DBsnp sites.  | 

2) Edit the Step 10 per-prefiltration bash script to have the following:


| Variable    | Description     | 
|-------------|--------------|
| `RSCRIPT_PATH` | Path to the R script  |

3) Edit the job scheduling directives of the bash script as needed.
4) Edit the version of R loaded as needed (we used R version `4.2.2`)
5) Run the bash script per pre-filtratation.
