import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

public class PreProcessing_Consolidated {

    public static void main(String[] args) {
        // Check if the correct number of arguments is provided
        if (args.length != 3) {
            System.err.println("Usage: java PreProcessing_Consolidated <inputFilePath> <outputDirectory> <filenamePrefix>");
            System.exit(1);
        }

        // Extract input, output directory, and filename prefix from command-line arguments
        String inputFilePath = args[0];
        String outputDirectory = args[1];
        String filenamePrefix = args[2];


        // Construct output file paths
        String outputFilePath = outputDirectory + "/" + filenamePrefix + "_output.tsv";
        String outputFilePath2 = outputDirectory + "/" + filenamePrefix + "_output.csv";

        // Set the header for the new output table 
        String[] newHeaders = {"#CHROM", "POS", "ID", "REF", "ALT"};

        try { 
            // Open input and output files
            BufferedReader br = new BufferedReader(new FileReader(inputFilePath));
            BufferedWriter bw = new BufferedWriter(new FileWriter(outputFilePath));
            BufferedWriter bw2 = new BufferedWriter(new FileWriter(outputFilePath2));

            // Read the header and write it to the output file
            String headerLine = br.readLine();
            String[] headers = headerLine.split("\t");
            bw.write(String.join("\t", newHeaders));
            bw.newLine();
            bw2.write(String.join("\t", newHeaders));
            bw2.newLine();


            // Identify the indices for "BaseCount" and "Reference" columns
            List<Integer> allNucleotidesIndices = new ArrayList<>();
            List<Integer> referenceIndices = new ArrayList<>();
            for (int i = 0; i < headers.length; i++) {
                if (headers[i].startsWith("BaseCount")) {
                    allNucleotidesIndices.add(i);
                }
                if (headers[i].startsWith("Reference")) {
                    referenceIndices.add(i);
                }
            }
            // Process each line
            String line;
            while ((line = br.readLine()) != null) {
                String[] columns = line.split("\t");

                // Split the region and position columns 
                String[] chrom_pos = columns[0].split("_");
                String CHROM = chrom_pos[0];
                String pos = chrom_pos[1];

                //Set ID Column to be .
                String ID = ".";

                // Get the unique reference value
                Set<String> refValue = getRefBase(columns, referenceIndices);

                // If there is more than one unique reference value, skip the row
                if (refValue.size() != 1) {
                    continue;
                }
                //Get the unique BASE value 
                String uniqueAltBases = getAltBase(columns, allNucleotidesIndices, refValue);


                // Write the row to the output file
                bw.write(String.join("\t", CHROM, pos, ID, refValue.iterator().next(), uniqueAltBases));
                bw.newLine();
                bw2.write(String.join("\t", CHROM, pos, ID, refValue.iterator().next(), uniqueAltBases));
                bw2.newLine();
                }

                // Close files
                br.close();
                bw.close();
                bw2.close();
                }

            catch (IOException e) {
                e.printStackTrace();
                }
    }

    // Method to get the unique reference value from the row
    public static Set<String> getRefBase(String[] columns, List<Integer> referenceIndices) {
        Set<String> refValue = new HashSet<>();
        for (int index : referenceIndices) {
            if (index < columns.length) {
                refValue.add(columns[index]);
            }
        }
        return refValue;
    }

    public static String getAltBase(String[] columns, List<Integer> allNucleotidesIndices, Set<String> refValue) {
        String referenceLetter = refValue.iterator().next(); 
        Set<String> uniqueAltBases = new HashSet<>();
        String[] bases = {"A", "C", "G", "T"};
        for(int index : allNucleotidesIndices) {
            if (index < columns.length) {
                String baseCounts = columns[index];
                baseCounts = baseCounts.replaceAll("[()\\[\\]]", "").trim();
                String[] counts = baseCounts.split(",\\s*");

                for (int i = 0; i < counts.length; i++) {
                    String count = counts[i].trim(); // Remove leading/trailing spaces
	                if (!count.isEmpty() && !count.equals("0")) { // Exclude empty or zero counts
                        //Exclude the Reference Base
                        if (!bases[i].equals(referenceLetter)) {
                            uniqueAltBases.add(bases[i]);
                        }
                    }
                }
        }
    }
    return String.join(",", uniqueAltBases);
}
}
