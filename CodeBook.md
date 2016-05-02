# Getting and Cleaning Data Course Project CodeBook

The run_analysis.R script takes the following steps

* Download the zipped dataset from the internet and save it in a temp file

Original Source: https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI HAR Dataset.zip

* reads the descriptive metadata for the features and activities

* reads in the feature, subject, and activity data from the training data set

* reads in the feature, subject, and activity data from the test data set

* combines the feature, subject, and activity data from the training and test data sets

* cleans the column names from the features list for use in the tidy data set

* creates the subset of feature columns containing std or mean values

* add the subject and activity description to the data set

* writes the tidy data set with activity, subject and selected feature data

* writes a summary data set with the mean of each feature, summarized by subject and activity
