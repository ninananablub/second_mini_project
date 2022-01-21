setwd('/Users/Acer/Documents/specdata')
getwd()


library(dplyr)
library(tidyr)

f <- file.choose("UCI HAR Dataset/activity_labels.txt")
g <- file.choose("UCI HAR Dataset/features.txt")
  
labels <- read.table(f, header = F, col.names = c("activity_number", "activity_description"))
features <- read.table(g, header = F, col.names = c("number", "description"))



sub_train <- file.choose("UCI HAR Dataset/train/subject_train.txt")
x_trn <- file.choose("UCI HAR Dataset/train/X_train.txt")
y_trn <- file.choose("UCI HAR Dataset/train/y_train.txt")


subject_train <- read.table(sub_train, header = F, col.names = "subject")
X_train <- read.table(x_trn, sep = "", header = F, col.names = features$description)
y_train <- read.table(y_trn, sep = " ", header = F, col.names = "activity_number")



sub_test <- file.choose("UCI HAR Dataset/test/subject_test.txt")
x_tst <- file.choose("UCI HAR Dataset/test/X_test.txt")
y_tst <- file.choose("UCI HAR Dataset/test/y_test.txt")

subject_test <- read.table(sub_test, header = F, col.names = "subject")
X_test <- read.table(x_tst, sep = "", header = F, col.names = features$description)
y_test <- read.table(y_tst, sep = "", header = F, col.names = "activity_number")


x_traintest <- rbind(X_train, X_test)
y_traintest <- rbind(y_train, y_test)
subj_traintest <- rbind(subject_train, subject_test)



merged <- cbind(subj_traintest, y_traintest, x_traintest)


meanDev <- select(merged, subject, activity_number, contains("mean"), contains("std"), -contains("meanFreq"))


meanDev <- merge(meanDev, labels, by = "activity_number")


meanDev <- meanDev %>% 
  select(2, 1, 76, 3:75) %>% 
  arrange(subject, activity_number)



meanDev$subject <- as.factor(meanDev$subject)
meanDev$activity_number <- as.factor(meanDev$activity_number)


meanDev_ <- gather(meanDev, "features", "measurement", 4:76)


grouped <- group_by(meanDev_, subject, activity_description, features)
ave_summary <- summarise(grouped, avg_measurement = mean(measurement))


write.table(meanDev, file = "UCI_HAR_tidy_dataset.txt", quote = F
            , sep = " ", row.names = F, col.names = T)








