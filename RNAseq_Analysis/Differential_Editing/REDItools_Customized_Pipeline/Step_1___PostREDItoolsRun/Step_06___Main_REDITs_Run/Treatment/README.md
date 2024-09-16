# Step 6 Main Run Per Pre-Filtration Type:

## Step 6 Main Run Protocol Per Pre-Filtration Type:

1) Edit the R script in the Step 6 directory per filtration to have the following:

| Variable | Description |
|-----------------|-----------------|
| `REDITs_Cloned_Directory` | The path to the REDITs cloned directory  |
| `data_file` | For basic pre-filtration this is the Step 4 Part 5 `tsv` and for strict pre-filtration it is the step 5 `tsv` |

2) Edit the bash script job scheduling directives as needed.
3) Edit the path to the R script in the bash script.
4) Run the bash script to run the R script.
