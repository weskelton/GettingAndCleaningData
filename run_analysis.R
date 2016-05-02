library(dplyr)

## download the zipped dataset from the internet and save it in a temp file
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI HAR Dataset.zip",temp)

## read the descriptive metadata for the features and activities
feature_list <- read.table(unz(temp, "UCI HAR Dataset/features.txt"), col.names = c("feature_col_num", "feature_desc"), colClasses = c(rep("numeric",561)))
activity_list <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt"), col.names = c("activity_key", "activity_desc"))

## read in the feature, subject, and activity data from the training data set
train_data <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))
train_subjects <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))
train_activities <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))

## read in the feature, subject, and activity data from the test data set
test_data <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))
test_subjects <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))
test_activities <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))

## free up the temp file
unlink(temp)

## combine the feature and activity data from the training and test data sets
all_feature_data <- rbind(train_data, test_data)
all_subject_data <- rbind(train_subjects, test_subjects)
colnames(all_subject_data) <- c("subject")
all_activity_data <- rbind(train_activities, test_activities)
colnames(all_activity_data) <- c("activity_key")

## replace parens and commas and dashes in feature_desc for use as column names
feature_list$new_feature_desc <- gsub("\\(|\\)| ","",feature_list$feature_desc)
feature_list$new_feature_desc <- gsub(",|-","_",feature_list$new_feature_desc)

## create the subset of columns containing std or mean values
included_list <- grep("mean\\(\\)|std\\(\\)", feature_list$feature_desc)
included_feature_list <- feature_list[included_list,]

## subset the data with appropiate std and mean measures and apply descriptive variable names 
tidy_data <- all_feature_data[,included_list]
colnames(tidy_data) <- included_feature_list$new_feature_desc
## add the subject and activity description to the data set
tidy_data$activity_key <- all_activity_data$activity_key
tidy_data$subject <- all_subject_data$subject
tidy_data <- merge(tidy_data,activity_list,by="activity_key")

write.table(tidy_data, "C:\\Coursera\\GettingData\\project\\tidy_data.txt", sep="\t")

tidy_summary %>% group_by(subject,activity_desc) %>% summarise_each(funs(mean))

write.table(tidy_summary, "C:\\Coursera\\GettingData\\project\\tidy_summary.txt", sep="\t")
