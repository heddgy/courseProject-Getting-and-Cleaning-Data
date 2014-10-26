# Needed for grouping variables by activity and subject columns

library(reshape2)

# Needed for adding descriptive variable names.

gsub2 <- function(pattern, replacement, x, ...) {
      for(i in 1:length(pattern))
            x <- gsub(pattern[i], replacement[i], x, ...)
      x
}

message("extracting data")

# Reading all the files we need and naming some of it. Integer subject for further sorting.

names <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactors = F, col.names = c('row', 'name'))
activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c('activityid', 'activity'))
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", colClasses = "integer", col.names = 'subject')
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", colClasses = "integer", col.names = 'subject')
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "activityid")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "activityid")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = names$name)
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = names$name)

message("transforming data")

# Step 1: Merging the training and the test sets to create one data set.

subject <- rbind(subject_test, subject_train); rm(subject_test, subject_train)
activity <- rbind(y_test, y_train); rm(y_test, y_train)

# Step 2: Extracting only the measurements on the mean and standard deviation for each measurement. Only mean() and std() functions.

columns <- grep("mean\\(\\)|std\\(\\)", names$name); rm(names)
x <- rbind(x_test[, columns], x_train[, columns]); rm(x_test, x_train, columns)

# Step 3: Using descriptive activity names for activities in the data set. Droping activity id column.

data <- cbind(x, subject, activity); rm(x, subject, activity)
data <- merge(data, activities); rm(activities); data$activityid <- NULL

# Step 5: Creating an independent tidy data set with the average of each variable for each activity and each subject.

data_melt <- melt(data, id = c("subject", "activity"), measure.vars = names(data)[1:(length(names(data))-2)]); rm(data)
result <- dcast(data_melt, subject + activity ~ variable, mean); rm(data_melt)
result <- result[order(result$subject, result$activity), ]

# Step 4: Appropriately labeling the data set with descriptive variable names. 

pattern = c("\\.", "BodyBody", "mean", "std", "Acc", "Gyro", "Mag", "tBody", "tGravity", "fBody")
replacement = c("", "Body", "Mean", "Std", "Accelerometer", "Gyroscope", "Magnitude", "timeBody", "timeGravity", "frequencyBody")
names(result) <- gsub2(pattern, replacement, names(result))

# Final: Writing result tidy data set to the txt file.

write.table(result, './tidy_data_set.txt', row.names = F); rm(result, pattern, replacement, gsub2)

message('tidy_data_set.txt created')