# REDItools Main Run

## Scaffold Protocol For REDItools Main Run:

1) The inputs used for the main REDItools run using [REDItools Version 1](https://github.com/BioinfoUNIBA/REDItools/tree/master) are described below:

| **Variable**                                | **Description**                                                                                       | **Input Used For Non-Stranded**               | **Input Used For Stranded**                   |
|---------------------------------------------|-------------------------------------------------------------------------------------------------------|-----------------------------------------------|-----------------------------------------------|
| `reference`                                 | Path to the reference FASTA file.                                                                     | `"/path/to/reference_sm.primary_assembly.fa"` | **Same As Non-Stranded**                      |
| `Tab_file`                                  | File with positions to exclude, typically used to remove known genomic variants (e.g., dbSNP data).    | `"/path/to/tab/file.txt"`                     | **Same As Non-Stranded**                      |
| `SpliceSitesFile`                           | File containing splice sites information.                                                             | `"/path/to/Splice/Sites/File.ss"`             | **Same As Non-Stranded**                      |
| `minimum_read_coverage`                     | Minimum read coverage, defines the least number of reads required to consider a variant (default 10).  | `10`                                          | **Same As Non-Stranded**                      |
| `minimum_quality_score`                     | Minimum quality score, defines the least base quality score for variant calling (default 25).          | `25`                                          | **Same As Non-Stranded**                      |
| `minimum_mapping_quality_score`             | Minimum mapping quality score, defines the least mapping quality score for variant calling (default 25).| `25`                                          | **Same As Non-Stranded**                      |
| `minimum_homopolymeric_length`              | Minimum homopolymeric length, filters out indels near homopolymeric regions (default 5).               | `5`                                           | **Same As Non-Stranded**                      |
| `minimum_editing_frequency`                 | Minimum editing frequency, threshold for calling RNA edits (default 0.1).                             | `0.1`                                         | **Same As Non-Stranded**                      |
| `number_of_bases_near_splice_sites_to_explore`| Number of bases around splice sites to consider during analysis (default 4).                          | `4`                                           | **Same As Non-Stranded**                      |
| `significant_value`                         | Significance threshold for statistical tests (default 0.05).                                           | `0.05`                                        | **Same As Non-Stranded**                      |
| `specific_substitutions_of_interest`        | Specific substitutions to focus on, defined as comma-separated values (e.g., AG, TC).                 | `"AG,TC"`                                     | **Same As Non-Stranded**                      |
| `strand_inference`                          | Strand inference value, set for stranded data analysis.                                                | N/A                                           | `2`                                           |
| `strand_confidence`                         | Confidence threshold for strand inference (default 0.7).                                               | N/A                                           | `0.7`                                         |
| `strand_inference_type`                     | Specifies inference type: MaxValue or UseConfidence (default 2).                                       | N/A                                           | `2`                                           |
| `REDItools_Version_1_Repository_Path`       | Path to the REDItools Version 1 repository.                                                           | `"/path/to/reditools_v1_repo"`                | **Same As Non-Stranded**                      |


2) Edit the job scheduling directives as needed.
3) `chmod +x` the script.
4) Run the script.
