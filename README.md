# CourseProjectWeek3

## Introduction

One of the most exciting areas in all of data science right now is
wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like
Fitbit, Nike, and Jawbone Up are racing to develop the most advanced
algorithms to attract new users. The data linked to from the course
website represent data collected from the accelerometers from the
Samsung Galaxy S smartphone.


## Contents

This repository contains:

1. [data_summarized.txt](/data_summarized.txt/)

    This has the the means over the sample data for a given user-activity
    combination.

2. [data_unsummarized.txt](/data_unsummarized.txt/)

    This data is a subset of the columns from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

    That data is a cache of: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

    The columns have been renamed for ease of use.  See the code book for
    more details.

2. [run_analysis.R](/run_analysis.R/)

    This R script processed the data set collected from Samsung Galaxy S
    smartphones that were on subjects performing various activities.

3. [CodeBook.md](/CodeBook.md/)

    This code book describes the variable names in `data_unsummarized.txt`
    and `data_summarized.txt` relate to the raw data.


## How The Script Works

### 1. Combining Files
The script basically combines 7 files:

1. `'UCI HAR Dataset/features.txt'`
1. `'UCI HAR Dataset/train/subject_train.txt'`
1. `'UCI HAR Dataset/train/X_train.txt'`
1. `'UCI HAR Dataset/train/y_train.txt'`
1. `'UCI HAR Dataset/test/subject_test.txt'`
1. `'UCI HAR Dataset/test/X_test.txt'`
1. `'UCI HAR Dataset/test/y_test.txt'`

Graphically, it could be visualized as:

<table>
  <tr>
    <td>-</td>
    <td>-</td>
    <td><tt>features.txt</tt></td>
  </tr>
  <tr>
    <td><tt>subject_train.txt</tt></td>
    <td><tt>y_train.txt</tt></td>
    <td><tt>X_train.txt</tt></td>
  </tr>
  <tr>
    <td><tt>subject_test.txt</tt></td>
    <td><tt>y_test.txt</tt></td>
    <td><tt>X_test.txt</tt></td>
  </tr>
</table>

### 2. Extracting Columns

The assingment asks that the script:

    "Extracts only the measurements on the mean and standard deviation for each measurement."

I interpreted this to mean that only variables that originally had
labels ending with `-mean()` or `-std()` were to be retained.

### 3. Descriptive Activity Names

In the `y_train.txt` and `y_test.txt` files, the activity is coded as a number.

These were translated to English equivalents based on the mapping supplied in:

    UCI HAR Dataset/activity_labels.txt

### 4. Descriptive variable names.

The variable names were expanded based on the descriptions in:

    UCI HAR Dataset/features_info.txt

Full mapping is included in [CodeBook.md](/CodeBook.md/).

### 5. Average of each variable for each activity and each subject.

This requirement is assumed to be a summarization / smoothing of the
data over multiple trials.  Therefore variables for the same subject /
activity were treated as a group and the mean over each variable was
taken.

