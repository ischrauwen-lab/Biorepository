#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 1: Inputs

### Define the REDITs_Cloned_Directory
REDITs_Cloned_Directory <- "/path/to/the/cloned/REDITs"

### Read the data from the strict filtered TSV file (the Step 5 tsv)
data_file <- "/path/to/Step_05___Strict_PreFilteration/Output_File.tsv"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 2: Make the output directory (refered to as parent directory)

### Extract grandparent directory using dirname function
grandparent_directory <- (dirname(dirname(data_file)))

### Define the new subfolder name
subfolder_name <- "Step_06___REDITs_Main__Using_REDIT_LLR.R"

### Create the full path for the new subfolder
subfolder_path <- file.path(grandparent_directory, subfolder_name)

### Create the subfolder if it doesn't exist
if (!dir.exists(subfolder_path)) {
  dir.create(subfolder_path)
}

### Update parent_directory to the path of the new subfolder
parent_directory <- subfolder_path

### Print the updated parent_directory
cat("\n\n*Parent Directory:*", parent_directory, "\n")

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 3: Check if the input paths are correct

### Check if the path to the REDITs directory is correct by looking for REDIT_LLR.R in it
REDIT_LRR_Path <- file.path(REDITs_Cloned_Directory, "REDIT_LLR.R")

if (file.exists(REDIT_LRR_Path)) {
  ### Print the path to REDITs_Cloned_Directory
  cat("*REDITs Cloned Directory:*", REDITs_Cloned_Directory, "\n")

} else {
  cat("Wrong path to the REDITs cloned repository. If you have not already cloned the directory, please visit https://github.com/gxiaolab/REDITs/tree/master for more information and clone the repository.\n")
  
  ### Exit the script
  stop("Exiting...\n")
}

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

### Check if data file exists:
if (file.exists(data_file)) {
  print(paste("*Basic Filtered File:*", data_file))
} else {
  stop("Basic Filtered File does not exist. Exiting program.")
}

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 4: Source the REDIT Regression

source(file.path(REDITs_Cloned_Directory, "REDIT_regression.R"))

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 5: View the head and tail of the data file

your_data <- read.table(data_file, header = TRUE, sep = "\t")

cat("\n\nThe data file header:\n")
head(your_data)

cat("The data file tail:\n")
tail((your_data))

cat("The column names of the data:\n")
colnames((your_data))

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 6: Main

### Assuming 'final_result' is your data frame
row.names(your_data) <- your_data$Region_Position___Count_Type
your_data$Region_Position___Count_Type <- NULL

cat("\n\nRegion Postion Removed Header\n\n")
head(your_data)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

#### Help from Hayden Shinn

##### Store your_data in your_data_matrix
your_data_matrix  <- your_data

#####Split up the table into separate matrices for processing
rows_per_matrix <- 2

matrix_list <- split(your_data_matrix, (seq(nrow(your_data_matrix))-1) %/% rows_per_matrix)

##### Assuming matrix_list is a list of data frames
matrix_list <- lapply(matrix_list, as.matrix)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

# Assuming your_data_matrix has row names
row_names <- rownames(your_data_matrix)

#Modify the ID column to append after REDITs has ran on data

library(stringr)

# Remove "___Edited" and "___Non_Edited" from row names
row_names <- gsub("___Edited|___Non_Edited", "", row_names)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

col_names <- colnames(your_data_matrix)

# Initialize a list to store the results
result_list <- list()

# Define the covariates
the_covariates <- data.frame(treatment = c('control', 'control', 'control',
                                           'control', 'control', 'control',
                                           'mutant', 'mutant', 'mutant',
                                           'mutant', 'mutant', 'mutant'),
                             timepoint = c(2,2,2,
                                           5,5,5,
                                           2,2,2,
                                           5,5,5)
)

# Loop through the rows
for (i in seq(1, length(matrix_list))) {
    # Extract two consecutive rows
    current_rows <- matrix_list[[i]]
    cat("Current rows:", paste(matrix_list[[i]], collapse = " "), "\n")
    # Perform REDIT_regression
    regression_result <- REDIT_regression(data = current_rows, covariates = the_covariates)
    # Store the p-value from the regression result
    REDITs_Pvalue <- regression_result$treatment.mutant.p.value
    # Create a data frame with the extracted values
    result_df <-  data.frame(Region = row_names[i],
                             REDITs_Pvalue=REDITs_Pvalue)
    # Store the result in the list
    result_list[[paste0("Rows_", i, "_to_", i+1)]] <- result_df
}

# Combine all data frames into one
final_result_df <- do.call(rbind, result_list)

cat("\n\nResult from loop\n")
# Display the final result
head(final_result_df)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

### Remove Non-Edited Rows From The Original Dataframe

#### Identify row names containing "___Non_Edited"
rows_to_remove <- grep("___Non_Edited", rownames(your_data))

# Remove rows containing "___Non_Edited"
Edited_Your_Dataframe <- your_data[-rows_to_remove, ]

#### View the modified dataframe
cat("\n\nRemove Non-Edited Rows From Original Dataframe:\n")
head(Edited_Your_Dataframe)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

#### Add a new column "Region" containing the row names
Edited_Your_Dataframe$Region <- rownames(Edited_Your_Dataframe)

#### Reset row names to NULL
rownames(Edited_Your_Dataframe) <- NULL

cat("\n\nConvert Row Names To Region Columns Rows:\n")
head(Edited_Your_Dataframe)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

#### Remove "___Edited" from the Region column
Edited_Your_Dataframe$Region <- gsub("___Edited", "", Edited_Your_Dataframe$Region)

cat("\n\nRemove ___Edited From Region Column Cells:\n")
#### Print the modified dataframe
head(Edited_Your_Dataframe)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

### Merge Your Original Data With REDITs Data

# Merge Edited_Your_Dataframe and final_result_df by the "Region" column
merged_data <- merge(Edited_Your_Dataframe, final_result_df, by = "Region", all.x = TRUE)

cat("\n\nMerge Edited_Your_Dataframe and final_result_df by the 'Region' column:\n")
# View the merged data
head(merged_data)

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 7: Create the output directory if required

### Create Output Directory For Basic Pre-Filtered File
output_directory <- file.path(parent_directory, "Part_2___REDITs_Main_Using_Strict_PreFiltered_File")

if (!dir.exists(output_directory)) {
  ### Create the directory
  dir.create(output_directory, showWarnings = FALSE)
  cat("*Output Directory:*", output_directory, "\n")
} else {
  cat("*Output Directory Already Exists:*", output_directory, "\n")
}

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 8: Write Basic Pre-Filteration Files

### Write the data frame to a CSV file
csv_file <- file.path(output_directory, "REDITs_Results_OnStrictPreFilteredData.csv")
write.csv(final_result_df, file = csv_file, row.names = FALSE)

### Write the data frame to a TSV file
tsv_file <- file.path(output_directory, "REDITs_Results_OnStrictPreFilteredData.tsv")
write.table(final_result_df, file = tsv_file, sep = "\t", row.names = FALSE)

### Print a message indicating the output files
cat("\n\nResults have been written to:", csv_file, "and", tsv_file, "\n")

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 9: Session Information

cat("\n\n**Session Information:**\n\n")
sessionInfo()

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
