# RNA-editing-SPRINT

[SPRINT](https://github.com/jumphone/SPRINT.git) (SnP-free Rna editing IdeNtification Toolkit) is a software that is able to identify RNA editing sites.
Note: There is an option to start from bam files but the SPRINT pipeline is optimized to start from FASTQ files.

Before running the pipeline - you must configure your SPRINT environment. Please use the `.yml` file and follow the [lab wiki instructions](https://github.com/ischrauwen-lab/lab-wiki/blob/12489685b8188319b51c49bb4eef71a9225b4100/conda_environments.md).

If there is any confusion on the SPRINT portion of the tutorial, please see the [SPRINT manual](https://github.com/jumphone/SPRINT/blob/master/SPRINT_manual.pdf).

## Step 0: Convert Repeat Masker to Bed File

**Note:** The bed file only needs to be generated once for a particular model and assembly version (Danio rerio GRCz11 in this case)

A repeat masker file contains annotations identifying and masking repetitive elements in a sequence such that we are able to discern unique genomic regions from repeated ones. This file needs to be converted to a bed file which is to be used for SPRINT main.

Generate .rmsk (repeat masker file) [here](http://genome.ucsc.edu/cgi-bin/hgTables)

Inputs:  
(1) Path to repeat Masker `.rmsk` file.

(2) Path to output BED file `.bed` with desired name.

Current repeat masker file: `/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References/ZFR_danRer11.rmsk`\
Current BED file: `/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References/ZFR_danRer11.bed`



## Step 1: Prepare Reference

The SPRINT prepare command masks the reference genome and builds a mapping index for the reference.  

Inputs:  
(1) `-t` Path to `.gtf` file.  

(2) Path to reference fasta.  

(3) Path to BWA installation (can be accessed on HPC by running `module load BWA/0.7.17` (with approriate version number) and then `which bwa` and a path will be provided.  

Current reference (Ensembl): `/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References/Ensembl/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa`  
Current gtf: `/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References/Ensembl/Danio_rerio.GRCz11.110.chr.gtf`  


## Step 2: SPRINT Main  

SPRINT main identifies RNA editing sites. It is optimized to run with FASTQs as the input but can also start from bam files. Use `2_sprint_main_multisample.sh` for analyzing multiple samples in one run and `2_sprint_main_singleton.sh` for a singular sample.

Inputs:  
(1) `-p` Number of threads.  

(2) `-1` fastq sample 1 `-2` fastq sample 2 (Automatically extracted by script, just **change the fastq directory `fastq_dir`**).  

(3) `-rp` Path to `.bed` file generated in Step 0.  

(4) "${reference_dir}/Ensembl/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa"  

(5) Path to desired sample output directory (Automatically created by script to be named after sample, just **provide the path to the desired parent directory `output_dir`**)  

(6) Path to BWA installation (can be accessed on HPC by running `module load BWA/0.7.17` (with approriate version number) and then `which bwa` and a path will be provided.  

(7) Path to samtools installation (can be accessed on HPC by running `module load SAMTOOLS/1.18` (with approriate version number) and then `which samtools` and a path will be provided. 


#### Trimmed FASTQ locations:
`/mnt/vast/hpc/csg/isabelle/BGI_CD_RNA/CD_BATCH1_RNA_ZFR/CGTRLL230605/01.data/`

## Step 3: Extract Editing Sites

A-to-I editing sites can be extracted with `3_get_A2I_editing.sh`. Currently this script only analyzes outputs for _one sample at a time_. 

Inputs:  
(1) Strand specificity: `0` for non-stranded reads `1` for stranded reads.  

(2) Path to sample output directory.  

(3) Path to file in which editing results will be written - change the `editing_output_dir` and the file prefix to desired name (`.txt` used as extension in this case but `.tsv` would probably work fine as well).  

## Step 4: Merge and Filter Editing Sites

The `4_merge_filter_sites.ipynb` notebook will merge all SPRINT outputs from a parent directory and remove any sites that don't have a minimum of 10x read coverage per site. 

Inputs:  
(1) Path to parent diretory of SPRINT outputs `directory_path`.

**Note:** Depending on the size of your input files, you may need to increase the memory of your `jupyter.sh` notebook. 

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

The second half of this pipeline invoves statistical analysis using [REDITs](https://github.com/gxiaolab/REDITs/blob/master/README.md#credits). 

## Step 5: Prepare REDITs Input

`5_prep_REDIT_input.ipynb` notebook first removes any non-chromosomal contigs (includes chr. 1-25 for zebrafish in this case) and then formats the SPRINT output into edited/non-edited reads as required by REDIts. An ID column is also included to keep track of the sites being analyzed. 

Inputs:  
(1) Path to file outputted from Step 4 passed into `df` variable. 


## Step 6: REDITs analysis

To perform a statistical significane test on a singular timepoint, use `6_REDIT_LLM.ipynb` notebook. To perform a statistical significance test with time as a covariate, use `6_REDIT_Regression.ipynb` notebook.


**For REDITs LLM**  
Inputs:  
(1) Path to file outputted from Step 5 for time point of interest.  

(2) Configure `groups` with appropriate labels for each sample to differentiate groups (eg. Control vs. Mutant).

**For REDIts Regression**
Inputs:  
(1) Paths to files outputted from Step 5 for each time point.  

(2) Configure `the_covariates` to the appropriate number of samples for each of the time points. 

**For both**
Options to adjust the correction for multiple testing method under `p.adjust` function in each notebook.


## Step 7: Merge final dataframes from REDITs Regression

The `7_merge_outputs.ipynb` notebook combines the statistical results from Step 6: REDITs regression (or LLM) with the original tables from Step 4 that include all of the relevant metadata. 

Inputs:  
(1) Paths to Step 4 outputs for each time point.  

(2) Path to Step 6 output containing p-values.

## Step 8: Final filtering of SNPs and identifying significant sites
With the final output combined, `8_remove_dpSNPs.ipynb` removes any known SNPs from the data as we are looking at sites specific to RNA editing. Following that, the multiple testing correction (p_adj) is recalculated since there has been a change to the number of sites. Finally, significant sites are identified with a `p_dj < 0.05` for further variant annotations to be performed. 

Inputs:  
(1) Path to dpSNPs file.  

(2) Path to combined output from Step 7.


