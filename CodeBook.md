The run_analysis.R script first downloads and prepares the available data set and then follows the five assignments that are required for the Peer Review Assignment

### STEP 1: The data set is downloaded and unzipped (folder: UCI HAR Dataset)

### STEP 2: The data which is located in different folders is read in and named (assigned to variables)

* TestData_Activity <-
        read.table(file.path(path, "test" , "Y_test.txt"), header = FALSE)

Recorded data on activities for the test group (2947 rows, 1 column) 

* TrainData_Activity <-
        read.table(file.path(path, "train", "Y_train.txt"), header = FALSE)

Recorded data on activities for the train group (7352 rows, 1 column)

* TrainData_Subject <-
        read.table(file.path(path, "train", "subject_train.txt"), header = FALSE)

Recorded data on subjects for the train group (21/30 volunteers) (7353 rows, 1 column)

* TestData_Subject  <-
        read.table(file.path(path, "test" , "subject_test.txt"), header = FALSE)

Recorded data on subjects for the test group (9/30 volunteers) (2947 rows, 1 column)

* TestData_Feature <-
        read.table(file.path(path, "test" , "X_test.txt"), header = FALSE)

Recorded data on features for the test group (2947 rows, 561 column)

* TrainData_Feature <-
        read.table(file.path(path, "train", "X_train.txt"), header = FALSE)

Recorded data on features for the train group (7353 rows, 561 columns)        

### STEP 3: Task1

* Using the rbind() function the SubjectData is created, containing TrainData_Subject and TestData_Subject
* Using the rbind() function the ActivityData is created, containing TrainData_Activity and TestData_Activity
* Using the rbind() function the FeatureData is created, containing TestData_Feature, TrainData_Feature

* The headers for each column created are renamed into "subject", "activity" and the respective Feature using the names() function; the names for the Features column are used from the second column (V2) of the FeatureData created above  

* SubjectData, ActivityData and FeatureData are merged creating one data set called "Complete Data"

### STEP 4: Task2
        
A subset of the CompleteData set is extracted using the grepl() function. The subject and activity columns are selected and then measurements on the mean and standard deviation for each measurement are extracted. The subset is stored in a new variable called "Subset" 

### STEP 5: Task3
        
All numbers of the activity column in the Subset are replaced with the corresponding activity label usind the mutate() function. The activity labels are extracted from the second column of the activities variable. The new dataset is stored in a variable named Descriptive_Subset.

### STEP 6: Task4
        
The following abbreviations are transformed into descriptive variable names in the Descriptive_Subset using the gsub() function:  

 "Acc" to "Accelerometer"
 "Gyro" to "Gyroscope"
 "Mag" to "Magnitude"
 "BodyBody" to "Body"
 "-mean" to "Mean"
 "-std" to "STD"
 "^f" to "Frequency", i.e. all start with chracter f changes to Frequency
 "^t" to "Time", i.e. all start with character t changes to Time
 "freq" to "Frequency"
 "[()]" to "", i.e. the parenthesis are removed 
 
### STEP 7: Task5

Avg_Descriptive_Subset is created as the final data set. It contains 180 rows and 81 columns. It summarises the Descriptive_Subset using the summarise() funcion, first it groups the data set by subject and activity and then it takes the average (means) of each variable for each activity and each subject. 




