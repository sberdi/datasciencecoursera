Coursera Getting and Cleaning Data Project Readme
=========================================

Purpose: This is a readme file describe the run_analysis.R R script that performs the following operations at a high level:

* R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Step 1
The script makes sure the appropriate packages are loaded and available

# Step 2
The script loads appropriate source data including activitey labels, features and test data

# Step 3
First the test datasets are binded and merged to a final test dataset

# Step 4
Then the training dataset are binded and merged to a final training dataset

# Step 5
The test and training databaset are merged to one final dataset

# Step 6
The final dataset is output to a text file called tidy_data with the applied mean function

