#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 1: Input Paths

### Define the REDITs_Cloned_Directory
REDITs_Cloned_Directory <- "/path/to/the/cloned/REDITs/"

### Read the data from the TSV file
data_file <- "/path/to/Step_5___Strict_PreFilteration/Output_File.tsv"

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 2: Find the parent folder of the output folder

# Get the grandparent directory
grandparent_dir <- dirname(dirname(data_file))

# Print the grandparent directory
cat("\n\n*Grandparent directory:*", grandparent_dir, "\n")

# Define the new subfolder name
subfolder_name <- "Step_06___REDITs_Main__Using_REDIT_LLR.R"

# Create the full path for the new subfolder
subfolder_path <- file.path(grandparent_dir, subfolder_name)

# Create the subfolder if it doesn't exist
if (!dir.exists(subfolder_path)) {
  dir.create(subfolder_path)
}

# Update parent_directory to the path of the new subfolder
parent_directory <- subfolder_path

# Print the updated parent_directory
cat("*Parent Directory:*", parent_directory, "\n")

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 3: Check if input paths exist

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

## Section 4: Sourcing

source(file.path(REDITs_Cloned_Directory, "REDIT_LLR.R"))

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 5: Briefly view the header and tail of your data

your_data <- read.table(data_file, header = TRUE, sep = "\t")

cat("\n\nThe data file header:\n")
head(your_data)

cat("The data file tail:\n")
tail((your_data))

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 6: Main

### Assuming 'final_result' is your data frame
row.names(your_data) <- your_data$Region_Position___Count_Type
your_data$Region_Position___Count_Type <- NULL

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

cat("\n\nConverting dataframe into matrix\n")

### Convert data frame to matrix
your_data_matrix <- as.matrix(your_data)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

### Assuming your_data_matrix has row names
row_names <- rownames(your_data_matrix)
col_names <- colnames(your_data_matrix)

### Initialize a list to store the results
result_list <- list()

### Define the constant groups vector
groups_vector <- c('control', 'control', 'control', 'disease', 'disease', 'disease')

### Loop through the rows
for (i in seq(1, nrow(your_data_matrix), by = 2)) {
  ### Check if the index is within the bounds
  if (i + 1 <= nrow(your_data_matrix)) {
    ### Extract two consecutive rows
    current_rows <- your_data_matrix[i:(i+1), ]
    cat("Current rows:", paste(current_rows, collapse = " "), "\n")
  
    ### Call the REDIT_LLR function with the specified data and groups
    result <- REDIT_LLR(data = current_rows, groups = groups_vector)
  
    ### Extract relevant values
    disease_params <- result$mle.for.group.disease
    control_params <- result$mle.for.group.control
    null_params <- result$mle.for.null.model
    log_likelihoods <- c(result$log.likelihood.for.group.disease, 
                         result$log.likelihood.for.group.control, 
                         result$log.likelihood.for.null)
    p_value <- result$p.value
  
    ### Create a data frame with the extracted values
    result_df <- data.frame(
      Region = row_names[i],
      Disease_Alpha = disease_params[1],
      Disease_Beta = disease_params[2],
      Control_Alpha = control_params[1],
      Control_Beta = control_params[2],
      Null_Alpha = null_params[1],
      Null_Beta = null_params[2],
      Log_Likelihood_Disease = log_likelihoods[1],
      Log_Likelihood_Control = log_likelihoods[2],
      Log_Likelihood_Null = log_likelihoods[3],
      P_Value = p_value
    )
  
    ### Store the result in the list
    result_list[[paste0("Rows_", i, "_to_", i+1)]] <- result_df
  }
}

### Combine all data frames into one
final_result_df <- do.call(rbind, result_list)

cat("\n\nResult from loop\n")
### Display the final result
head(final_result_df)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

### Assuming your_data is your data frame
final_result_df$Region <- gsub("___Edited_Count", "", final_result_df$Region)


cat("\n\nRemoving ___Edited_Count From Region Cells\n\n")
head(final_result_df)

# _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _

### Add a new column for custom row names
final_result_df$RowNumbers <- rownames(final_result_df)

cat("Row Names Are Made Into A Column\n\n")
head(final_result_df)

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 7: Create the output directory

output_directory <- file.path(parent_directory, "Part_2___REDITs_Main_Using_Strict_PreFiltered_File")

# Check if the directory exists
if (!dir.exists(output_directory)) {
  # Create the directory
  dir.create(output_directory, showWarnings = FALSE)
  cat("*Output Directory:*", output_directory, "\n")
} else {
  cat("Directory already exists:", output_directory, "\n")
}

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________


## Section 8: Write to files

### Write the data frame to a CSV file
csv_file <- file.path(output_directory, "REDITs_Results_StrictPreFilter.csv")
write.csv(final_result_df, file = csv_file, row.names = FALSE)

### Write the data frame to a TSV file
tsv_file <- file.path(output_directory, "REDITs_Results_StrictPreFilter.tsv")
write.table(final_result_df, file = tsv_file, sep = "\t", row.names = FALSE)

### Print a message indicating the output files
cat("\n\nResults have been written to:", csv_file, "and", tsv_file, "\n")

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

## Section 9: Session Information

cat("\n\n**Session Information:**\n\n")
sessionInfo()

#____________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
