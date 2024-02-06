#!/bin/bash
#$ -l h_rt=2:00:00
#$ -l h_vmem=10G
#$ -o /home/hcs2152/github/RNA-editing-SPRINT/SPRINT_prepare_Ensembl_Nov_27_$JOB_ID.out
#$ -e /home/hcs2152/github/RNA-editing-SPRINT/SPRINT_prepare_Ensembl_Nov_27_$JOB_ID.err
#$ -N SPRINT_prepare_Ensembl_Nov_27
#$ -q csg.q
#$ -j y

# Export your Miniconda path:
export PATH=$HOME/miniconda3/bin:$PATH
source activate sprint_environment

#Reference files directory path
reference_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References/Ensembl"
#Output directory
output_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/Output"
#path to samtools
samtools_installation="/mnt/mfs/cluster/bin/SAMTOOLS.10/samtools-1.18/BUILD/bin/samtools"
#path to bwa
bwa_installation="/mnt/mfs/cluster/bin/BWA/bwa0.7.17/bwa"
#path to SPRINT github
sprint_path="/home/hcs2152/github/SPRINT"
# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

cd ${sprint_path}
# Print the timestamp to stdout:
echo "Job started at: $start_timestamp" 


python2 ${sprint_path}/run.py prepare -t "${reference_dir}/Danio_rerio.GRCz11.110.chr.gtf" "${reference_dir}/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa" "${bwa_installation}"

# Get the current timestamp:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Print vmem usage before exiting:
vmem_info=$(qstat -j "$JOB_ID" | grep vmem)

echo "Vmem usage for job $JOB_ID:"

echo "$vmem_info"