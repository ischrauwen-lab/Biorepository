#!/bin/bash
#$ -l h_rt=5:00:00
#$ -l h_vmem=50G
#$ -o /home/hcs2152/github/RNA-editing-JACUSA2/Output/JACUSA2_5dpf_Mar_19_$JOB_ID.out
#$ -e /home/hcs2152/github/RNA-editing-JACUSA2/Output/JACUSA2_5dpf_Mar_19_$JOB_ID.err
#$ -N JACUSA2_all_dpf_Mar_19
#$ -q csg.q
#$ -j y

# Add local tools to path
export PATH=$HOME/miniconda3/bin:$PATH

module load SAMTOOLS/1.18

#Path to JACUSA2 jar
JACUSA2='/home/hcs2152/RNA_Editing/JACUSA_v2.0.4.jar'

# Define paths and settings
reference="/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/References/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa"
bam_directory='/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/ZFR_BAM/Ensembl/all_dpf'
jacusa2_output='/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/JACUSA2/all_dpf'

# Print the timestamp to stdout:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")
echo "Job started at: $start_timestamp" 

ctrl_samples=($(ls "${bam_directory}"/Ctrl-*.bam | sort))
mutant_samples=($(ls "${bam_directory}"/NO-*.bam | sort))

echo "Control samples:" "${ctrl_samples[@]}"
echo "Mutant samples:" "${mutant_samples[@]}"

# JACUSA2 with Ctrl, Mutant Samples 1-3 (2 days post fertilization)
java -jar "$JACUSA2" call-2 -a D -P RF-FIRSTSTRAND -p 50 -c 10 -R ${reference} -r "${jacusa2_output}/JACUSA2_all_dpf_sites.txt" "$(IFS=, ; echo "${ctrl_samples[*]}")" "$(IFS=, ; echo "${mutant_samples[*]}")"


# OPTIONS USED

# call-2            Call variants in 2 conditions
# -P RF-FIRSTSTRAND library - first strand sequenced
# -a D              pileup filter, D option is to filter base on the distance to Read Start/End, Introns and INDEL  position.
# -p 6              number of threads
# -R                reference fasta
# -r                Result file

# Get the current timestamp:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Print vmem usage before exiting:
vmem_info=$(qstat -j "$JOB_ID" | grep vmem)

echo "Vmem usage for job $JOB_ID:"

echo "$vmem_info"