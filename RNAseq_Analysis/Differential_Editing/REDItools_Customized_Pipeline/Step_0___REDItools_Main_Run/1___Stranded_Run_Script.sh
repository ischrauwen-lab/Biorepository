# Your Job Scheduling Directives

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export Your Miniconda Path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Load The REDItools Environment
source activate REDItools

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Load the associated modules
module load SAMTOOLS version 1.18
module load HTSLIB version 1.18

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Set the paths

## BAM folder (with BAIs)
input_folder="/path/to/your/bam/and/bai/directory"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Path To Reference Fasta
reference="/path/to/the/reference.fa"
## ## Positions to exclude - using sorted tab file (this one is based on dbSNP to exclude known genomic variants)
Tab_file="/path/to/your/tab/file.txt"
## SpliceSites File path generated using scripts extracting from gtf
SpliceSitesFile="/path/to/your/file.ss"

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

## For strandedness run:
### -s - Infer strand 1) Only read1 is RNA 2) Only read2 as RNA 12) Both reads are RNA; 0) Neither of the reads are RNA
#### For this our data is first-stranded this means the second read is the original RNA template so we used 2.
strand_inference=2
### -x Stand Confidence (Default == 0.7)
strand_confidence=0.7
### -g 1) is MaxValue 2) UseConfidence
strand_inference_type=2

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

REDItools_Version_1_Repostory_Path="path/to/cloned/REDItools"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
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

output_REDItools_subfolder="REDItools_Version_1___Stranded"
output_folder="$input_folder/$output_REDItools_subfolder"

# Make the output folder:
mkdir -p "${output_folder}"

# Store the path in output_folder and create the directory
output_folder="${output_folder}/Step_0___REDItools_DeNovo_Stranded_Run"
mkdir -p "${output_folder}"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Count the number of BAM files in the input folder
number_of_bams=$(find "$input_folder" -type f -name "*.bam" | wc -l)

# Echo the number of BAM files
echo "Number of BAM files: $number_of_bams"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Run the reditools.py script

# Iterate over each input BAM file
for input_bam in "${input_folder}"/*.bam; do
    # Check if there are any matching files
    [ -e "$input_bam" ] || continue

    # Define the output subfolder based on the input file
    output_subfolder="${output_folder}/$(basename "$input_bam" .bam)___REDItools_V1_Stranded"

    # Run REDItoolDenovo command for each BAM file (REDItoolDenovo.py in REDItools V1)
    python "$REDItools_Version_1_Repostory_Path/main/REDItoolDenovo.py" \
        -i "$input_bam" \
        -f "$reference" \
        -o "$output_subfolder" \
        -t "$number_of_bams" \
        -c "$minimum_read_coverage" \
        -q "$minimum_quality_score" \
        -m "$minimum_mapping_quality_score" \
        -u \
        -O "$minimum_homopolymeric_length" \
        -s "$strand_inference" \
        -g "$strand_inference_type" \
        -x "$strand_confidence" \
        -U "$specific_substitutions_of_interest" \
        -W \
        -n "$minimum_editing_frequency" \
        -d \
        -e \
        -p \
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

### Print the end timestamp to stdout:
echo -e "\n**Job Ended At:** $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
