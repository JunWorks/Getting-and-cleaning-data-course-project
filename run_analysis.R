library(reshape2)
library(dplyr)

# Load labels and features
labels <- read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = F)
features <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = F)[,2]

#clean test dataset
test.x <- read.table("UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("UCI HAR Dataset/test/subject_test.txt")
colnames(test.x) <- features

test.x <- test.x[, grepl("mean|std", features)]
test.labels <- inner_join( test.y,labels, by = 'V1')
colnames(test.subject) <- 'subject'
colnames(test.labels) <- c('activityID', 'activity')

test <- cbind(test.subject, test.labels, test.x)

#repeat for train dataset
train.x <- read.table("UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("UCI HAR Dataset/train/subject_train.txt")
colnames(train.x) <- features

train.x <- train.x[, grepl("mean|std", features)]
train.labels <- inner_join( train.y,labels, by = 'V1')
colnames(train.subject) <- 'subject'
colnames(train.labels) <- c('activityID', 'activity')

train <- cbind(train.subject, train.labels, train.x)

all <- rbind(train, test)

tidy <- aggregate(all[, c(-1,-3)], by = list(all$subject, all$activity), mean)
colnames(tidy) <- c('subject', 'activity', colnames(tidy[, c(-1,-2)]))
tidy <- tidy %>% 
  arrange(subject, activityID) %>%
  select(-activityID)

write.table(tidy, "tidy.txt", row.names = FALSE, quote = FALSE)