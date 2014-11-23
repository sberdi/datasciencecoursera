# Create one R script called run_analysis.R that does the following:
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names.
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


require("data.table")
require("reshape2")

# read and load activity_labels.txt
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

# read and load features.txt
features <- read.table("./UCI HAR Dataset/features.txt")[,2]

# grep for mean and std of features only
extract_features <- grepl("mean|std", features)

# read and load the following test files
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features
X_test = X_test[,extract_features]

# get the activity labels
y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# bind the data as test data
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# read and load X and Y train results
X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")

subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

names(X_train) = features
X_train = X_train[,extract_features]

# get activity labels
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# bind data as training data
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

# rbind all data to final dataset
data = rbind(test_data, train_data)

# get appropriate data fields
id_labels   = c("subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

# apply the mean function to dataset
tidy_data   = dcast(melt_data, subject + Activity_Label ~ variable, mean)

# write final dataset to file
write.table(tidy_data, file = "./tidy_data.txt", row.name=FALSE)