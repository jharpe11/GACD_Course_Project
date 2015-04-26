#############
# STEP 0
# Set the working directory to the location of the raw data files
#getwd()
#setwd("./coursera files/Getting and cleaning data/uci har dataset")

#############
# STEP 1

# Read in training and test data
X_train <- read.table("./train/X_train.txt",strip.white=TRUE)
X_test <- read.table("./test/X_test.txt",strip.white=TRUE)

# Merge training and test data
X_merge <- rbind(X_train, X_test)

# remove extra objects
remove(X_train, X_test)

#############
# STEP 2

# Read in feature names
features <- read.table("./features.txt", strip.white=TRUE, stringsAsFactors=FALSE)

# Find rows of features related to mean of signals
meanRows <- grep("mean\\(\\)",features[,2])

# Find rows of features related to standard deviation of signals
stdRows <- grep("std\\(\\)",features[,2])

# Keep only rows related to mean or standard deviation
features <- features[sort(c(meanRows, stdRows)),]

# Keep only columns of data corresponding to remaining features
X_merge <- X_merge[,features[,1]]

# remove extra objects
remove(meanRows, stdRows)

#############
# STEP 3

# Read in activity numbers for training data
y_train <- read.table("./train/y_train.txt",strip.white=TRUE)

# Read in activity numbers for test data
y_test <- read.table("./test/y_test.txt",strip.white=TRUE)

# Merge training and test activity numbers
y_merge <- rbind(y_train, y_test)

# Read in descriptive activity labels
activity_labels <- read.table("./activity_labels.txt", strip.white=TRUE, stringsAsFactors=FALSE)

# Add activity descriptions
y_merge[,2] <- activity_labels[match(y_merge[,1],activity_labels[,1]),2]

# Add activity descriptions to X_merge
yX_merge <- cbind(y_merge[,2],X_merge)
colnames(yX_merge)[1] <- "activity_labels"

# Remove extra objects
remove(y_merge, X_merge, y_train, y_test, activity_labels)


#############
# STEP 4

# Define custom function for making descriptive names
makeDescriptive <- function(feature){
    descriptiveFeature <- ""
    if (substr(feature, 1, 1)=="t") {
        descriptiveFeature <- "time_domain"
    }
    else if (substr(feature, 1, 1)=="f") {
        descriptiveFeature <- "frequency_domain"
    }
    else {
        return("unknown feature")
    }
    if (regexpr("mean\\(\\)", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_mean")
    }
    else if (regexpr("std\\(\\)", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_standard_deviation")
    } else {
        return("unknown feature")
    }
    if (regexpr("Body", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_body")
    } else if (regexpr("Gravity", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_gravity")
    } else {
        return("unknown feature")
    }
    if (regexpr("Acc", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_acceleration")
    } else if (regexpr("Gyro", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_angular_velocity")
    } else {
        return("unknown feature")
    }
    if (regexpr("Jerk", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_jerk")
    }
    if (regexpr("-X", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_x_direction")
    } else if (regexpr("-Y", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_y_direction")
    } else if (regexpr("-Z", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_z_direction")
    } else if (regexpr("Mag", feature)[1] > 0) {
        descriptiveFeature <- paste0(descriptiveFeature, "_magnitude")
    } else {
        return("unknown feature")
    }
    return(descriptiveFeature)
}

# Apply custom function to remaining features to create descriptive features
features[,3] <- unlist(lapply(features[,2],makeDescriptive))

# Add descriptive features as column names in X_merge
colnames(yX_merge)[2:ncol(yX_merge)] <- features[,3]

# remove extra objects
remove(features)


#############
# STEP 5

# Read in subject numbers for training data
subject_train <- read.table("./train/subject_train.txt",strip.white=TRUE)

# Read in subject numbers for test data
subject_test <- read.table("./test/subject_test.txt",strip.white=TRUE)

# Merge subject numbers for training and test data
subject_merge <- rbind(subject_train, subject_test)

# Add subject numbers to yX_merge
subj_yX_merge <- cbind(subject_merge, yX_merge)
colnames(subj_yX_merge)[1] <- "subject_id"

# Load dplyr library for final data summarization
library(dplyr)

# Convert subj_yX_merge to table object
subj_yX_merge <- tbl_df(subj_yX_merge)

#Use dplyr functions to group by subject_id and activity_lables and then average each variable
subj_yX_avg <- subj_yX_merge %>% group_by("subject_id","activity_labels") %>% summarise_each(funs(mean))

#Output the final tidy dataset
write.table(subj_yX_avg, file="tidy_data.txt", row.names=FALSE)