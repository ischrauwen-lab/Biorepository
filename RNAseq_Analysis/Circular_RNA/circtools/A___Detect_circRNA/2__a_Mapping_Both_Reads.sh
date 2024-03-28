#!/bin/bash
#$ -l h_rt=96:00:00
#$ -l h_vmem=40G
#$ -o /path/to/Mapping_Both_Reads-$JOB_ID.out
#$ -e /path/to/Mapping_Both_Reads-$JOB_ID.err
#$ -N Mapping_Reads_Both_Mates
#$ -j y
#$ -q queue
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#export your Miniconda path 

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Path to the STAR executable or module load it
module load STAR/2.7.10b
module load SAMTOOLS/1.17

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Path to Trimmed FASTQ files to be used as raw data
Input_Directory="/path/to/input_reads.fq"

#Path to reference genome FASTA file
Genome_FASTA="/path/to/genome_FASTA.fa"

#Path to output directory in Detect output (sub-directory = A___Detect)
Output_Dir="/path/to/A___Detect/2_Mapping_Reads"

# Path to the annotation GTF file:
Annotation_GTF="/path/to/GTF_file.gtf"

#STAR Index reference (Output from Optional Step 1)
reference="/path/to/reference_directory/STAR_Reference"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Build target directory for all mapped reads
    if [ ! -d "$Output_Dir" ]; then
        echo "Creating directory: $Output_Dir"
        mkdir -pv "$Output_Dir"
    fi


for forward_file in "${Input_Directory}"/_trimmed_R1.fq.gz; do
    # Extract the file name without extension
    file_name=$(basename "${forward_file}" _trimmed_R1.fq.gz)

    # Path to the corresponding reverse FASTQ file
    reverse_file="${forward_file/_R1/_R2}"

    echo "Forward File: ${forward_file}"
    echo "Reverse File: ${reverse_file}"
    

    Create the output directory for the reads
    sample_dir="$Output_Dir/${file_name}_STARmapping"
    if [ ! -d "$sample_dir" ]; then
        echo "Creating directory: $sample_dir"
        mkdir -pv "$sample_dir"
    fi

    # Create a unique temporary directory for this sample
    TMPDIR="${Output_Dir}/${file_name}__STAR_TMP"
    mkdir -pv "$TMPDIR"

    echo "Made temporary directory: ${TMPDIR}"

    echo "Output Directory + Prefix: ${Output_Dir}"
   
    echo "The temporary directory is: ${TMPDIR}"

    # Change working directory to the output directory
    cd "${Output_Dir}"

    # Run STAR alignment
    STAR \
        --runThreadN 10 \
        --genomeDir "${reference}" \
        --genomeLoad NoSharedMemory \
        --readFilesIn "${forward_file}" "${reverse_file}" \
        --readFilesCommand zcat \
        --outFileNamePrefix "${sample_dir}/${file_name}_" \
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
        --sjdbGTFfile "${Annotation_GTF}" \
        --quantMode GeneCounts\
        --twopassMode Basic\
        --chimOutType Junctions SeparateSAMold

    gzip "${sample_dir}"/*_Unmapped.out.mate1
    gzip "${sample_dir}"/*_Unmapped.out.mate2
    rm -r -f "${sample_dir}"/*_STARgenome
    rm -r -f "${sample_dir}"/*_STARpass1
    rm -r -f "${sample_dir}"/*_STARtmp 

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



