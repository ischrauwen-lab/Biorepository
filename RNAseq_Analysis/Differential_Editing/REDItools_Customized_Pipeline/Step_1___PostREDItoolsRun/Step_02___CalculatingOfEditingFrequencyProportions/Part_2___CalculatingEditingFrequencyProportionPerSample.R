#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Step 02: Calculating Editing Frequency Proportion Per Sample

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

library(dplyr)
library(readr)

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Define a function to process each file
process_file <- function(file_path, output_directory) {
  # Read the TSV file
  df <- read.table(file_path, header = TRUE, sep = "\t", stringsAsFactors = FALSE)
  # Print the file path
  print(paste("Processing file:", file_path))
  print("Original DataFrame:")
  print(head(df))
  
  # Select specific columns
  selected_columns <- df[, c("Region", "Position", "Reference", "BaseCount.A.C.G.T.")]
  print("Selected Columns:")
  print(head(selected_columns))
  
  # Merge Region and Position columns
  selected_columns$Region_Position <- paste(selected_columns$Region, selected_columns$Position, sep = "_")
  
  # Remove the original Region and Position columns
  selected_columns <- selected_columns[, c("Region_Position", "Reference", "BaseCount.A.C.G.T.")]
  
  # Split the BaseCount.A.C.G.T. column
  counts <- strsplit(selected_columns$BaseCount.A.C.G.T., ",")
  
  # Convert the list to a data frame
  counts_df <- as.data.frame(do.call(rbind, counts))
  
  # Rename the columns
  colnames(counts_df) <- c("A_count", "C_count", "G_count", "T_count")
  
  # Combine the new columns with the original data frame
  selected_columns <- cbind(selected_columns, counts_df)
  
  # Clean up the A_count and T_count columns
  selected_columns$A_count <- gsub("\\[", "", selected_columns$A_count)
  selected_columns$T_count <- gsub("]", "", selected_columns$T_count)
  
  # Remove unnecessary columns
  selected_columns <- selected_columns[, !colnames(selected_columns) %in% c("BaseCount.A.C.G.T.")]
  
  # Convert counts columns to numeric
  selected_columns[, c("A_count", "C_count", "G_count", "T_count")] <- lapply(
    selected_columns[, c("A_count", "C_count", "G_count", "T_count")], as.numeric)
  
  print("Processed DataFrame:")
  print(head(selected_columns))
  
  # Calculate Non_Edited_Count and Edited_Count
  edited_df <- selected_columns %>%
    mutate(
      Non_Edited_Count = case_when(
        Reference == "A" ~ A_count,
        Reference == "C" ~ C_count,
        Reference == "G" ~ G_count,
        TRUE ~ T_count
      ),
      Edited_Count = rowSums(select(., A_count, C_count, G_count, T_count), na.rm = TRUE) - as.numeric(Non_Edited_Count)
    ) %>%
    select(Region_Position, Non_Edited_Count, Edited_Count)
  
  # Calculate Edited_Count_Proportion
  edited_df$Edited_Count_Proportion <- edited_df$Edited_Count / (edited_df$Edited_Count + edited_df$Non_Edited_Count)
  
  print("Final DataFrame:")
  print(head(edited_df))
  
  # Get the base name of the original file
  base_name <- tools::file_path_sans_ext(basename(file_path))
  
  # Create the output file path
  output_file_path <- file.path(output_directory, paste0(base_name, "___Edited_Column_Added.tsv"))
  
  # Write the processed table to a TSV file
  write.table(edited_df, file = output_file_path, sep = "\t", quote = FALSE, row.names = FALSE)
}

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Specify the directory containing your files (Step 1 Removal Of K And Mitochondrial Regions directory path)
input_directory_path <- "path/to/your/step1/directory"

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get the parent directory of the input directory
parent_directory <- dirname(input_directory_path)

# Define the subfolder name for the output directory
output_folder_name <- "Step_02___CalculatingEditingFrequencyProportionPerSample"

# Create the output directory path as a subfolder of the parent directory
output_directory_path <- file.path(parent_directory, output_folder_name)

# Create the output directory if it doesn't exist
dir.create(output_directory_path, showWarnings = FALSE, recursive = TRUE)

# Now, output_directory_path contains the path to the desired output directory
cat("Output Directory Path:", output_directory_path, "\n")

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Check if the paths provided exist. If they do not quit/exit.

if (dir.exists(input_directory_path)) {
  cat("\n\n*Input Directory:*", input_directory_path, "\n")
} else {
  cat("\nThe directory does not exist. Quitting...\n")
  q("no")
}

if (dir.exists(output_directory_path)) {
  cat("\n*Output Directory:*", output_directory_path, "\n\n")
} else {
  cat("\nThe directory does not exist. Quitting...\n\n")
  q("no")
}

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Get a list of files in the input directory
file_list <- list.files(input_directory_path, pattern = "\\.tsv$", full.names = TRUE)

cat("\n\n**List Of Files In Input Directory With .tsv Ending:**\n")
print(file_list)

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Process each file and write the results to the output directory
for (file_path in file_list) {
  process_file(file_path, output_directory_path)
}

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________

# Session Information
cat("*Session Information:*\n")
print(sessionInfo())

#__________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________________
