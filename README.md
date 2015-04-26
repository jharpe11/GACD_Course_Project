---
title: "README"
author: "jharpe11"
date: "Saturday, April 25, 2015"
output: html_document
---

The run_analysis.r file includes step-by-step comments explaining each part of the script, and how it contributes to each part of the assignment.  The script assumes that the working directory is set to the "uci har dataset" folder.

### Step 1
"Merge the training and the test sets to create one data set."

The script first reads in the training and test sets on the full 561 variables, using read.table().  The training and test sets are merged together using rbind(), and then the separate training and test datasets are dropped.

### Step 2
"Extracts only the measurements on the mean and standard deviation for each measurement. "

The features names are first read in from features.txt using read.table().  Next, the rows of only the features concerned with the mean or standard deviation are determined using grep(), and then these features are extracted from the 561 variables, while dropping the others.  This leaves 66 of the 561 original variables.  Extra objects are dropped.

### Step 3
"Uses descriptive activity names to name the activities in the data set."

First, the activity ID's for the training and test datasets are read in and merged together.  Next, each of these ID's is associated with the descriptive activity label from the "activity_lables.txt" file.  These descriptive activity labels are merged onto the 66 variable dataset using cbind(), and extra objects are dropped.

### Step 4
"Appropriately labels the data set with descriptive variable names."

A custom function is defined that will take one of the 66 ugly original variable names and make it "human readable."  The function is a long set of if/else if/else statements that replaces abbreviations and rearranges the information in the original variable name.  The new variable name is made up of 6 parts in the following order:  

* (1) the first letter "t" is replaced by "time_domain" or the first letter "f" is replaced by "frequency_domain".   
* (2) the text "mean()"" is replaced by "_mean" or the text "std()" is replaced by "_standard_deviation".   
* (3)  the text "Body" is replaced by "_body" or the text "Gravity" is replaced by "_gravity".   
* (4) the text "Acc" is replaced by "_acceleration" or the text "Gyro" is replaced by "_angular_velocity".   
* (5) where applicable, the text "Jerk" is replaced by "_jerk".    
* (6) The text "-X", "-Y", "-Z", or "Mag" is replaced by "_x_direction", "_y_direction", "_z_direction", or "_magnitude", respectively.  

The custom function is applied to the list of 66 original variable names, and the more descriptive variable names are added to the dataset as column headers.  Extra objects are removed.

### Step 5
"From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject."

The subject_id's are read in for the training and test data using read.table(), and then merged onto the full dataset using cbind().  The dplyr package is loaded for the final transformation: the full dataset is converted from a data.frame object to a table object, and then the dataset is grouped by subject_id and activity_label, and then the mean of each of the 66 variables is calculated on this grouping.  

Finally, the tidy dataset is output to the working directory using write.table without row names.


.