# REDItools *De Novo* Data Processing Pipeline With 2 Pre-Filtration Options:

We used R version 4.2.2 for all the R scripts here.

![General_Pipeline___REDItools](https://github.com/user-attachments/assets/36426389-5bfb-4bb2-9533-34d0a6d98871)
* Thank you to [Canva](https://www.canva.com) for helping us to build this flowchart.

### **Key To The Flowchart:**

| Line Color             | Description                                        |
|------------------------|----------------------------------------------------|
| Sky Blue               | Basic Pre-Filtration                               |
| Red                    | Strict Pre-Filtration                              |
| Purple                 | Steps that can be used for basic and strict pre-filtration |
| Green (dashed)         | Non-sequential inputs                              |

## Steps That Do Not Have Inputs From Sequential Steps

The whole protocol is shown in a flow chart in the previous section but this section just focuses on the steps with non-sequential inputs. For the most part Step 1 feeds into Step 2 which feeds into Step 3 and so on... however, some steps are not quite sequential and a flowchart of these steps was made as a reference below:

![NonSequentialSteps_Flowchart](https://github.com/user-attachments/assets/2390534c-3317-4886-b8b0-109e909986ab)
* Thank you to [Canva](https://www.canva.com) for helping us to build this flowchart.

## Abbreviations Used Occassionally

| General Description      | In-Depth Description           | Abbreviation       |
|--------------------------|--------------------------------|--------------------|
| Strand Type              | Stranded                       | S                  |
| Strand Type              | Non-Stranded/Not Stranded      | NS                 |
| Pre-Filtration           | Basic Pre-Filtration           | BPF or BF          |
| Pre-Filtration           | Strict Pre-Filtration          | SPF or SF          |
| Pre-Filtration           | Pre-Filtration Type            | PFT, PT, or PF     |
| Variant Effect Predictor | Variant Effect Predictor       | VEP                |
| Most Severe Flag         | Most Severe Flag Added         | MSFA               |
| Most Severe Flag         | Most Severe Flag Removed       | MSFR               |

Please refer to the protcols in each Step folder for more details.
