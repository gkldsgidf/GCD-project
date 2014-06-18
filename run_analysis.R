## After setting the working directory:
## Load the library I'm going to use later
library(reshape2)
## Download the zip data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileURL, destfile = "./data.zip", method = "curl") 

## Unzip the zipped data
dataFolder <- "UCI HAR Dataset"
datFile <- "getdata_projectfiles_UCI HAR Dataset.zip"

if (!file.exists(dataFolder)) {
  if (file.exists(datFile)) {
    unzip(datFile)
  } else {
    stop("Zipped data file couldn't be found")
  }
}

## Set the working directory in the new folder in order to avoid long and complex address files
setwd("./UCI HAR Dataset")

## Read the activity_labels.txt file and rename columns
activity_Labels <- read.table("activity_labels.txt")
names(activity_Labels) <- c("activity_ID","activity_Type")

## Read the features.txt file and rename columns
features_Labels <- read.table("features.txt")
names(features_Labels) <- c("feature_ID","feature_Type")

## Select only the feature types to standard deviations and means
mean_Std_Features <- grepl("mean()|std()", features_Labels$feature_Type, ignore.case=FALSE)

## Read data in the subject_test.txt file and rename column 
subject_Test <- read.table("./test/subject_test.txt")
names(subject_Test) <- c("subject_ID")

## Read data in the x_test.txt file and rename column
x_Test <- read.table("./test/X_test.txt")
names(x_Test) <- features_Labels$feature_Type

## Read data in the y_test.txt file and rename column
y_Test <- read.table("./test/y_test.txt")
names(y_Test) <- c("activity_ID")

## Select the test data to only the key features. Combine labels and feature by types
x_Test_Activity <- x_Test[,mean_Std_Features]
test_Final_Data <- cbind(subject_Test,y_Test, x_Test_Activity)

## Read data in the subject_train.txt file and rename column
subject_Train <- read.table("./train/subject_train.txt")
names(subject_Train) <- c("subject_ID")

## Read data in the x_train.txt file and rename columns
x_Train <- read.table("./train/X_train.txt")
names(x_Train) <- features_Labels$feature_Type

## Read data in the y_train.txt file and rename columns
y_Train <- read.table("./train/y_train.txt")
names(y_Train) <- c("activity_ID")

## Select the test data to only the key features. Combine labels and feature by types
x_Train_Activity <- x_Train[,mean_Std_Features]
train_Final_Data <- cbind(subject_Train,y_Train, x_Train_Activity)

## Combine both test and train datasets inot one
total_Final_Data <- rbind(test_Final_Data, train_Final_Data)

## Melt the final data by subjects and activities
melted_Final_Data <- melt(total_Final_Data, id=c("subject_ID", "activity_ID"))

## Cast the final data according to its mean
target_Data <- dcast(melted_Final_Data, subject_ID + activity_ID ~ variable, mean)

## Rename target data by activity names
target_Data[,2][target_Data[,2] == "1"] <- "WALKING"
target_Data[,2][target_Data[,2] == "2"] <- "WALKING_UPSTAIRS"
target_Data[,2][target_Data[,2] == "3"] <- "WALKING_DOWNSTAIRS"
target_Data[,2][target_Data[,2] == "4"] <- "SITTING"
target_Data[,2][target_Data[,2] == "5"] <- "STANDING"
target_Data[,2][target_Data[,2] == "6"] <- "LAYING"

## Finally, create the final tidy dataset
write.table(target_Data, file="Human activity recognition using smartphones data.txt")

