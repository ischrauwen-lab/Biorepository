
#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Library

library(GenomicFeatures)

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

inDir="/path/to/input/directory/containing/reference/files/such/as/including/gff"
flattenedFile = list.files(inDir, pattern="\\.gff3$", full.names=TRUE)

# Provide the path to the directory containing counts files with quotes removed:
countsDir_unquote <- "/path/to/counts/directory/"

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# List all files in the directory ending with ".txt"
countsFiles_unquote <- list.files(countsDir_unquote, pattern = "\\.txt$", full.names = TRUE)


sampleTable_unquote = data.frame(
   row.names = c("Control_1.txt_clean.txt",
                 "Control_2.txt_clean.txt",
                 "Control_3.txt_clean.txt",
                 "Experiment_1.txt_clean.txt",
                 "Experiment_2.txt_clean.txt",
                 "Experiment_3.txt_clean.txt"),
    
   condition = c("control", "control", "control",
                 "knockdown", "knockdown", "knockdown"),
    
   libType = c("paired-end", "paired-end", "paired-end", 
               "paired-end", "paired-end", "paired-end")

)

#_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

library("DEXSeq")

# Create the DEXSeqDataSet object
dxd <- DEXSeqDataSetFromHTSeq(
  countsFiles_unquote,
  sampleData=sampleTable_unquote,
  design= ~ sample + exon + condition:exon,
  flattenedfile=flattenedFile )

# Norm factors for table: ZFR

####use normfactors

normFactors <- matrix(runif(nrow(dxd)*ncol(dxd),0.5,1.5),
                      ncol=ncol(dxd),nrow=nrow(dxd),
                      dimnames=list(1:nrow(dxd),1:ncol(dxd)))

normFactors <- normFactors / exp(rowMeans(log(normFactors)))
normalizationFactors(dxd) <- normFactors

#_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

dxd = estimateSizeFactors( dxd )

###pairs
normalizedCounts <- t( t(counts(dxd)) / sizeFactors(dxd) )

dxd = estimateDispersions( dxd )
dxd = testForDEU(dxd)
dxd = estimateExonFoldChanges( dxd, fitExpToVar="condition")

dxr = DEXSeqResults( dxd )

resulting <- results(dxd)

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Plots:

print("Plotting")
# Path for output folder
png('/path/to/plot/folder/Year_Month_Day/Weekday_Month_Day_Year__Description___MA_Plot.png',width = 2200, height = 1200, res=300)
plotMA( dxr, cex=0.8 )
dev.off()

#_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

# Set the working directory to the desired output directory
output_directory <- "/path/to/plot/folder/of/your/choice/Year_Month_Day/"
setwd(output_directory)

# Sample list of Ensembl IDs (real ids used not shown - example below)
ensembl_ids <- c("ENSDARG00000001111+ENSDARG00000012345",
                 "ENSDARG00000001234",
                 "ENSDARG00000002345")

# Loop through the Ensembl IDs
for (ensembl_id in ensembl_ids) {
  # Define the file name based on the Ensembl ID
  file_name <- paste0(ensembl_id, "___DescriptorOfYourChoice.png")
  
  # Generate the plot with the specified file name
  png(file_name, width = 2200, height = 3000, res = 300)
  plotDEXSeq(dxr, ensembl_id, displayTranscripts = TRUE, names = FALSE, legend = TRUE, cex.axis = 1.2, cex = 1.3, lwd = 2)
  dev.off()  # Close the PNG device
}

#_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

# Set the working directory to the desired output directory for those with + signs for independent variable with legend removed:
output_directory <- "/path/to/Year___Month_Day___Legend_Removed"

setwd(output_directory)

# Sample list of Real IDs Used Not Shown
ensembl_ids <- c("ENSDARG00000001234+ENSDARG00000023456",
                 "ENSDARG00000098765+ENSDARG00000043210+ENSDARG00000001111")

# Loop through the Ensembl IDs
for (ensembl_id in ensembl_ids) {
  # Define the file name based on the Ensembl ID
  file_name <- paste0(ensembl_id, "____No_Legend.png")
  
  # Generate the plot with the specified file name
  png(file_name, width = 2200, height = 3000, res = 300)
  plotDEXSeq(dxr, ensembl_id, displayTranscripts = TRUE, names = FALSE, legend = FALSE, cex.axis = 1.2, cex = 1.3, lwd = 2)
  dev.off()  # Close the PNG device
}

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Main Gene Of Interest (real ids used not shown - example below)

png('/full/output/path/to/gene/of/interest/GeneName_EnsemblID_Weekday_Month_Day_Year_legend_TRUE.png',width = 2200, height = 2000, res=300)
plotDEXSeq( dxr, "ENSDARG00000012345+ENSDARG00000023456", displayTranscripts=TRUE, legend=TRUE,
            cex.axis=1.2, cex=1.3, lwd=2 )
dev.off()

#_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ 

png('/path/to/GeneName_EnsemblID_Weekday_Month_Day_Year__legend_FALSE.png',width = 2200, height = 2000, res=300)
plotDEXSeq( dxr, "ENSDARG00000024689+ENSDARG00000023456", displayTranscripts=TRUE, legend=FALSE,
            cex.axis=1.2, cex=1.3, lwd=2 )
dev.off()

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

print("DescriptionOfChoice.")

#___________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
