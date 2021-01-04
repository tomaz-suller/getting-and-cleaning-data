# Description of this repository
This repository includes both the oringal UCI DAR dataset and the tidy data according to the requirements of this assigment.

The reposotiry includes the following:
- `CodeBook.md`: this file
- `README.md`: dependencies and usage descrption
- `assignment_instructions.md`: instructions for the assignment (copied from Coursera and reformatted)
- `run_analysis.R`: R languange file containing functions necessary to process the data
-  tidy_data: a directory with processed data files, containing
    - `data.csv`: aggregated train and test data
    - `means_and_stds.csv`: only information on mean and standard deviation measurements
    - `tidy_averages.csv`: average of each of the variables in `means_and_stds`, grouped by test subject and activity
- UCI HAR Dataset: the data originally supplied

Each `.csv` file contains a header with all variable names. Each observation is stored in a row, and each variable, in a column.

For a more detailed description of the collected variables, see `UCI HAR Dataset/features_info.txt`

# Modifications performed to the original dataset
- Information on activities was placed in a column along with the variables of the dataset rather than on a different file
- Activity labels were replaced by activity names 
- Train and test were merged to form `data.csv`

Specifically for `means_and_stds.csv` and `tidy_averages.csv`
- Time domain signals had the 't' prefix replaced by 'time'
- Frequency domain signals had the 'f' prefix replaced by 'frequency'
- 'Mag' prefixes were removed
- 'std()' was replaced by 'StandardDeviation'
- 'mean()' was replaced by 'Mean'

For a better description of the original data characteristics, see `UCI HAR Dataset/features_info.txt` 
For the complete list of variables of each feature vector, see `UCI HAR Dataset/features.txt`
