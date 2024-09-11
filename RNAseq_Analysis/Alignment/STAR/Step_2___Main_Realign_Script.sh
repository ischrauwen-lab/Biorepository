
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export your Miniconda path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Path to the STAR executable or module load it
module load STAR Version 2.7.10b
module load SAMTOOLS Version 1.17

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Path to the genome FASTA file:
Genome_FASTA=""

# Path to the annotation GTF file:
Annotation_GTF=""

# Path to the input directory containing FASTQ files:
Input_Directory=""

# Output directory for alignment results:
Output_Directory=""

# Created the STAR reference genome directory:
Reference=""

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Choose the number of threads (15 is placed here but it can be changed)
Number_Of_Threads=15

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\nJob started at: $start_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Loop through each pair of paired FASTQ files in the input directory and subdirectories
for forward_file in "${Input_Directory}"/*_R1.fq; do
    # Extract the file name without extension
    file_name=$(basename "${forward_file}" _R1.fq)

    # Path to the corresponding reverse FASTQ file
    reverse_file="${forward_file/_R1/_R2}"

    echo "Forward File: ${forward_file}"
    echo "Reverse File: ${reverse_file}"
    echo "Output Directory: ${Output_Directory}"

    # Create a unique temporary directory for this sample
    TMPDIR="${Output_Directory}/${file_name}___STARtmp"

    echo "The temporary directory is: ${TMPDIR}"

    # Change working directory to the output directory
    cd "${Output_Directory}"

    echo "Made temporary directory: ${TMPDIR}"

    echo "Output Directory + Prefix: ${Output_Directory}/${file_name}___"

    # Run STAR alignment
    STAR \
        --genomeDir "${Reference}" \
        --readFilesIn "${forward_file}" "${reverse_file}" \
        --outFileNamePrefix "${Output_Directory}/${file_name}_" \
        --runThreadN "${Number_Of_Threads}" \
        --genomeLoad NoSharedMemory \
        --outSAMtype BAM SortedByCoordinate \
        --outTmpDir "${TMPDIR}" \
        --outStd Log \
        --outSAMunmapped Within \
        --outSAMattributes Standard

done

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the end timestamp to stdout:
echo -e "\nJob ended at: $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
