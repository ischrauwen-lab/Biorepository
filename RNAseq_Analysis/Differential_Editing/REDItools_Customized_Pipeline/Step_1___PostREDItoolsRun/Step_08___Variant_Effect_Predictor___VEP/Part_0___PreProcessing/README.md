# Step 08: Variant Effect Predictor (VEP) Part 0: All Nucleotides/Pre-Processing

## Protocol: Step 08 VEP Per Pre-Filtration Part 0: All Nucleotides

1) Edit the bash script in Step 08 Part 0 to have the following inputs:

| Variables    | Descriptions    |
|-------------|-------------|
| `inputFilePath`     | Full path to Step 07 Part 2 `tsv`                                    |
| `outputDirectory`   | Full path to Step 08 Part 0 Directory                                | 
| `filenamePrefix`    | Prefix for output files                                              |
| `java_file`         | Path to the java file. The bash script provides paths to this.       |
| `logFile`           | Path to a log file of your choice named however you wish to name it. |
| `singularity_image` | Path to the java singularity.                   |
