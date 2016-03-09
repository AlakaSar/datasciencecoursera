## Create one R script called run_analysis.R that does the following:
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names.
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplyr)

if(!file.exists("UCI HAR Dataset.zip")) {
  temp <- tempfile()
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
  file <- unzip(temp)
  unlink(temp)
}

# read all the files for test.
# create a logical vector to keep only mean and std features. 
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features <- grepl("mean|std", features)
X_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

names(X_test) = features
X_test = X_test[,extract_features]

y_test[,2] = activity_labels[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "subject"

# Bind data
test_data <- cbind(subject_test, y_test, X_test)


# read all the files for train.
# use the logical vector to keep only mean and std features. 

X_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(X_train) = features

# Extract only the measurements on the mean and standard deviation for each measurement.
X_train = X_train[,extract_features]
y_train[,2] = activity_labels[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "subject"

# Bind data
train_data <- cbind(subject_train, y_train, X_train)

# Merge test and train data
data = rbind(test_data, train_data)


##Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

datagr<-group_by (data, subject, Activity_ID, Activity_Label)
tidy_data<-summarise_each(datagr, funs(mean(., na.rm=TRUE)), -subject, -Activity_ID, -Activity_Label)


write.table(tidy_data, file = "./tidy_data.txt")
