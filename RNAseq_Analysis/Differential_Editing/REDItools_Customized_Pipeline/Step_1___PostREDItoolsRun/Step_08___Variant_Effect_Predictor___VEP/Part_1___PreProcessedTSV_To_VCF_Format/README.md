# SubStep 1: TSV to VCF Format

## SubStep 1: TSV to VCF Format Scaffold Protocol:

1) Edit the pre-filtration type bash script to have the following:

| Variables    | Descriptions     |
|-------------|--------------|
| `TSV_FILE` | Path to the Step 08 Pre-Filtration Type Part 0  `.tsv` file  |
| `OUTPUT_DIRECTORY` | Path to Pre-Filtration Type SubStep 1 directory  |
| `BASE_NAME` | Base name of output file  | 
| `REFERENCE_FASTA` | The reference fasta used for the entire experiment.  | 

2) Modify versions of modules loaded as needed:

**What We Used:**

```bash
BCFTOOLS version 1.18
HTSLIB version 1.18
VCFTOOLS version 0.1.17
```

3) Edit the job scheduling directives as needed.
4) Submit the bash script to the HPC queue.
