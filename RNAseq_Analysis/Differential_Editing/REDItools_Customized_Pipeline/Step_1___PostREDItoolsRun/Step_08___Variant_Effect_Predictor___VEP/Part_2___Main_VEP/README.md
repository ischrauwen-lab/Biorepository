# Step 08: Variant Effect Predictor <br> Part 2: Main Variant Effect Predictor (VEP) Run


### Scaffold Protocol For Part 2: Main Variant Effect Predictor (VEP) Run

1) Edit the SubStep 2 SuperScript to have the following inputs:

| Variable               | Description                                                 |
|-------------|-----------------------------------|
| `INPUT_FILE`           | Path to the Step 08 VEP SubStep 1 `___.sorted.vcf.gz"` file |
| `PARENT_DIRECTORY`     | Path to the parent directory for your output folders        |
| `Output_File_BaseName` | An output file basename of your choice                      | 
| `CACHE_DIR`            | Path to the VEP cache directory                             |
| `ASSEMBLY`             | The cache assembly                                          | 
| `SPECIES`              | The species in the VEP cache                                | 
| `CACHE_VERSION`        | The VEP cache version                                       | 
| `FASTA_FILE`           | The bgzipped reference fasta file (no masking)              |
| `GTF_FILE`             | The bgzipped reference `gtf` file                           |
| `singularity_image`    | The VEP singularity image                                   |
| `script_path_2a`       | Path to the MSFA (Most Severe Flag Added) script            |
| `script_path_2b`       | Path to the MSFR (Most Severe Flag Removed) script          |


2) Edit the job scheduling directives of the superscript and subscripts as needed. 
3) Run the super script to run the subscripts.
