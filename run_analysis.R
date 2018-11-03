# This R script creates a tidy data set from the UCI HAR Dataset

library(dplyr)

# Read in all the files
wd <- getwd()
setwd(paste(wd, '/UCI HAR Dataset/train', sep = ''))
y_train <- read.table('y_train.txt')
x_train <- read.table('x_train.txt')
sub_train <- read.table('subject_train.txt')

setwd(paste(wd, '/UCI HAR Dataset/test', sep = ''))
y_test <- read.table('y_test.txt')
x_test <- read.table('x_test.txt')
sub_test <- read.table('subject_test.txt')

setwd(paste(wd, '/UCI HAR Dataset', sep = ''))
features <- read.table('features.txt')
features <- as.character(features[,2])

setwd(wd)

# Create a train data frame
df_train <- data.frame(sub_train, y_train, partition = 'train', x_train)
colnames(df_train) <- c('Subject', 'Activity', 'Partition', features)

#Create a test data frame
df_test <- data.frame(sub_test, y_test, partition = 'test', x_test)
colnames(df_test) <- c('Subject', 'Activity', 'Partition', features)

# 1. Merges the training and the test sets to create one data set.
df1 <- rbind(df_train, df_test)

# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement. 

grep_mean_feature <- grep('mean()', features, fixed = T)
grep_std_feature <- grep('std()', features, fixed = T) 
grep_union <- c(grep_mean_feature, grep_std_feature)

coords <- sort(c(1,2,3, grep_union + 3)) # this vector will be used for subsetting

df2 <- df1[, coords]

# 3. Uses descriptive activity names to name the activities in the data set

df2$Activity <- sub('1', 'Walking', df2$Activity)
df2$Activity <- sub('2', 'Walking Upstairs', df2$Activity)
df2$Activity <- sub('3', 'Walking Downstairs', df2$Activity)
df2$Activity <- sub('4', 'Sitting', df2$Activity)
df2$Activity <- sub('5', 'Standing', df2$Activity)
df2$Activity <- sub('6', 'Laying', df2$Activity)

# 4. Appropriately labels the data set with descriptive variable names. 

colnames(df2) <- sub('tBody', 'Time.Body.', colnames(df2), fixed = T)
colnames(df2) <- sub('tGravity', 'Time.Gravity.', colnames(df2), fixed = T)
colnames(df2) <- sub('fBody', 'Freq.Body.,', colnames(df2), fixed = T)
colnames(df2) <- sub('fGravity', 'Freq.Gravity.', colnames(df2), fixed = T)
colnames(df2) <- sub('Acc', 'Accelerometer.', colnames(df2), fixed = T)
colnames(df2) <- sub('Gyro', 'Gyroscope.', colnames(df2), fixed = T)
colnames(df2) <- sub('-mean()', 'Mean.', colnames(df2), fixed = T)
colnames(df2) <- sub('-std()', 'StdDev.', colnames(df2), fixed = T)
colnames(df2) <- sub('Jerk', 'Jerk.', colnames(df2), fixed = T)
colnames(df2) <- sub('Mag', 'Magnitude.', colnames(df2), fixed = T)
colnames(df2) <- sub('.,', '.', colnames(df2), fixed = T)
colnames(df2) <- sub('Body.Body', 'Body.', colnames(df2), fixed = T)

# 5. From the data set in step 4, creates a second, independent tidy data set 
#    with the average of each variable for each activity and each subject.

df3 <- df2[, -3]
df4_tbl <- tbl_df(df3) %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))

colnames(df3_tbl) <- sub('Time.', 'Mean of Time.', colnames(df3_tbl), fixed = T)
colnames(df3_tbl) <- sub('Freq.', 'Mean of Freq.', colnames(df3_tbl), fixed = T)

write.table(df3_tbl, file = 'final_dataset.txt', row.names = F)
