## Summarizes data from:
##  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## install.packages(data.table)
library(data.table)

destFile = "getdata_projectfiles_UCI HAR Dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
setInternet2(use = TRUE)  # Required for Windows.
##download.file(fileUrl, destfile=destFile)
##dateDownloaded <- date()

##unzip(destFile)

loadXData <- function() {
  # Load the features.txt file to get the names for the columns.
  features <- read.table('UCI HAR Dataset/features.txt')
  # Name the columns for ease-of-reading.
  names(features) <- c("num","name")

  # Read the training data and give the columns names.
  xTrain <- read.table('UCI HAR Dataset/train/X_train.txt')
  names(xTrain) <- features$name

  # Read the test data and give the columns names.
  xTest <- read.table('UCI HAR Dataset/test/X_test.txt')
  names(xTest) <- features$name

  # 1. Merges the training and the test sets to create one data set.
  xMerge <- rbind(xTrain,xTest)
}

accelerometerDataAll <- loadXData()

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
# Only return the columns with "-mean" or "-std" in the name.
accelerometerDataProjection <- accelerometerDataAll[,grep("-mean\\(\\)|-std\\(\\)",names(accelerometerDataAll))]

loadActivityData <- function() {
  # Load the mapping from activity numbers to activity labels.
  activities <- read.table('UCI HAR Dataset/activity_labels.txt')
  # Name the columns for ease-of-reading.
  names(activities) <- c("num","Activity")

  # Read the training data.
  yTrain <- read.table('UCI HAR Dataset/train/Y_train.txt')

  # Read the test data.
  yTest <- read.table('UCI HAR Dataset/test/Y_test.txt')

  # 1. Merges the training and the test sets to create one data set.
  yMerge <- rbind(yTrain,yTest)

  # Give yMerge column a name.
  names(yMerge) <- "num"

  # 3. Use descriptive activity names to name the activities in the data set.
  yMergeNamed <- merge(yMerge,activities)
  
  # Drop the numeric code from the data frame.
  yMergeNamed$num <- NULL
  yMergeNamed
}

activityData <- loadActivityData()

## 4. Appropriately labels the data set with descriptive variable names. 
renameXData <- function(df) {
  n <- names(df)

  # Codebook for raw data said:
  #  Similarly, the acceleration signal was then separated into body and
  #  gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using
  #  another low pass Butterworth filter with a corner frequency of 0.3 Hz. 
  
  # Codebook for raw data said:
  #  These time domain signals (prefix 't' to denote time) were captured at
  #  a constant rate of 50 Hz.
  #  Then they were filtered using a median filter and a 3rd order low pass
  #  Butterworth filter with a corner frequency of 20 Hz to remove noise.
  n <- gsub("^t","TimeDomain",n)
  
  # Codebook for raw data said:
  #  Finally a Fast Fourier Transform (FFT) was applied to some of these signals
  #  producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag,
  #  fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 
  n <- gsub("^f","FrequencyDomain",n)
  
  
  # Codebook for raw data said:
  #  Subsequently, the body linear acceleration and angular velocity were derived
  #  in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ).
  
  n <- gsub("Acc","LinearAcceleration",n)
  n <- gsub("Gyro","AngularVelocity",n)
  n <- gsub("Jerk","Derivative",n)

  # Codebook for raw data said:
  #  Also the magnitude of these three-dimensional signals were calculated using
  #  the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag,
  #  tBodyGyroJerkMag). 
  n <- gsub("Mag","Magnitude",n)

  # Codebook for raw data said:
  #  These signals were used to estimate variables of the feature vector for
  #  each pattern: '-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

  # My modification:  
  #  Move the X, Y, Z before "Mean" and "StandardDeviation" for better consistency
  #  with the naming convention that uses "Magnitude" above.
  n <- gsub("-mean\\(\\)-([XYZ])","\\1Mean",n)
  n <- gsub("-std\\(\\)-([XYZ])","\\1StandardDeviation",n)
  
  # Codebook for raw data said:
  #  mean(): Mean value
  n <- gsub("-mean\\(\\)","Mean",n)
  # Codebook for raw data said:
  #  std(): Standard deviation
  n <- gsub("-std\\(\\)","StandardDeviation",n)

  # My modification:  
  #  Original code book makes no mention of "BodyBody".
  #  Assumed to be a typo that we can clean up.
  n <- gsub("BodyBody","Body",n)

  names(df) <- n
  df
}

accelerometerData <- renameXData(accelerometerDataProjection)

nameMapping <- data.frame(oldName=names(accelerometerDataProjection),newName=names(accelerometerData))

loadSubjectData <- function() {
  # Read the training data and give the column a name.
  subjectTrain <- read.table('UCI HAR Dataset/train/subject_train.txt')
  
  # Read the test data and give the column a name.
  subjectTest <- read.table('UCI HAR Dataset/test/subject_test.txt')
  
  # 1. Merges the training and the test sets to create one data set.
  subjectMerge <- rbind(subjectTrain,subjectTest)
  
  # Give subjectMerge column a name.
  names(subjectMerge) <- "Subject"
  
  subjectMerge
}

subjectData <- loadSubjectData()

allData <- cbind(subjectData,activityData,accelerometerData)

## Means of columns over Subject/Activity based on:
## http://stackoverflow.com/questions/11007813/r-row-means-on-multiple-columns-by-groups-or-unique-ids
allDataTable <- as.data.table(allData)
summarizedData <- allDataTable[, lapply(.SD,mean), by="Subject,Activity"]

write.table(nameMapping,"nameMapping.txt",row.name=FALSE)
write.table(allData,"data_unsummarized.txt",row.name=FALSE)
write.table(summarizedData,"data_summarized.txt",row.name=FALSE)
