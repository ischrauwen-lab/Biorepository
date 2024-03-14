#!/bin/bash
#$ -l h_rt=96:00:00
#$ -l h_vmem=20G
#$ -N Output___HTseq_Gene_Counts
#$ -o /path/to/Output___HTseq_Gene_Counts-$JOB_ID.out
#$ -e /path/to/Output___HTseq_Gene_Counts-$JOB_ID.err
#$ -j y
#$ -q queue

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export your Miniconda path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Define the path to the GTF/GFF file:
gtf_file="/path/to/my/reference/gtf/reference.gtf"

# Specify the directory containing BAM files aligned to Ensembl:
bam_directory="/path/to/directory/containing/BAM/counts"

# Manually specify the output directory for the results (make sure this exists before running the script):
output_directory="/path/to/output/directory"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp:
echo -e "\n\n**Job Started At:** $start_timestamp"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Change working directory to the output directory
cd "${bam_directory}"

# Loop through all BAM files in the input directory
for bam_file in "$bam_directory"/*.bam; do
    if [ -e "$bam_file" ]; then
        sample_name="$(basename "$bam_file" .bam)"
        output_file="${output_directory}/${sample_name}_gene_counts.txt"

        # Run htseq-count with 12 worker processes
        htseq-count -f bam -r pos -t gene -i gene_id -s no --nprocesses 12 "$bam_file" "$gtf_file" > "$output_file"

        echo "Gene counting for $sample_name is complete."
    else
        echo "No BAM files found in $bam_directory"
    fi
done

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Memory Used:
echo -e "\n\nLet's look at the vmem:"

qstat -j $JOB_ID | grep vmem

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the end timestamp to stdout:
echo -e "\n\n**Job Ended At:** $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________