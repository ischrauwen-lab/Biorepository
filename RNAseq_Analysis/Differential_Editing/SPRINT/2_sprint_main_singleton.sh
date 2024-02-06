#!/bin/bash
#$ -l h_rt=72:00:00
#$ -l h_vmem=15G
#$ -o /home/hcs2152/github/RNA-editing-SPRINT/SPRINT_main_Ctrl_06_Dec_15_$JOB_ID.out
#$ -e /home/hcs2152/github/RNA-editing-SPRINT/SPRINT_main_Ctrl_06_Dec_15_$JOB_ID.err
#$ -N Ctrl_06_SPRINT_Dec_15
#$ -q csg.q
#$ -j y

# Export your Miniconda path:
export PATH=$HOME/miniconda3/bin:$PATH
source activate sprint_environment


#Reference files directory path
reference_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References"
#Trimmed fastq directory
fastq_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/FASTQ/Unzipped/Ctrl"
#Output directory
output_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/Output"
#path to samtools
samtools_installation="/home/hcs2152/miniconda3/envs/sprint_environment/bin/samtools"
#path to bwa
bwa_installation="/home/hcs2152/miniconda3/envs/sprint_environment/bin/bwa"
#path to SPRINT github
sprint_path="/home/hcs2152/github/SPRINT"
# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Set the input singleton sample R1 file path (CHANGE HERE)
fq1="${fastq_dir}/Ctrl-06_trimmed_R1.fq"

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job started at: $start_timestamp" 

# Ensure the output directory exists
mkdir -p "$output_dir"

# Extract sample name from R1 file without "trimmed"
sample_name=$(basename "$fq1" | sed -E 's/_trimmed_R1.fq//')

# Construct R2 file path by replacing "_R1" with "_R2"
fq2="${fastq_dir}/${sample_name}_trimmed_R2.fq"

# Create a directory for the sample without "trimmed"
sample_output_dir="${output_dir%/}/${sample_name}"
mkdir -p "$sample_output_dir"

# Print information for debugging
echo "Sample Name: $sample_name"
echo "Read 1: $fq1"
echo "Read 2: $fq2"
echo "Output Directory: $sample_output_dir"

# Run the sprint command
python2 "${sprint_path}/run.py" main -p 10 -1 "$fq1" -2 "$fq2" -rp "${reference_dir}/ZFR_danRer11.bed" "${reference_dir}/Ensembl/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa" "${sample_output_dir}" "${bwa_installation}" "${samtools_installation}"

# Get the current timestamp:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Print vmem usage before exiting:
vmem_info=$(qstat -j "$JOB_ID" | grep vmem)

echo "Vmem usage for job $JOB_ID:"
echo "$vmem_info"
