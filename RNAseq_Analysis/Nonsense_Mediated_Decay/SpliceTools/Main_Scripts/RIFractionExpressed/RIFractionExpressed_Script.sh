#!/bin/bash

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export Miniconda Path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Define the variables
## Path to the rMats output directory
rMats_Output_Directory="/path/to/rMats/outputs/With/NovelSS/directory"
## Path to your created expression file
expression_file="/path/to/expression/file/expression.tsv"
# Number of controls and experimentals in the expression file (example shown below)
sample_numbers="3,3"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Minimum tpms (example shown below)
min_tpms_condition="1,1"
## FDR
fdr="0.05"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Define the path to the cloned GitHub repository
Splice_Tools_Github_Cloned_Directory="/path/to/clonded/directory/SpliceTools"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\n**Job Started At:** $start_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

retained_intron_file="${rMats_Output_Directory}/RI.MATS.JCEC.txt"
RIFractionExpressed_Path="$Splice_Tools_Github_Cloned_Directory/bin/RIFractionExpressed.pl"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Check if the file exists and ends with .tsv
if [ -e "$expression_file" ] && [[ "$expression_file" == *.tsv ]]; then
    echo "*Expression File Path:* $expression_file"
else
    echo "Error: Expression file does not exist or has an incorrect extension. Exiting."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if retained_intron_file exists
if [ -e "$retained_intron_file" ]; then
    echo "*RI.MATS.JCEC.txt Path:* $retained_intron_file"

    # Check if rMats_Output_Directory exists
    if [ -d "$rMats_Output_Directory" ]; then
        echo "*rMats Output Directory Path:* $rMats_Output_Directory"
    else
        echo "rMats_Output_Directory does not exist."
        exit 1
    fi
else
    echo "retained_intron_file does not exist."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if sample_numbers contains at least 2 comma-separated values
if [[ "$sample_numbers" =~ [0-9]+,[0-9]+ ]]; then
    echo "sample_numbers contains at least 2 comma-separated values"
    echo "*Number Of Samples Per Condition:* $sample_numbers"
else
    echo "Error: sample_numbers does not contain at least 2 comma-separated values. Exiting."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if min_tpms_condition contains at least 2 comma-separated values
if [[ "$min_tpms_condition" =~ [0-9]+,[0-9]+ ]]; then
    echo "*Minimum Number Of TPMS Per Condition:* $min_tpms_condition"
else
    echo "Error: min_tpms_condition does not contain at least 2 comma-separated values. Exiting."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if fdr contains a number
if [[ "$fdr" =~ ^[0-9]+\.?[0-9]*$ ]]; then
    echo "*False Discovery Rate:* $fdr"
else
    echo "FDR does not exist or does not contain a valid number."
    exit 1
fi

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Check if RIFractionExpressed_Path exists and is a file
if [ -e "$RIFractionExpressed_Path" ]; then
    echo "*RIFractionExpressed_Path:* $RIFractionExpressed_Path"

    # Check if Splice_Tools_Github_Cloned_Directory exists
    if [ -d "$Splice_Tools_Github_Cloned_Directory" ]; then
        echo "*Splice_Tools_Github_Cloned_Directory Path:* $Splice_Tools_Github_Cloned_Directory"
    else
        echo "Splice_Tools_Github_Cloned_Directory does not exist."
        exit 1
    fi
else
    echo "RIFractionExpressed Path does not exist or is not a file."
    exit 1
fi

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Run the Perl script with the specified parameters
perl "$RIFractionExpressed_Path" \
    -r "$retained_intron_file" \
    -e "$expression_file" \
    -TPM "$min_tpms_condition" \
    -SN "$sample_numbers" \
    -f "$fdr"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Memory Used:
echo -e "\n*Let's look at the vmem:*\n"
qstat -j $JOB_ID | grep vmem

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

## Get the timestamp when the command completes:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

## Print the end timestamp to stdout:
echo -e "\n**Job Ended At:** $end_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
