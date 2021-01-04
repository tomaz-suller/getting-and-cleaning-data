library(data.table)
library(dplyr)

main <- function(){
  data <- getTestAndTrainData()
  mean_and_std <- data %>% select(subject, contains(c("-mean()", "-std()")), activity)
  rnames <- names(mean_and_std)
  names(mean_and_std) <- fixMeanStdRownames(rnames)
  averages <- calculateAveragePerActivitySubject(mean_and_std)
  exportDataDir(data, mean_and_std, averages)
}

exportDataDir <- function(data, means, averages){
  dir_name <- "tidy_data"
  if(!dir.exists(dir_name)){
    dir.create(dir_name)
  }
  
  save(data, means, averages, 
       file=file.path(dir_name, "results.RData")
       )
  
  fwrite(
    data, 
    file=file.path(dir_name, "data.csv")
  )
  fwrite(
    means, 
    file=file.path(dir_name, "means_and_stds.csv")
  )
  fwrite(
    averages, 
    file=file.path(dir_name, "tidy_averages.csv")
  )
}

calculateAveragePerActivitySubject <- function(data){
  # Cols 1 and ncol(data)-1 aren't included because they are the
  # factors subject and activity respectively
  limit_col <- ncol(data) - 1
  data[, lapply(.SD, mean), by=.(subject, activity), .SDcols=2:limit_col]
}

getTestAndTrainData <- function(){
  test <- readExperimentData("UCI HAR Dataset", "test")
  train <- readExperimentData("UCI HAR Dataset", "train")
  
  bind_rows(test, train)
}

fixMeanStdRownames <- function(rnames){
  rnames <- sub("^t", "time", rnames)
  rnames <- sub("Mag-", "", rnames)
  rnames <- sub("^f", "frequency", rnames)
  rnames <- sub("mean", "Mean", rnames)
  rnames <- sub("std", "StandardDeviation", rnames)
  rnames <- sub("\\()", "", rnames)
  rnames
}

readExperimentData <- function(dir, set){
  
  y <- fread(
    file=file.path(dir, set, paste("y_", set, ".txt", sep='')),
    col.names="activity", 
    header=FALSE, 
    colClasses="factor"
  )
  
  X <- fread(
    file=file.path(dir, set, paste("X_", set, ".txt", sep='')), 
    sep=" ", 
    header=FALSE, 
    colClasses="double", 
    showProgress=TRUE
  )
  
  subjects <- fread(
    file=file.path(dir, set, paste("subject_", set, ".txt", sep='')), 
    col.names="subject",
    colClasses="factor"
  )
  
  activity_labels <- readFirstColumnFromFile( file.path(dir, "activity_labels.txt") )
  features <- readFirstColumnFromFile( file.path(dir, "features.txt") )
  
  colnames(X) <- features
  levels(y[[1]]) <- activity_labels
  
  bind_cols(subjects, X, y, .name_repair="minimal")
  
}

readFirstColumnFromFile <- function(path){
  data <- fread(path, select=2, stringsAsFactors=FALSE)
  data[[1]]
}