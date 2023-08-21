#!/bin/bash
#$ -l h_rt=72:00:00
#$ -l h_vmem=30G
#$ -N Manta_On_Tumor_Normal
#$ -o /path/to/Manta_On_Tumor_Normal-$JOB_ID.out
#$ -e /path/to/Manta_On_Tumor_Normal-$JOB_ID.err
#$ -j y
#$ -q queue


#______________________________________________________________________________________________________________________________________________________________________________________________

# Tumor Sample:
Tumor_Sample="path/to/Tumor.bam"

# Normal Sample:
Normal_Seq_Counterpart="/path/to/Normal.bam"

# Reference Fasta
reference=/path/to/reference.fa 

# Output directory:
output_dir="path/to/output/folder"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Hard coded Manta Installation Path:

MANTA_INSTALL_PATH="/home/yr2446/Externa/GitHub/Remote_Builds/manta-1.6.0.release_src/install"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout
echo "Job started at: $start_timestamp"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Create Manta configuration
${MANTA_INSTALL_PATH}/bin/configManta.py \
    --normalBam "${Normal_Seq_Counterpart}" \
    --tumorBam "${Tumor_Sample}" \
    --referenceFasta "${reference}" \
    --runDir "${output_dir}"

echo "Manta configuration created in: ${output_dir}"


echo "Done with the main step"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Now run each `runWorkflow.py`

find "$output_dir" -name "runWorkflow.py" -exec {} \;

echo "Done running Manta on a set of exomes"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the end timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Remove the script from the queue:
qdel $JOB_ID

#______________________________________________________________________________________________________________________________________________________________________________________________

