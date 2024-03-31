# Step 04: Filtration By Proportion - Basic Pre-Filtration

## Protocol For Step 4 Filtration Via Proportion (Including Basic Filtration):

1) For the `ipynb` staring with `Part_1_And_Part_2` you will need the following:

| Variable | Description |
|-----------------|-----------------|
| `file_path` | Give the full path to the Step 3 Part 2 `tsv` |

The `ipynb` will find the folder `Step_3___MergingIntoOneTable` is contained in and create a folder`Step_4___FilterationViaProportion___BasicPreFilteration` with each part (Part 1 and Part 2) in a subfolder of `Step_4___FilterationViaProportion___BasicPreFilteration` for all the outputs.

2) Edit the Part 3 `ipynb` to have the following:

| Variable | Description |
|-----------------|-----------------|
| `tsv_file_path` | The path to the part 2 folder and its sub-folder's part 2's `tsv`|

3) Run the part 3 `ipynb`.`Part_3___EachSampleToATSV_Manual.ipynb` is manually edited to only select the edited and non-edited columns per sample and the region column. It will take the full path to `/Part_2___FilteredTablesWithoutProportion/Part_2___Filtered_Without_Proportions.tsv` as an input and create a part 3 folder in the same folder that contains the `Part_2___FilteredTablesWithoutProportion` folder.

4) Edit the Part 4 `ipynb` to have the following:

| Variable | Description |
|-----------------|-----------------|
| `directory_path` | The path to the "Per_Sample_TSV" directory  |

5) Run the `ipynb` starting with `Part_4`. This takes the outputs from the previous part with the full path to `Part_3___Per_Sample_TSV` folder as an input an pivots the tables so that the edited and non-edited column become rows and there is only a counts column.

6) Edit the `Part_5*` `ipynb` file.

| Variable | Description |
|-----------------|-----------------|
| `directory_path` |  The full path to the `Part_4___PivotedTablesPerSampleTSV` folder  |

7) Run the `ipynb` starting with `Part_5`. This takes the full path to the `Part_4___PivotedTables` folder as an input. It will merge all the individual sample `tsv` files by intersect and create the basic filtered file which will be used as an input to REDITs.
