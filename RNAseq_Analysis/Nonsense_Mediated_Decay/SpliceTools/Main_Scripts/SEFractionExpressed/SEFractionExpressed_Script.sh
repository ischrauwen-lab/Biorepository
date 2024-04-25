#!/bin/bash

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Export Miniconda Path

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Define the variables
## Path to rMats output directory
rMats_Output_Directory="/path/to/rmats/output/directory"
## Path to the expression file
expression_file="/path/to/expression_file.tsv"
## Sample Numbers
sample_numbers="3,3"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Minimum tpms per condition
min_tpms_condition="1,1"
# FDR
fdr="0.05"

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Define the path to the cloned GitHub repository
Splice_Tools_Github_Cloned_Directory="/path/to/cloned/directory/SpliceTools"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo -e "\n\n**Job Started At:** $start_timestamp\n"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

SEFractionExpressed_Path="${Splice_Tools_Github_Cloned_Directory}/bin/SEFractionExpressed.pl"
skipped_exon_file="${rMats_Output_Directory}/SE.MATS.JCEC.txt"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Run the Perl script with the specified parameters
perl "$SEFractionExpressed_Path" \
    -s "$skipped_exon_file" \
    -e "$expression_file" \
    -TPM "$min_tpms_condition" \
    -SN "$sample_numbers" \
    -f "$fdr"

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