#!/bin/bash
#$ -l h_rt=24:00:00
#$ -l h_vmem=25G
#$ -o /path/to/Mapping_Mate_1-$JOB_ID.out
#$ -e /path/to/Mapping_Mate_1-$JOB_ID.err
#$ -N Mapping_Mate_1
#$ -j y
#$ -q queue

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export your Miniconda path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Path to the STAR executable or module load it
module load STAR/2.7.10b
module load SAMTOOLS/1.17

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Path to the input directory containing FASTQ files (Output Directory of Step 2_a):
Input_Directory="/path/to/A___Detect/2_Mapping_Reads"

#Path to reference genome FASTA file
Genome_FASTA="/path/to/genome_FASTA.fa"

# Path to the annotation GTF file:
Annotation_GTF="/path/to/GTF_file.gtf"

#STAR Index reference (Output from Optional Step 1)
reference="/path/to/reference_directory/STAR_Reference"
# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Get the number of paired FASTQ files in the input directory
Number_Of_Threads=10

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "                                "
echo "                                "
echo "Job started at: $start_timestamp"
echo "                                "

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
# Check if the input directory exists 
if [ ! -d "$Input_Directory" ]; then
    echo "No joint mappings found. Exiting"
    exit
fi

# Loop through each directory in the input directory
for dir in "${Input_Directory}"/*; do
    sample_name=$(basename "${dir}" _STARmapping)
    sample_dir="$Input_Directory/${sample_name}_STARmapping"

    # Check if the sample directory exists, and create if not
    if [ ! -d "$sample_dir" ]; then
        echo "No sample directory found. Exiting"
        exit
    fi
    #Output Directory
    Output_Directory="${sample_dir}/mate1"
    if [ ! -d "$Output_Directory" ]; then
        echo "Creating directory: $Output_Directory"
        mkdir -pv "$Output_Directory"
    fi


    # Loop through each reverse file in the sample directory
    for forward_file in "${dir}"/*_Unmapped.out.mate1.gz; do
        # Extract the file name without extension
        file_name=$(basename "${forward_file}" _Unmapped.out.mate1.gz)

        echo "Forward File: ${forward_file}"
        echo "Output Directory: ${Output_Directory}"

        # Create a unique temporary directory for this sample
        TMPDIR="${sample_dir}/${file_name}_STARtmp_mate1"
        if [  -d "$TMPDIR" ]; then
            rm -r -f "$TMPDIR"
        fi

        # Run STAR alignment
        STAR \
            --runThreadN 10 \
            --genomeDir "$reference" \
            --genomeLoad NoSharedMemory \
            --outTmpDir "$TMPDIR/" \
            --readFilesIn "${forward_file}" \
            --readFilesCommand zcat \
            --outFileNamePrefix "${Output_Directory}/${file_name}_" \
            --outReadsUnmapped Fastx \
            --outSAMattributes NH   HI   AS   nM   NM   MD   jM   jI   XS \
            --outSJfilterOverhangMin 15   15   15   15 \
            --outFilterMultimapNmax 20 \
            --outFilterScoreMin 1 \
            --outFilterMatchNminOverLread 0.7 \
            --outFilterMismatchNmax 999 \
            --outFilterMismatchNoverLmax 0.05 \
            --alignIntronMin 20 \
            --alignIntronMax 1000000 \
            --alignMatesGapMax 1000000 \
            --alignSJoverhangMin 15 \
            --alignSJDBoverhangMin 10 \
            --alignSoftClipAtReferenceEnds No \
            --chimSegmentMin 15 \
            --chimScoreMin 15 \
            --chimScoreSeparation 10 \
            --chimJunctionOverhangMin 15 \
            --sjdbGTFfile "$Annotation_GTF" \
            --quantMode GeneCounts \
            --twopassMode Basic \
            --chimOutType Junctions SeparateSAMold
    done
    rm -f -f "${Output_Directory}/*_STARpass1"
    rm -r -f "${Output_Directory}/${TMPDIR}"
done


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