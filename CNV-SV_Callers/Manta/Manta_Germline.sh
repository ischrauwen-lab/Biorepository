#!/bin/bash

#______________________________________________________________________________________________________________________________________________________________________________________________

# Accept path to reference fasta file as a parameter:
reference=""

## Input Directory where filtered bams are located:
input_dir=""

#______________________________________________________________________________________________________________________________________________________________________________________________

# Hard coded Manta Installation Path:

## If someone installs Manta they must specify where the installation is placed:

MANTA_INSTALL_PATH="/path/to/manta-version.release_src/install"

#______________________________________________________________________________________________________________________________________________________________________________________________

# Main code:

mkdir -p "${input_dir}/Manta_Outputs"
output_dir="${input_dir}/Manta_Outputs"

for file in ${input_dir}/*.bam
do
  # Create subdirectory named after bam file
  sub_dir=${output_dir}/$(basename ${file} .bam)
  mkdir -p ${sub_dir}

  # Use reference fasta path specified by user
  ${MANTA_INSTALL_PATH}/bin/configManta.py \
    --bam $file \
    --referenceFasta ${reference} \
    --runDir ${sub_dir} \
    --exome
done

#______________________________________________________________________________________________________________________________________________________________________________________________

# Now run each `runWorkflow.py`

find "$output_dir" -name "runWorkflow.py" -exec {} \;

echo "Done running Manta on a set of exomes"

#______________________________________________________________________________________________________________________________________________________________________________________________
