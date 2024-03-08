# A : Detect circRNA

In order to map the preprocessed reads against the reference genome and, ultimately detect possible cirRNAs the STAR read mapper is utilized. 

_________________________________________________________________________________________________________________________________

## Step 1: Build STAR Index 

STAR requires an index in order to align reads. Step 1 builds this index to be used to mapping against the reference genome. 

*This step only needs to be completed once as it utilized both the 2dpf and 5dpf data* 


### Important Pathways 

*The FASTA file and Annotation GTF can be found in the /mnt/ directory provided* 

**Reference Pathway** 
`/mnt/vast/hpc/csg/<your-id>/references`

Example from Hawa: 
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references`

**Genome FASTA** 
`/mnt/vast/hpc/csg/<your-id>/references/<name-of-fasta>.fa`

Example from Hawa: 
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa`

**Annotation GTF** 
`/mnt/vast/hpc/csg/<your-id>/references/<name-of-gtf>.gtf`

Example from Hawa: 
'/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.110.chr.gtf`
_________________________________________________________________________________________________________________________________

## Step 2: Map Against the Reference Genome


### Step 2_a : [Maps both reads Joint Reads](https://github.com/ischrauwen-lab/RNA-Circtools/blob/main/Analysis/5dpf/A___Detect_circRNA/2__a_Mapping_Both_Reads_5dpf.sh) of each pair against the reference genome.

#### Important Pathways 

**Input Reads Directory** : `/mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#dpf>/<Trimmed-Raw-Data>`

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/trimmed_data

**Genome Directory** : `/mnt/vast/hpc/csg/<your-id>/references/STAR`

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/references


**Output Mapped Both Pairs** : '/mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#-dpf>/A___Detect/<Substep-2-Dir>`/<Sample-#>

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/2_Mapping_Reads/<Sample-#>


### Step 2_b and 2_c: Separately map reads against the reference genome  [Mate 1](https://github.com/ischrauwen-lab/RNA-Circtools/blob/main/Analysis/5dpf/A___Detect_circRNA/2__b__Map_Mate_1.sh) / [Mate 2](https://github.com/ischrauwen-lab/RNA-Circtools/blob/main/Analysis/5dpf/A___Detect_circRNA/2__c_Map_Mate_2.sh) 

We will take the unmapped reads from the joint mapping of Step 2_a and map each read individually using STAR 

**Step 2b and 2c, can all be ran concurrently**

*Step 2_b* : Map the unmapped reads of read 1 again against the reference genome without the corresponding paired partner.

*Step 2_c* : Map the unmapped reads of read 2 again against the reference genome without the corresponding paired partner.

#### Important Pathways 

**Input Reads Directory** : 

    /mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#-dpf>/A___Detect/<Substep-2-Dir>/<Sample-#>/

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/2_Mapping_Reads/<Sample-#>/

**Output Mapped Mate 1** : 

    /mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#-dpf>/A___Detect/<Substep-2-Dir>/<Sample-#>/mate1

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/2_Mapping_Reads/<Sample-#>/mate1

**Output Mapped Mate 2** : 

    /mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#-dpf>/A___Detect/<Substep-2-Dir>/<Sample-#>/mate2

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/2_Mapping_Reads/<Sample-#>/mate2

**Genome Directory** : 

    /mnt/vast/hpc/csg/<your-id>/references/STAR

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/references/STAR_Reference

_____________________________________________________________________________________________________

## Step 3: [Create Ensembl Standard GTF for Masking](https://github.com/ischrauwen-lab/RNA-Circtools/blob/main/Analysis/5dpf/A___Detect_circRNA/3__Create_Ensembl_Reference.sh) 

**This step only has to be completed once for both 2dpf and 5dpf** 

It is strongly recommended to specify a repetitive region file in GTF format for filtering.

A suitable file can be obtained through UCSC Table Browser and it is recommended to choose RepeatMasker together with SimpleRepeats and combine the results afterwards.

All references must be consistent with one standard, therefore circRNA detection for this analysis must be consistent with **Ensembl** standard. 
For more information about the differences in standards between references, refer to the [lab wiki page](https://github.com/ischrauwen-lab/lab-wiki/blob/main/The_3_References.md)

The output file needs to comply with the GTF format specification. 

**There are three key parts to Step 3**
    1) *Combine the SimpleRepeats and RepeatMasker into a singular GTF file*
    2) *Sort the combined GTF file by chromosome and position*
    3) *Convert the UCSC notation to Ensembl Standard* 
    4) *Index Genome FASTA which is needed for circtools detect step*


### Important Pathways 
**Simple Repeats GTF** 
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/simplerepeats_GRCz11.gtf`

**Repeat Masker GTF**  
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/repeatmasker_GRCz11.gtf`

**Combined GTF Output**  
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Ensembl_GRCz11_repeats.gtf`

# Path to the SOFT genome FASTA file:
**Genome_FASTA**
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa`

# Path to the SOFT genome indexed FASTA file:
**FASTA_index**
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.dna_sm.primary_assembly.fa.fai`


_____________________________________________________________________________________________________

## Step 4: [Preparation for circtools detect](https://github.com/ischrauwen-lab/RNA-Circtools/blob/main/Analysis/5dpf/A___Detect_circRNA/4__Prep_circRNA.sh) 

First, we must convert our `.sam` files to `.bam` files for the circtools detect module. 
    - Using samtools we will convert the `_Aligned.out.sam` and the `_Chimeric.out.sam` files to the necessary format. 

A samplesheet is text file needed as an input to execute circtools detect.


***A samplesheet is text file needed as an input to execute circtools detect.***

The samplesheet file, containing the paths to the jointly mapped chimeric.out.junction files which were created in Step 2.

A samplesheet containing the pathways to all the bam files for circtools detect. 

This will output 3 separate `.txt` files which will be inputted when circtools detect is run. 


### Important Pathways 
*These pathways contain the chimeric.out.juction files that were built through mapping with STAR* 

**Input Directory (STAR mapping outputs)** : 

    /mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#-dpf>/A___Detect/<Substep-2-Dir>

    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/2_Mapping_Reads/

**Output Samplesheet Directory** :

    /mnt/vast/hpc/csg/<RNA-Circ-Dir>/<#dpf>/A___Detect/<Substep-4-Dir>
    
    Example from Hawa: /mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/4__Prep_Detect

________________________________________________________________________________________________________________________________

## Step 5: [Detect for circRNA](https://github.com/ischrauwen-lab/RNA-Circtools/blob/main/Analysis/5dpf/A___Detect_circRNA/5__Detect_circRNA.sh)

The circtools detect module outputs information regarding circRNA through analysis. 

A conda environment is used to ensure all necessary dependencies are downloaded for execution. See [Installation instructions in README](https://github.com/ischrauwen-lab/RNA-Circtools/tree/main?tab=readme-ov-file#circtools-installation) 

*The detection module will output 4 files: 
    1. CircRNACount: a table containing read counts for circRNAs detected. 

    2. CircCoordinates: circular RNA annotations in BED format.

    3.LinearCount: host gene expression count table, same setup with CircRNACount file.

    4.CircSkipJunctions: circSkip junctions.

Setup of circtools detect command:

```bash

circtools detect @samplesheet \ 
-mt1 @mate1 \ # mate1 file containing the mate1 independently mapped chimeric.junction.out files
-mt2 @mate2 \ # mate2 file containing the mate2 independently mapped chimeric.junction.out files
-D \ # run in circular RNA detection mode
-R < Repeats >.gtf \ #regions in this GTF file are masked from circular RNA detection
-an < Annotation >.gtf \ # annotation is used to assign gene names to known transcripts
-Pi \ # run in paired independent mode, i.e. use -mt1 and -mt2
-F \ # filter the circular RNA candidate regions
-M \ # filter out candidates from mitochondrial chromosomes
-Nr 5 6 \ minimum count in one replicate and number of replicates the candidate has to be detected in 2
-fg \ # candidates are not allowed to span more than one gene
-G \ # also run host gene expression
-A < Reference >.fa \ # name of the fasta genome reference file, must be →indexed, i.e. a .fai file must be present

```

### Important Pathways 
**Path to circtools directory containing samplesheets for input** 
/mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/4__Prep_Detect

*Path to Ensembl repeats annotation gtf file used for detection**
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Ensembl_GRCz11_repeats.gtf`

**Path to Annotation gtf file** 
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/references/Danio_rerio.GRCz11.110.chr.gtf`

**Path to circtools cloned repository for conda environment** 
`/home/hn2435/external/github/circtools/circtools`

**Output Directory will be in the circtools directory**
`/mnt/vast/hpc/csg/hn2435/RNA_Circ/5dpf/A___Detect/5__Detect_output`