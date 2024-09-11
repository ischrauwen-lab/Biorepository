
#______________________________________________________________________________________________________________________________________________________________________________________________

# Tumor Sample:
Tumor_Sample="/path/to/Tumor.bam"

# Normal Sample:
Normal_Seq_Counterpart="/path/to/Normal.bam"

# Reference Fasta
reference="/path/to/reference.fa" 

# Output directory:
output_dir="/path/to/output/folder"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Hard coded Manta Installation Path:

MANTA_INSTALL_PATH="path/to/manta/install"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\n**Job Started At:** $start_timestamp\n"

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
echo -e "\n**Job Ended At:** $end_timestamp\n"

#______________________________________________________________________________________________________________________________________________________________________________________________

