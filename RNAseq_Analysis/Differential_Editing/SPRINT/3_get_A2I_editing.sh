#!/bin/bash
#$ -l h_rt=1:00:00
#$ -l h_vmem=5G
#$ -o /home/hcs2152/github/RNA-editing-SPRINT/A2I_Editing_Dec_22_Test_Ctrl_03_$JOB_ID.out
#$ -e /home/hcs2152/github/RNA-editing-SPRINT/A2I_Editing_Dec_22_Test_Ctrl_03_$JOB_ID.err
#$ -N A2I_Editing_Test_Ctrl_03_Dec_22
#$ -q csg.q
#$ -j y

# Export your Miniconda path:
export PATH=$HOME/miniconda3/bin:$PATH
source activate sprint_environment

#path to SPRINT github
sprint_path="/home/hcs2152/github/SPRINT/utilities"
#Sprint main Output Directory (CHANGE SAMPLE HERE)
sample_output_dir='/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/Output/Ctrl-03'
#A to I editing output file path
editing_output_dir='/mnt/vast/hpc/csg/hcs2152/ZFR_RNA_Editing/SPRINT/Output/A2I_Editing'
# Get the current timestamp:
start_timestamp=$(date "+%Y-%m-%d %H:%M:%S")
# Print the timestamp to stdout:
echo "Job started at: $start_timestamp" 


#run getA2I.py script
python2 ${sprint_path}/getA2I.py 1 ${sample_output_dir} "${editing_output_dir}/Ctrl-03_editing.txt"

# Get the current timestamp:
end_timestamp=$(date "+%Y-%m-%d %H:%M:%S")

# Print the timestamp to stdout:
echo "Job ended at: $end_timestamp"

# Print vmem usage before exiting:
vmem_info=$(qstat -j "$JOB_ID" | grep vmem)

echo "Vmem usage for job $JOB_ID:"

echo "$vmem_info"