# Step 06 REDITs Regression Run Per Pre-Filtration Type:

## Step 06 REDITs Regression Run Protocol Per Pre-Filtration Type:

1) Edit the R script in the Step 6 directory per filtration to have the following:

| Variable | Description |
|-----------------|-----------------|
| `REDITs_Cloned_Directory` | The path to the REDITs cloned directory  |
| `data_file` | **Basic Pre-Filtration** The path to the Step 4 Part 5 `tsv` <br> **Strict Pre-Filtration:** The path to step 5 `tsv` |

1) Edit the job directives as needed.
2) For the bash script edit the following:

| Variable           | Description |
|----------------|----------|
| `RSCRIPT_PATH`     | The path to the associated R script   |

4) Submit the bash script run to the HPC queue.
