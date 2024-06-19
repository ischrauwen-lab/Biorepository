#!/bin/bash

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Define the variables
## Path to rMats output directory
rMats_Output_Directory="/path/to/rMats/output/directory/with/NovelSS/flag/used"
## BED file path
bed12_annotation_file="/path/to/reference.bed"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## FDR
fdr=0.05

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Define the path to the cloned GitHub repository
Splice_Tools_Github_Cloned_Directory="/path/to/cloned/from/Github/SpliceTools"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\n**Job Started At:** $start_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

SENumberSkipped_Path="${Splice_Tools_Github_Cloned_Directory}/bin/SENumberSkipped.pl"
skipped_exon_file="${rMats_Output_Directory}/SE.MATS.JCEC.txt"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Check if the directory exists
if [ -d "$rMats_Output_Directory" ]; then
    echo "*rMats Output Directory:* $rMats_Output_Directory"
else
    echo "rMats output directory does not exist. Exiting . . ."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if the bed file exists
if [ ! -f "$bed12_annotation_file" ]; then
    echo "Bed file does not exist. Exiting . . ."
    exit 1
else
    echo "*Bed file:* $bed12_annotation_file"
fi

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Run the Perl script with the specified parameters
perl "$SENumberSkipped_Path" \
    -s "$skipped_exon_file" \
    -a "$bed12_annotation_file" \
    -f $fdr

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the end timestamp to stdout:
echo -e "\n**Job Ended At:** $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
