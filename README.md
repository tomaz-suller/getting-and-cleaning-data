# Getting and Cleaning Data
Week 4 assignment for John Hopkins University Data Science Specialisation

# Dependencies
- [R](https://www.r-project.org/)
- R packages
    - dplyr
    - data.talbe

# Usage
- Clone this repository (in this example we use the HTTPS URL)  
`git clone https://github.com/tomaz-suller/getting-and-cleaning-data.git`  
*NOTE*: This repository should take some time to clone, as it contains both the original and processed datasets. 

- Open a R console (for example in RStudio or through the command line)
- Set this folder as your working directory  
`setwd("path/to/this/repository")`

- In the console, source `run_analysis.R`  
`source("run_analysis.R")`

- Run the `main()` function  
`main()`

This should take some time to load. After that, the folder `tidy_data` (if not present already) will have been created. For a description of the files in that folder, see `CodeBook.md`
