# Identifying RNA Editing Sites with [JACUSA2](https://github.com/dieterich-lab/JACUSA2.git)

Script modeled after: [_Benchmark of RNA Editing Detection Tools_](https://github.com/davidrm-bio/Benchmark-of-RNA-Editing-Detection-Tools/blob/aa5ccb3943a6e5032ab70d1ee53870725df9ce64/Tools/JACUSA2.sh)

Note: User is responsible for setting up directory/file organization to their liking. Please remember to create necessary/desired directories before running each step. 

## Step 0: Install JACUSA2

Follow instructions to download the jar file to your directory from the [JACUSA2 github](https://github.com/dieterich-lab/JACUSA2.git). The manual is also available [here](https://github.com/dieterich-lab/JACUSA2/blob/master/manual/manual.pdf). 

## [Step 1](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/1_Run_Jacusa2_no_tag.sh): Run JACUSA2 call-2 command 

JACUSA2 call-2 command compares single nucleotide variants across two different conditions. Please doublecheck your `-P` library type option. 

Inputs: \
(1) List of individual bam file paths - condition 1 bams (control) followed by condiition 2 bams (mutants) - _Script is written to do this for files with the same prefix_. \
(2) `-R` FASTA reference file 

Outputs: \
(1) `-r` JAUCSA2 output file

## [Step 2](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/2_Remove_SNPs.ipynb): Remove SNPs from data

Since we are looking specifically at RNA editing sites, we need to remove all known SNPs from the dataset. Please ensure you have the correct dpSNP file. 

Inputs: \
(1) JACUSA2 output file \
(2) dbSNP file 

Outputs: \
(1) JACUSA2 file with dbSNPs removed

## [Step 3](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/3_Split_samples.ipynb): Split data up by sample

Data is split up by sample for easier manipulation. Please note your number of samples and ensure this corresponds with the notebook. Make sure to create a directory to store your individual samples. 

Inputs: \
(1) JACUSA2 file with dbSNPs removed

Outputs: \
(1) Individual files for each sample

## [Step 4](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/4_Calculate_proportions.ipynb): Calculate editing proportions

This step calculates the percent editing at each site per sample. 

Inputs: \
(1) Directory of individual sample files

Outputs: \
(1) Individual sample files with editing proportions added (provide output directory)

## [Step 5](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/5_Rename_columns.ipynb): Rename columns. 

This notebook renames all of the columns so they can be distinguished by sample before merging into one dataframe. 

Inputs: \
(1) Directory of individual sample files with editing proportions

Outputs: \ 
(1) Individual sample files with column names added (provide output directory)

## [Step 6](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/6_Merge_data.ipynb): Merge files into one dataframe.

This notebook merges all of the manipulated individual sample files into one file such that it can be filtered. 

Inputs: \
(1) Directory of individual sample files with column name added

Outputs: \
(1) Merged samples file 

## [Step 7](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/7_Filter_1.ipynb): Filter 1

This notebook removes all mitochondrial and K-contigs as they are not of interest (keeps chr. 1-25). Furthermore, any sites where **all** samples have an editing proportion less than 0.1 or greater than 0.9 are removed. 10% percent editing is the minimum threshold that has been chosen and the above 90% threshold is to account for overamplification. 

Inputs: \
(1) Merged samples file

Outputs: \
(1) Merged and filtered file

## [Step 8](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/8_Filter_2.ipynb): Filter 2

Since we are looking at A to I (A to G) edited sites, this notbook filters to keep all A to G edited sites on the positive strand and all T to C edited sites on the negative strand. 

Inputs: \
(1) Merged and filtered file \
(2) Directory of individual sample files (associated metadata is used) 

Outputs: \
(1) A to G sites file \
(2) T to C sites file 

## [Step 9](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/9_Prep_REDITs_input_1.ipynb): Prepare REDITs input 1

This notebook removes any duplicate sites between AG and TC sites. It also grabs the edited and non-edited counts for each editing type per sample. 

Inputs: \
(1) A to G sites file \
(2) T to C sites file 

Outputs: \
(1) A to G counts file per sample \
(2) T to C counts file per sample 

## [Step 10](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/10_Prep_REDITs_input_2.ipynb): Prepare REDITs input 2

This notebook reformats the Edited/Non-edited counts columns for each file to be in REDITs format. 

Inputs: \
(1) Directory of A to G counts files per sample \
(2) Directory of T to C counts files per sample 

Outputs: \
(1) A to G counts file per sample reformatted \
(2) T to C counts file per sample reformatted 

## [Step 11](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/11_Prep_REDITs_input_3.ipynb): Prepare REDITs input 3

This notebook adds A/G and T/C identifiers to the site IDs and then merges all samples into one file to run REDITs.

Inputs: \
(1) A to G counts file per sample reformatted \
(2) T to C counts file per sample reformatted 

Outputs: \
(2) Merged REDITs input file 

## Step 12: REDITs 

There are two options for step 12. If working with a two condition comparison (control vs mutant for one time point), use [REDITs LLR](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/12_REDITs_LLR.ipynb). If working with with a covariate, such as time, use [REDITs regression](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/12_REDITs_Regression.ipynb). This notebook runs a statistical analysis on the site counts data. 

Inputs: \
(1) REDITs input file

Outputs: \
(1) P-value file

## [Step 13](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/13_Prep_VEP_input.ipynb): Prep VEP input

This notebook formats the sites data into VCF format. 

Inputs: \ 
(1) A to G sites file (Step 8 output) \
(2) T to C sites file (Step 8 output)

Outputs: \
(1) VEP input (TSV format)

## [Step 14](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/14_Prep_VEP_input_2.sh): Prep VEP input 2

This script converts the `.tsv` file into a `.vcf` file which is the accepted format for VEP. 

Inputs: \
(1) VEP input (TSV format)

Outputs: \
(1) VEP input (VCF format) 

## Step 14.5: Sort, Zip & Index VCF

VEP prefers all input files to be sorted, zipped and index. This includes the associated `.gtf`, `ref.fa`, and `.vcf` input files. 

To execute this: \

Start an interactive session: `qlogin -q csg.q` \

`cd` into the directory with your file (GTF/FASTA/VCF)

```
module load BCFTOOLS/1.18`
bcftools sort -o JACUSA2_5dpf_VEP_input_sorted.vcf -O v JACUSA2_5dpf_VEP_input.vcf


module load HTSLIB/1.18
bgzip JACUSA2_5dpf_VEP_input_sorted.vcf


bcftools index -t JACUSA2_5dpf_VEP_input_sorted.vcf.gz
```


## [Step 15](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/15_VEP_Most_Severe.sh): VEP - Most Severe 

Ensembl's Variant Effect Predictor determines the effects of genomic variants (RNA edited sites in this case). This script runs the VEP with the `--most severe` option which denotes the most severe consequence for each variant. 

**Before running VEP**, please download the VEP cache directory **OR** copy it from a user who already has it downloaded. 


Inputs: \
(1) VEP input (VCF) format

Outputs: \
(1) VEP summary (most severe)

## [Step 16](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/16_VEP_Standard.sh): VEP - Standard

This script runs VEP with all standard options and outputs all the associated gene info that will be used for further analysis. 

Inputs: \
(1) VEP input (VCF) format

Outputs: \
(1) VEP summary (standard)

## [Step 17](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/17_Annotate_VEP_p_values.ipynb): Annotate VEP with p-values.

This script combines the Step 15 output (VEP most severe) with the p-value file ouputted from Step 12. 

Inputs: \
(1) VEP summary (most severe)
(2) P-value file 

Outputs: \
(1) Combined VEP/p-value file 

## [Step 18](https://github.com/ischrauwen-lab/Biorepository/blob/09d1856b5935bcfd548f6a1ff95d26cc852c81b4/RNAseq_Analysis/Differential_Editing/JACUSA2/18_Filter_VEP_consequences.ipynb): Filter VEP Consequences & Run p-adjust

This script first filters out any VEP consequences that are not of interest. Then correction for multiple testing is performed via p-adjust. Finally, all data (sites, proportions, counts) is combined to create one final output. 

Current file used to filter VEP consequences: `/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/JACUSA2/VEP/VEP_consequence_filter_to_keep.txt`

Inputs: \
(1) Combined VEP/p-value file \
(2) Filtered VEP consequences file \ 
(3) A to G sites file (Step 8 output) \
(4) T to C sites file (Step 8 output) \
(5) Merged and filtered file (Step 7 output)

Outputs:   \
(1) Combined final output





