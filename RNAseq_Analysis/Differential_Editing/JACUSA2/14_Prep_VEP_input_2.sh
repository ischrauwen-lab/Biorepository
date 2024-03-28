#!/bin/bash
#$ -l h_rt=1:00:00
#$ -l h_vmem=3G
#$ -N TSV_to_VCF_March_21
#$ -o /home/hcs2152/github/RNA-editing-JACUSA2/Output/TSV_to_VCF_$JOB_ID.out
#$ -e /home/hcs2152/github/RNA-editing-JACUSA2/Output/TSV_to_VCF_$JOB_ID.err
#$ -j y
#$ -q csg.q

# Export Your Miniconda Path
export PATH=$HOME/miniconda3/bin:$PATH

# Convert TSV file into VCF file for VEP 
module load BCFTOOLS/1.18

# Set input and output paths 
TSV_input="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/JACUSA2/VEP/all_dpf/JACUSA2_all_dpf_VEP_input.tsv"
VCF_output="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/JACUSA2/VEP/all_dpf/JACUSA2_all_dpf_VEP_input.vcf"
reference="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/References/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa"


# Print the timestamp to stdout:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")
echo "Job started at: $start_timestamp" 

# Run bcftools convert 
bcftools convert --fasta-ref $reference --columns CHROM,POS,ID,REF,ALT,QUAL,FILTER,INFO,FORMAT --tsv2vcf $TSV_input --output $VCF_output

# Get the current timestamp:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Print vmem usage before exiting:
vmem_info=$(qstat -j "$JOB_ID" | grep vmem)

echo "Vmem usage for job $JOB_ID:"

echo "$vmem_info"