---
title: "Getting and Cleaning Data: Course Project"
author: "jharpe11"
date: "Saturday, April 25, 2015"
output: html_document
---

### Study Design
Scientists at UC Irvine asked 30 adults to wear a smartphone while performing a set of movements.  The smartphone's accelerometer and gyroscope recorded acceleration and angular velocity measurements, while the scientists recorded the associated movement.

Complete information about the original study can be found here:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones



### Raw Data

The raw data includes 10,299 observations on 561 variables, where the observations were split into training and test data.  

From the 'features_info.txt' file:

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

###Processed Data
The variables included in the tidy dataset for this project represent transformations on a subset of 66 of the original 561 variables.  The subset includes only the measurements on the mean() and standard deviation (std()) of the time domain and frequency domain variables, as per the instructions in step 2 for the run_analysis.r file.  Acceleration variables were measured by the accelerometer in standard gravity units, and angular velocity variables were measured by the gyroscope in radians/second.  The list below is the subset of the original variables that were further transformed in creating the tidy dataset.  They have been renamed to be "readable by humans."  The final transformation performed on the below subset of variables was to take the average of each subject/activity combination, as per step 5 of the assignment.  That is, 6 unique activities * 30 subjects = 180 observations on each of the 66 variables.  

time_domain_mean_body_acceleration_x_direction  
time_domain_mean_body_acceleration_y_direction  
time_domain_mean_body_acceleration_z_direction  
time_domain_standard_deviation_body_acceleration_x_direction  
time_domain_standard_deviation_body_acceleration_y_direction  
time_domain_standard_deviation_body_acceleration_z_direction  
time_domain_mean_gravity_acceleration_x_direction  
time_domain_mean_gravity_acceleration_y_direction  
time_domain_mean_gravity_acceleration_z_direction  
time_domain_standard_deviation_gravity_acceleration_x_direction  
time_domain_standard_deviation_gravity_acceleration_y_direction  
time_domain_standard_deviation_gravity_acceleration_z_direction  
time_domain_mean_body_acceleration_jerk_x_direction  
time_domain_mean_body_acceleration_jerk_y_direction  
time_domain_mean_body_acceleration_jerk_z_direction  
time_domain_standard_deviation_body_acceleration_jerk_x_direction  
time_domain_standard_deviation_body_acceleration_jerk_y_direction  
time_domain_standard_deviation_body_acceleration_jerk_z_direction  
time_domain_mean_body_angular_velocity_x_direction  
time_domain_mean_body_angular_velocity_y_direction  
time_domain_mean_body_angular_velocity_z_direction  
time_domain_standard_deviation_body_angular_velocity_x_direction  
time_domain_standard_deviation_body_angular_velocity_y_direction  
time_domain_standard_deviation_body_angular_velocity_z_direction  
time_domain_mean_body_angular_velocity_jerk_x_direction  
time_domain_mean_body_angular_velocity_jerk_y_direction  
time_domain_mean_body_angular_velocity_jerk_z_direction  
time_domain_standard_deviation_body_angular_velocity_jerk_x_direction  
time_domain_standard_deviation_body_angular_velocity_jerk_y_direction  
time_domain_standard_deviation_body_angular_velocity_jerk_z_direction  
time_domain_mean_body_acceleration_magnitude  
time_domain_standard_deviation_body_acceleration_magnitude  
time_domain_mean_gravity_acceleration_magnitude  
time_domain_standard_deviation_gravity_acceleration_magnitude  
time_domain_mean_body_acceleration_jerk_magnitude  
time_domain_standard_deviation_body_acceleration_jerk_magnitude  
time_domain_mean_body_angular_velocity_magnitude  
time_domain_standard_deviation_body_angular_velocity_magnitude  
time_domain_mean_body_angular_velocity_jerk_magnitude  
time_domain_standard_deviation_body_angular_velocity_jerk_magnitude  
frequency_domain_mean_body_acceleration_x_direction  
frequency_domain_mean_body_acceleration_y_direction  
frequency_domain_mean_body_acceleration_z_direction  
frequency_domain_standard_deviation_body_acceleration_x_direction  
frequency_domain_standard_deviation_body_acceleration_y_direction  
frequency_domain_standard_deviation_body_acceleration_z_direction  
frequency_domain_mean_body_acceleration_jerk_x_direction  
frequency_domain_mean_body_acceleration_jerk_y_direction  
frequency_domain_mean_body_acceleration_jerk_z_direction  
frequency_domain_standard_deviation_body_acceleration_jerk_x_direction  
frequency_domain_standard_deviation_body_acceleration_jerk_y_direction  
frequency_domain_standard_deviation_body_acceleration_jerk_z_direction  
frequency_domain_mean_body_angular_velocity_x_direction  
frequency_domain_mean_body_angular_velocity_y_direction  
frequency_domain_mean_body_angular_velocity_z_direction  
frequency_domain_standard_deviation_body_angular_velocity_x_direction  
frequency_domain_standard_deviation_body_angular_velocity_y_direction  
frequency_domain_standard_deviation_body_angular_velocity_z_direction  
frequency_domain_mean_body_acceleration_magnitude  
frequency_domain_standard_deviation_body_acceleration_magnitude  
frequency_domain_mean_body_acceleration_jerk_magnitude  
frequency_domain_standard_deviation_body_acceleration_jerk_magnitude  
frequency_domain_mean_body_angular_velocity_magnitude  
frequency_domain_standard_deviation_body_angular_velocity_magnitude  
frequency_domain_mean_body_angular_velocity_jerk_magnitude  
frequency_domain_standard_deviation_body_angular_velocity_jerk_magnitude  





.