#!/bin/bash

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Define the variables
## Path to the bed file
bed12_annotation_file="/path/to/reference.bed"
## rMats output directory
rMats_Output_Directory="/path/to/rMats/output/directory"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Set the FDR
fdr=0.05

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Define the path to the cloned GitHub repository
Splice_Tools_Github_Cloned_Directory="/path/to/cloned/Github/SpliceTools"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\n**Job Started At:** $start_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

SE_Unannotated_Path="${Splice_Tools_Github_Cloned_Directory}/bin/SEUnannotated.pl"
skipped_exon_file="${rMats_Output_Directory}/SE.MATS.JCEC.txt"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Check if the bed12 file exists
if [ -f "$bed12_annotation_file" ]; then
    # Print the path if it exists
    echo "*Bed file:* $bed12_annotation_file"
else
    # Print an error message and exit
    echo "Error: Bed12 file does not exist. Exiting . . ."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if the file exists
if [ -f "$SE_Unannotated_Path" ]; then
    # Print the path if it exists
    echo "*SEUnannotated.pl script file exists:* ${SE_Unannotated_Path}"
    echo "*Splice Tools directory exists:* ${Splice_Tools_Github_Cloned_Directory}"
else
    # Print an error message and exit
    echo "SEUnannotated.pl script file: $SE_Unannotated_Path. Exiting . . ."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if the rMats output directory exists
if [ -d "$rMats_Output_Directory" ]; then
    # Print the path if the directory exists
    echo "*rMats Output Directory exists:* $rMats_Output_Directory"
    
    # Assign the skipped exon file path to a variable
    skipped_exon_file="${rMats_Output_Directory}/SE.MATS.JCEC.txt"

    # Check if the skipped exon file exists
    if [ -f "$skipped_exon_file" ]; then
        # Print the path if the file exists
        echo "*Skipped exon file exists:* $skipped_exon_file"
    else
        # Print an error message and exit
        echo "Error: Skipped exon file does not exist. Exiting . . ."
        exit 1
    fi
else
    # Print an error message and exit
    echo "Error: rMats Output Directory does not exist. Exiting . . ."
    exit 1
fi

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Run the Perl script with the specified parameters
perl "$SE_Unannotated_Path" \
    -s "$skipped_exon_file" \
    -a "$bed12_annotation_file" \
    -f $fdr  # No quotes around the numerical value

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Memory Used:
echo -e "\n*Let's look at the vmem:*\n"
qstat -j $JOB_ID | grep vmem

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the end timestamp to stdout:
echo -e "\n**Job Ended At:** $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
