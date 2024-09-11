

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export Your Miniconda Path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Load the conda environment
source activate REDItools

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Load The Required Modules
module load SAMTOOLS version 1.18
module load HTSLIB version1.18

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Set the paths

## BAM folder (with BAIs)
input_folder="path/to/bam/and/bai/directory"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Path To Reference Fasta
reference="/path/to/reference_sm.primary_assembly.fa"
## ## Positions to exclude - using sorted tab file (this one is based on dbSNP to exclude known genomic variants)
Tab_file="/path/to/tab/file.txt"
## SpliceSites File path
SpliceSitesFile="/path/to/Splice/Sites/File.ss"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Set the numerical/standard values:

## Minimum read coverage (Default == 10)
minimum_read_coverage=10
## -q Minimum quality score (Default == 25)
minimum_quality_score=25
## -m Minimum mapping quality score (Default == 25)
minimum_mapping_quality_score=25
## -O Minimum homoplymeric length (Default == 5)
minimum_homopolymeric_length=5
## -n Minimum editing frequency (Default == 0.1)
minimum_editing_frequency=0.1
## -r Number of bases near splice sites to explore (Default == 4)
number_of_bases_near_splice_sites_to_explore=4
## -V the significance (Default == 0.05)
significant_value=0.05
## -U subsitutions of interest (separated by comma)
specific_substitutions_of_interest="AG,TC"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

REDItools_Version_1_Repostory_Path="/path/to/REDItools"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\n**Job Started At:** $start_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Check if the input folder exists
if [ -d "$input_folder" ]; then
    echo "Input folder exists: $input_folder"
else
    echo "Error: Input folder does not exist. Exiting . . ."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if the reference file exists
if [ -e "$reference" ]; then
    echo "Reference file exists: $reference"
else
    echo "Error: Reference file does not exist. Exiting . . ."
    exit 1
fi

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Make Non-Stranded folder
output_REDItools_subfolder="REDItools_Version_1___Not_Stranded"
output_folder="$input_folder/$output_REDItools_subfolder"

# Concatenate output_folder with the Step 0 folder name
output_folder="${output_folder}/Step_0___REDItools_DeNovo_NonStranded_Run"

# Make the output folder:
mkdir -p "${output_folder}"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Count the number of BAM files in the input folder
number_of_bams=$(find "$input_folder" -type f -name "*.bam" | wc -l)

# Echo the number of BAM files
echo "Number of BAM files: $number_of_bams"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Run the reditools.py script

#python src/cineca/reditools.py -f "$INPUT_BAM_FILE" -r "$REFERENCE" -o "$OUTPUT_FILE"

# Iterate over each input BAM file
for input_bam in "${input_folder}"/*.bam; do
    # Check if there are any matching files
    [ -e "$input_bam" ] || continue

    # Define the output subfolder based on the input file
    output_subfolder="${output_folder}/$(basename "$input_bam" .bam)___REDItools_V1_NotStranded"

    # Run REDItoolDenovo command for each BAM file (REDItoolDenovo.py in REDItools V1)
    #singularity exec "$singularity_image" /src/cineca/reditools.py \
    # Removed `-p for concordant reads` because of error `Failed to parse TBX_GENERIC, was wrong -p [type] used?`
    python "$REDItools_Version_1_Repostory_Path/main/REDItoolDenovo.py" \
        -i "$input_bam" \
        -f "$reference" \
        -o "$output_subfolder" \
        -t "$number_of_bams" \
        -c "$minimum_read_coverage" \
        -q "$minimum_quality_score" \
        -m "$minimum_mapping_quality_score" \
        -O "$minimum_homopolymeric_length" \
        -u \
        -U "$specific_substitutions_of_interest" \
        -W \
        -n "$minimum_editing_frequency" \
        -d \
        -e \
        -K "$Tab_file" \
        -P "$SpliceSitesFile" \
        -r "$number_of_bases_near_splice_sites_to_explore" \
        -V "$significant_value"
done

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Memory Used:
echo -e "\nLet's look at the vmem:\n"
qstat -j $JOB_ID | grep vmem 

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the end timestamp to stdout:
echo -e "\n**Job Ended At:** $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
