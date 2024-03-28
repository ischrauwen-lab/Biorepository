#!/bin/bash
#$ -l h_rt=96:00:00
#$ -l h_vmem=50G
#$ -o /path/to/Prep_circRNA-$JOB_ID.out
#$ -e /path/to/Prep_circRNA-$JOB_ID.err
#$ -N Prepare_for_circ_detect
#$ -j y
#$ -q queue
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#export your Miniconda path 

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
#Load SAMTOOLS
module load SAMTOOLS/1.17
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "                                "
echo "                                "
echo "Job started at: $start_timestamp"
echo "                                "

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

#Path to STAR mapped reads outputs
base_dir="/path/to/A___Detect/2_Mapping_Reads"

#Path to circtools_detect output directory 
Output_Directory="/path/to/A___Detect/4__Prep_Detect"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
# create output directory for circRNA detection 
if [ ! -d "$Output_Directory" ]; then
    echo "Creating circtools detect directory: $Output_Directory"
    mkdir -p "$Output_Directory"
fi
#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

old_path=`pwd`

#Process files in the base directory and its subdirectories
for sub_dir in "$base_dir"/*_STARmapping; do
    if [ -d "$sub_dir" ]; then
        echo "Processing directory: $sub_dir"
        file_name=$(basename "${sub_dir}" _STARmapping)

        # Extract reads with the specified AWK command for Aligned file
        awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' "${sub_dir}/${file_name}_Aligned.out.sam" > "${sub_dir}/${file_name}_Aligned.noS.sam"

        # Extract reads with the specified AWK command for Chimeric file
        awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' "${sub_dir}/${file_name}_Chimeric.out.sam" > "${sub_dir}/${file_name}_Chimeric.noS.sam"

        grep "^@" "${sub_dir}/${file_name}_Aligned.out.sam" > "${sub_dir}/${file_name}_header.txt"

        samtools view -bS "${sub_dir}/${file_name}_Aligned.noS.sam" | samtools sort -@ 10 -m 2G -T tempo -o "${sub_dir}/${file_name}_Aligned.noS.bam" /dev/stdin
        samtools reheader "${sub_dir}/${file_name}_header.txt" "${sub_dir}/${file_name}_Aligned.noS.bam" > "${sub_dir}/${file_name}_Aligned.noS.tmp"
        mv "${sub_dir}/${file_name}_Aligned.noS.tmp" "${sub_dir}/${file_name}_Aligned.noS.bam"
        samtools index "${sub_dir}/${file_name}_Aligned.noS.bam"

        samtools view -bS "${sub_dir}/${file_name}_Chimeric.noS.sam" | samtools sort -@ 10 -m 2G -T tempo -o "${sub_dir}/${file_name}_Chimeric.noS.bam" /dev/stdin
        samtools reheader "${sub_dir}/${file_name}_header.txt" "${sub_dir}/${file_name}_Chimeric.noS.bam" > "${sub_dir}/${file_name}_Chimeric.noS.tmp"
        mv "${sub_dir}/${file_name}_Chimeric.noS.tmp" "${sub_dir}/${file_name}_Chimeric.noS.bam"
        samtools index "${sub_dir}/${file_name}_Chimeric.noS.bam"

        # Remove original Aligned file
        if [ -f "${sub_dir}/${file_name}_Aligned.noS.bam" ]; then
            rm -f "${sub_dir}/${file_name}_Aligned.out.sam"
            rm -f "${sub_dir}/${file_name}_Aligned.noS.sam"
        else
            echo "Process of new bam file failed "
        fi

        if [ -f "${sub_dir}/${file_name}_Chimeric.noS.bam" ]; then
            rm -f "${sub_dir}/${file_name}_Chimeric.out.sam"
            rm -f "${sub_dir}/${file_name}_Chimeric.noS.sam"
        else
            echo "Process of new bam file failed "
        fi


    cd "$sub_dir/mate1"

    for file in *; do 
            # Extract reads with the specified AWK command for Aligned file
            awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' "${file_name}_Aligned.out.sam" > "${file_name}_Aligned.noS.sam"

            # Extract reads with the specified AWK command for Chimeric file
            awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' "${file_name}_Chimeric.out.sam" > "${file_name}_Chimeric.noS.sam"

            grep "^@" "${file_name}_Aligned.out.sam" > "${file_name}_header.txt"

            samtools view -bS "${file_name}_Aligned.noS.sam" | samtools sort -@ 10 -m 2G -T tempo -o "${file_name}_Aligned.noS.bam" /dev/stdin
            samtools reheader "${file_name}_header.txt" "${file_name}_Aligned.noS.bam" > "${file_name}_Aligned.noS.tmp"
            mv "${file_name}_Aligned.noS.tmp" "${file_name}_Aligned.noS.bam"
            samtools index "${file_name}_Aligned.noS.bam"

            samtools view -bS "${file_name}_Chimeric.noS.sam" | samtools sort -@ 10 -m 2G -T tempo -o "${file_name}_Chimeric.noS.bam" /dev/stdin
            samtools reheader "${file_name}_header.txt" "${file_name}_Chimeric.noS.bam" > "${file_name}_Chimeric.noS.tmp"
            mv "${file_name}_Chimeric.noS.tmp" "${file_name}_Chimeric.noS.bam"
            samtools index "${file_name}_Chimeric.noS.bam"

            # Remove original Aligned file
            if [ -s "${file_name}_Aligned.noS.bam" ]; then
                rm -f "${file_name}_Aligned.out.sam"
                rm -f "${file_name}_Aligned.noS.sam"
            else
                echo "Process of new bam file failed "
            fi

            if [ -s "${file_name}_Chimeric.noS.bam" ]; then
                rm -f "${file_name}_Chimeric.out.sam"
                rm -f "${file_name}_Chimeric.noS.sam"
            else
                echo "Process of new bam file failed "
            fi
        else
            echo "Error: File does not exist: $file"
        fi
        rm -r -f "*_STARpass1"
        cd ..
    done

    cd "$sub_dir/mate2"

    for file in *; do 
            # Extract reads with the specified AWK command for Aligned file
            awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' "${file_name}_Aligned.out.sam" > "${file_name}_Aligned.noS.sam"

            # Extract reads with the specified AWK command for Chimeric file
            awk 'BEGIN {OFS="\t"} {split($6,C,/[0-9]*/); split($6,L,/[SMDIN]/); if (C[2]=="S") {$10=substr($10,L[1]+1); $11=substr($11,L[1]+1)}; if (C[length(C)]=="S") {L1=length($10)-L[length(L)-1]; $10=substr($10,1,L1); $11=substr($11,1,L1); }; gsub(/[0-9]*S/,"",$6); print}' "${file_name}_Chimeric.out.sam" > "${file_name}_Chimeric.noS.sam"

            grep "^@" "${file_name}_Aligned.out.sam" > "${file_name}_header.txt"

            samtools view -bS "${file_name}_Aligned.noS.sam" | samtools sort -@ 10 -m 2G -T tempo -o "${file_name}_Aligned.noS.bam" /dev/stdin
            samtools reheader "${file_name}_header.txt" "${file_name}_Aligned.noS.bam" > "${file_name}_Aligned.noS.tmp"
            mv "${file_name}_Aligned.noS.tmp" "${file_name}_Aligned.noS.bam"
            samtools index "${file_name}_Aligned.noS.bam"

            samtools view -bS "${file_name}_Chimeric.noS.sam" | samtools sort -@ 10 -m 2G -T tempo -o "${file_name}_Chimeric.noS.bam" /dev/stdin
            samtools reheader "${file_name}_header.txt" "${file_name}_Chimeric.noS.bam" > "${file_name}_Chimeric.noS.tmp"
            mv "${file_name}_Chimeric.noS.tmp" "${file_name}_Chimeric.noS.bam"
            samtools index "${file_name}_Chimeric.noS.bam"

            # Remove original Aligned file
            if [ -s "${file_name}_Aligned.noS.bam" ]; then
                rm -f "${file_name}_Aligned.out.sam"
                rm -f "${file_name}_Aligned.noS.sam"
            else
                echo "Process of new bam file failed "
            fi

            if [ -s "${file_name}_Chimeric.noS.bam" ]; then
                rm -f "${file_name}_Chimeric.out.sam"
                rm -f "${file_name}_Chimeric.noS.sam"
            else
                echo "Process of new bam file failed "
            fi
        else
            echo "Error: File does not exist: $file"
        fi
        rm -r -f "*_STARpass1"
        cd ..
    done
        else
        echo "Error: Directory does not exist: $sub_dir"
    fi
    rm -r -f "${sub_dir}/*_STARgenome"
    rm -r -f "${sub_dir}/*_STARpass1"
    rm -r -f "${sub_dir}/*_STARtmp"
    
done 

cd "$old_path"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Build samplesheets for detection module 

if [ ! -d "$base_dir" ]; then
  echo "Source directory $base_dir does not exist!"
  exit;
fi
cd $base_dir/


parallel ln -s `pwd`/{1}/mate{2}/Chimeric.out.junction ../$Output_Directory/{1}.mate{2}.Chimeric.out.junction ::: * ::: 1 2
parallel ln -s `pwd`/{1}/mate{2}/Aligned.noS.bam ../$Output_Directory/{1}.mate{2}.bam ::: * ::: 1 2 
parallel ln -s `pwd`/{1}/mate{2}/Aligned.noS.bam.bai ../$Output_Directory/{1}.mate{2}.bam.bai ::: * ::: 1 2
parallel ln -s `pwd`/{1}/Chimeric.out.junction ../$Output_Directory/{1}.Chimeric.out.junction ::: * 
parallel ln -s `pwd`/{1}/Aligned.noS.bam ../$Output_Directory/{1}.bam ::: * 
parallel ln -s `pwd`/{1}/Aligned.noS.bam.bai ../$Output_Directory/{1}.bam.bai ::: *
parallel ln -s `pwd`/{1}/SJ.out.tab ../$Output_Directory/{1}.SJ.out.tab ::: *

cd .. 

echo "Creating bam files list"
# Create a list of BAM files
ls $base_dir/*_STARmapping/*_Chimeric.noS.bam | grep -v bai | grep -v mate | grep -v bam_files > $Output_Directory/bam_files.txt
if [ ! -s "$Output_Directory/bam_files.txt" ]; then
  echo "Bam Files List does not exist or empty!"
  exit;
fi
echo "Creating mate 1 samplesheet"

# Create sample sheets for mate1, mate2, and all samples
ls $base_dir/*_STARmapping/mate1/*.junction | grep mate1 | grep -v fixed > $Output_Directory/mate1
if [ ! -s "$Output_Directory/mate1" ]; then
  echo "Mate 1 samplsheet does not exist or empty!"
  exit;
fi

echo "Creating mate 2 samplesheet"
ls $base_dir/*_STARmapping/mate2/*.junction | grep mate2 | grep -v fixed > $Output_Directory/mate2
if [ ! -s "$Output_Directory/mate2" ]; then
  echo "Mate 2 samplsheet does not exist or empty!"
  exit;
fi

echo "Creating main samplesheet"
ls $base_dir/*_STARmapping/*.junction | grep -v mate > $Output_Directory/samplesheet
if [ ! -s "$Output_Directory/samplesheet" ]; then
  echo "samplsheet does not exist or empty!"
  exit;
fi
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