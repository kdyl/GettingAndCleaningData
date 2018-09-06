
## LOADING DATA
setwd("E:/COURSERA/DATA ANALYSIS/Data Science/3. Getting and Cleaning Data/Final project/UCI HAR Dataset")
features <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")
setwd("test")
test_data <- read.table("X_test.txt")
test_act <- read.table("y_test.txt")
subject_test <- read.table("subject_test.txt")
setwd("../train")
train_data <- read.table("X_train.txt")
train_act <- read.table("y_train.txt")
subject_train <- read.table("subject_train.txt")


## MERGING DATA
merged_data <- rbind(test_data,train_data)


## GIVE DESCRIPTIVE VARIABLE NAMES
names(merged_data) <- features$V2


## FIND INDICES OF MEAN & STD
idx <- grep("mean|std", features$V2)


## KEEP ONLY MEAN & STD
mean_std_data <- merged_data[,idx]


## ADDING ACTIVITIES TO DATA AND ACTIVITIES NAMES
act_merg <- rbind(test_act, train_act) #adding activities from test and train
names(act_merg) <- "Act_No"
mean_std_act_data <- cbind(act_merg, mean_std_data) #adding activities to data


## CONVERTING ACTIVITY NO TO ACTIVITY NAMES
names(activity_labels) <- c("Act_No", "activity")
library(plyr)
inter_data <- join(activity_labels,mean_std_act_data)
library(dplyr)
data_step4 <- select(inter_data, -(Act_No))


## ADDING SUBJECTS
sub_merg <- rbind(subject_test, subject_train) #adding subjects from test and train
names(sub_merg) <- "subject"
data_sub <- cbind(sub_merg, data_step4) #adding subjects to data


## GROUPING BY SUBJECTS AND ACTIVITIES
grouped_data <- group_by(data_sub, subject, activity)
final_data <- summarize_all(grouped_data, mean)


## REMOVING UNNECESSARY VARIABLES
rm("act_merg")
rm("activity_labels")
rm("data_step4")
rm("data_sub")
rm("features")
rm("grouped_data")
rm("inter_data")
rm("mean_std_act_data")
rm("mean_std_data")
rm("merged_data")
rm("sub_merg")
rm("subject_test")
rm("subject_train")
rm("test_act")
rm("test_data")
rm("train_act")
rm("train_data")
rm("idx")