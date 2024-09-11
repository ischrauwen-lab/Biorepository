# How To Use Singularity

For more information please refer to the [user guide for Singularity](https://docs.sylabs.io/guides/2.6/user-guide/index.html).

## Before Downloading:

1) Check if your container is already on the cluster in the singularity container directory of your lab.

## Making Your Singularity File:

1) Load the Singularity using `module load Singularity/version` you can check with `module spider Singularity` if the versions change.

```bash
module load Singularity/3.9.4
```

2) Generate an Access Token if required by going to this [site](https://cloud.sylabs.io/auth/tokens)  - store it locally on your machine as you will need it later.

3) You need to log remotely:      

```bash
singularity remote login
```

* You will need to paste the key you have from step 2.

4) Then you can do singularity build (or `singularity pull` with the user/dockerimagename):

**Example for Singularity pull**:

```bash
singularity pull docker://staphb/trimmomatic
```

**Example for Singularity build**:
```bash
singularity build --remote picard.sif docker://broadinstitute/picard
```

# Using Your Singularity File:

1) Know the path to your singularity and place that path in the  `singularity_image` variable:

```bash
# The Singularity image GATK 4.4.0.0:
singularity_image="/path/to/gatk_latest.sif"
```

2) Know the path inside your singularity to use to execute commands. For GATK 4.4.0.0 it is `/gatk/gatk`. This will create a base command of `singularity exec $singularity_image /gatk/gatk CommandFromGATK` an example is placed below:

```bash
singularity exec $singularity_image /gatk/gatk FilterIntervals \
  --intervals ${preprocessed_interval_dir}/PreprocessIntervals.interval_list \
  ${annotated_intervals_list} \
  ${counts_arguments}  \
  --interval-merging-rule OVERLAPPING_ONLY \
  --output "${filtered_intervals_dir}/Filter_Intervals.interval_list"
```

**Note:** The path inside the singularity and to the singularity will change based on the singularity/software you are using.

