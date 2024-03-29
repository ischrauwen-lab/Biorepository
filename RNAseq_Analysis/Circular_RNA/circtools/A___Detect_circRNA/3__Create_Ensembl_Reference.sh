#This step only has to be completed once for sample 

#!/bin/bash
#$ -l h_rt=10:00:00
#$ -l h_vmem=5G
#$ -o /path/to/Create_Ensembl_Reference_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.out
#$ -e /path/to/Create_Ensembl_Reference_BGI_CD_RNA_CD_BATCH1_RNA_ZFR_CGTRLL230605_$JOB_ID.err
#$ -N Create_Ensembl_Reference
#$ -j y
#$ -q csg.q
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#export your Miniconda path 

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#load SAMTOOLS
module load SAMTOOLS/1.17
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "                                "
echo "                                "
echo "Job started at: $start_timestamp"
echo "                                "

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Path to Simple Repeats Masker
Simple_Repeats="/path/to/simple_repeats_file.gtf"

#Path to Repeats Masker
Repeats_Masker="/path/to/repeats_masker_file.gtf"

#Output Ensembl Standard Repeat GTF File
Output_GTF="/path/to/output_ensembl.gtf"

#Path to reference genome FASTA file
Genome_FASTA="/path/to/genome_FASTA.fa"

# Path to the SOFT genome indexed FASTA file:
FASTA_index="/path/to/indexed_Genome_FASTA.fa.fai"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Combine Simple Repeats and Repeats Masker into a singular GTF file 

cat "${Simple_Repeats}" "${Repeats_Masker}" > "${Output_GTF}"

echo "Output File: ${Output_GTF}"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Convert UCSC identifiers to to ENSEMBL standard

# echo "Combined and Sorted Output File: ${Output_GTF}"
sed 's/^chr//g' "${Output_GTF}" | sort --batch-size=2G -k1,1 -k4,4n > "${Output_GTF}.sorted"
mv "${Output_GTF}.sorted" "${Output_GTF}"
echo "Combined and Sorted Output File: ${Output_GTF}"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Index FASTA file 
samtools faidx "${Genome_FASTA}" -o "${FASTA_index}"


#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Memory Used:
echo "                       "
echo "Let's look at the vmem:"
qstat -j $JOB_ID | grep vmem 
echo "                       "

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Print the end timestamp to stdout:
echo "                            "
echo "Job ended at: $end_timestamp"
echo "                            "

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________



