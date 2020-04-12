## Downloading the data into R and unzipping the file
downloadurl <-
        "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile <- "UCI HAR Dataset.zip"
download.file(downloadurl, zipfile)
unzip(zipfile)
path <- file.path("UCI HAR Dataset")
files <- list.files(path, recursive = TRUE)

## the descriptive variables will be Activity, Subject, Features which are contained in several of the
## contained files in the dataset; we now read the data from the files into the variables

TestData_Activity <-
        read.table(file.path(path, "test" , "Y_test.txt"), header = FALSE)
TrainData_Activity <-
        read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)

TrainData_Subject <-
        read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)
TestData_Subject  <-
        read.table(file.path(path, "test" , "subject_test.txt"), header = FALSE)

TestData_Feature <-
        read.table(file.path(path, "test" , "X_test.txt"), header = FALSE)
TrainData_Feature <-
        read.table(file.path(path, "train", "X_train.txt"), header = FALSE)

## 1. Merge the training and the test sets to create one dataset
## first combine the data from above by row, name the variables and then combine it by row in order
## to have the merged dataset
SubjectData <- rbind(TrainData_Subject, TestData_Subject)
ActivityData <- rbind(TrainData_Activity, TestData_Activity)
FeatureData <- rbind(TestData_Feature, TrainData_Feature)

names(SubjectData) <- c("subject")
names(ActivityData) <- c("activity")
dataFeaturesNames <-
        read.table(file.path(path, "features.txt"), head = FALSE)
names(FeatureData) <- dataFeaturesNames$V2

Merge <- cbind(SubjectData, ActivityData)
CompleteData <- cbind(FeatureData, Merge)

## 2. Extract only the measurements on the mean and standard deviation for each measurement: we now need
## to subset the complete dataset by measurements the have the word "mean" or "std" in it

Subset <- CompleteData[ , grepl( "subject|activity|mean|std" , names( CompleteData ) ) ]

## 3. Use descriptive activity names to name the activities in the dataset

activity_labels <- read.table(file.path(path, "activity_labels.txt"), head = FALSE)
Descriptive_Subset <- mutate(Subset, activity = activity_labels$V2[match(activity, activity_labels$V1)])

## 4. Appropriately label the data set with descriptive variable names 

names(Descriptive_Subset) <- gsub("Acc", "Accelerometer", names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("Gyro", "Gyroscope", names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("Mag", "Magnitude", names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("BodyBody", "Body", names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("^f", "Frequency", names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("^t", "Time", names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("-mean", "Mean", ignore.case = TRUE, names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("-std", "STD", ignore.case = TRUE, names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("freq", "Frequency", ignore.case = TRUE, names(Descriptive_Subset))
names(Descriptive_Subset) <- gsub("[()]", "", ignore.case = TRUE, names(Descriptive_Subset))


## 5. creates a second, independent tidy data set with the average of each variable
## for each activity and each subject.

Avg_Descriptive_Subset <- Descriptive_Subset %>% group_by(subject, activity) %>% summarise_all(mean)