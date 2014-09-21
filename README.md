Getting-and-Cleaning-Data
=========================
Programming assignment repo for Getting and Cleaning Data Coursera course. <br>
Included in this repo are:
  1. run_analysis.R - an R script designed to clean and summarize smartphone accelerometer data.[1] The original study description may be found at: <br>
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones <br> <br>
The data may be found at: <br>
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip <br>
  2. SummaryData - the resulting clean, summarized dataset obtained by running the run_analysis.R script on the data mentioned above.
  3. CodeBook - a brief description of SummaryData and a list of variables included therein.

run_analysis.R
==============
In order to use run_analysis the dataset mentioned above should be downloaded and unzipped. The working directory should be changed to "UCI HAR Dataset", which should be the folder containing all of the unzipped data.

run_analysis takes no arguments and produces a summarized, tidy dataset called DataSummary in the working directory. To derive DataSumary, the mean and standard deviation values from each featured variable of the original dataset are extracted. Then, the means of each extracted value are calculated for each subject and activity and organized into a data table.

References
==========

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
