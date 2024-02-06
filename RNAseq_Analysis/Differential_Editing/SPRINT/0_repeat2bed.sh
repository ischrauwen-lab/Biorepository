#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_vmem=20G
#$ -o /home/hcs2152/github/RNA-editing-SPRINT/SPRINT_repeat_to_bed_Nov_19_$JOB_ID.out
#$ -e /home/hcs2152/github/RNA-editing-SPRINT/SPRINT_repeat_to_bed_Nov_19_$JOB_ID.err
#$ -N SPRINT_repeat2bed_Nov_19
#$ -q csg.q
#$ -j y

# Export your Miniconda path:
export PATH=$HOME/miniconda3/bin:$PATH

module load SAMTOOLS/1.18
#Reference bams were aligned to
reference_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/References"
#STAR Bam directory 
input_dir="/mnt/vast/hpc/csg/isabelle/BGI_CD_RNA/CD_BATCH1_RNA_ZFR/CGTRLL230605/02.align"
#Output directory
output_dir="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing//mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/Output"
#path to samtools
samtools_installation="/mnt/mfs/cluster/bin/SAMTOOLS.10/samtools-1.18/BUILD/bin/samtools"
#path to bwa
bwa_installation="/mnt/mfs/cluster/bin/BWA/bwa0.7.17/bwa"
#path to SPRINT github
sprint_path="/home/hcs2152/github/SPRINT/utilities"
# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job started at: $start_timestamp" 


python2 ${sprint_path}/rp2bed.py "${reference_dir}/ZFR_RefSeq_danRer11.rmsk" "${reference_dir}/ZFR_RefSeq_danRer11.bed"

# Get the current timestamp:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Print vmem usage before exiting:
vmem_info=$(qstat -j "$JOB_ID" | grep vmem)

echo "Vmem usage for job $JOB_ID:"

echo "$vmem_info"