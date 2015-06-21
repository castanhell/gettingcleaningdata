##  Run_analysis.R
##  Written by Castannhell
##

#Part 1 - Loading the files

#Loading training/test data colnames (Or feature names)
train_data_colnames <- read.table("UCI HAR Dataset/features.txt")$V2

#Loading activity names
activity_names <- read.table("UCI HAR Dataset/activity_labels.txt")
colnames(activity_names) <- c("Id", "ActivityName")

#Loading traning data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_data <- cbind(read.table("UCI HAR Dataset/train/subject_train.txt"),train_data)
train_data <- cbind(read.table("UCI HAR Dataset/train/y_train.txt"),train_data)
#Loading test data
test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_data <- cbind(read.table("UCI HAR Dataset/test/subject_test.txt"),test_data)
test_data <- cbind(read.table("UCI HAR Dataset/test/y_test.txt"),test_data)

# You should not rbind with wrong dimensions
stopifnot(dim(train_data)[2] == dim(test_data)[2])

#Merges both datasets
full_ds <- rbind(train_data,test_data)

#Clears train and test data for memory cost reduction
remove(train_data, test_data)

#sets the colnames
colnames(full_ds) <- c("ActivityName", "IndividualNumber", as.vector(train_data_colnames))

#reduces full_ds to only std and mean (Do not forget to remove Freq)
#which I consider for sake unneccessary for this exercise
#Remember: Index 1 = Activity Name, Index 2 = Individual Number
desiredcols <- c(1, 2, grep("std()",colnames(full_ds)),grep("mean()",colnames(full_ds)))
undesiredcols <- c(grep("Freq",colnames(full_ds)))
desiredcols <- desiredcols[!desiredcols %in% undesiredcols]
full_ds <- full_ds[,desiredcols]
