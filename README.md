# second_mini_project

-Merges the training and the test sets to create one data set.

The first thing to do after setting up the working directory as the “specdata” directory,  is to load up the files (activity_labels.txt and features.txt, located in the folder UCI HAR Dataset saved in the “specdata” directory)  in R, I used file.choose() function as I was having a hard time accessing the file by directly using the read.table() function. The files were read into a list using read.table() function and then stored into variables “labels” for UCI HAR Dataset/activity_labels.txt” and “features” for  UCI HAR Dataset/features.txt. 

By using the file.choose() function, inside the “train” folder that is located inside the UCI HAR Dataset folder that is saved in the local directory “specdata”, I have accessed the data on “subject_train.txt”, the file  “X_train.txt” and the file “y_train.txt”. These files are then read into a list by read.table() function, and then passed as variables “subject_train”, “X_train”, “y_train” respectively.  In the same directory, on a separate folder from the “train” folder, files “subject_test.txt”, “X_test.txt” and “y_test.txt” located inside the “test” folder was also accessed and then passed to the read.table() function and then saved in the R session as variables “subject_test”, “X_test” and “y_test” respectively.

Using the rbind() function, “X_train” and “X_test” were row binded together, same goes with the “y_train” and “y_test”, as well as the “subject_train” and the “subject_test” variables, the row binded lists were then passed on to another variables namely, “x_traintest”, “y_traintest”, and “subj_traintest” respectively. After row binding, “x_traintest”, “y_traintest”, and “subj_traintest” were column together and passed to a variable name “merged” using the cbind() function, merging the training and the test sets together in one data set. 



-Extracts only the measurements on the mean and standard deviation for each measurement
	
	Using the select() and contain() function I created a list called “meanDev” that includes the mean and standard deviation for each measurement defined in and by “merged”, “subject”, and “activity_number”, omitting the mean frequency. 



-Uses descriptive activity names to name the activities in the dataset
-Appropriately labels the data set with descriptive variable names
	
	Using the merge function, the activity names are given descriptive activity names by merging together datasets “meanDev” and “labels” by the column “activity_number”, these merged datasets are then stored in the variable “meanDev”, 
	
By using the gather function, new variable was made namely “meanDev_” containing data for “meanDev” gathers column names for columns 4 to 76, and placing them into key column “features”, also gathering each cells belonging to column 4 to 76, and places it into a value column “measurement”. 



-From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

	In creating an independent tidy data set I first grouped “meanDev_” by “subject”, “ activity_description”, “features”  creating a grouped data set that contains the data for columns “subject”, “ activity_description”, “features”,  “Activity_number” , and “measurement”, this grouped data set is stored in the variable “grouped” which is then passed inside a summarise() function, which includes an argument “avg_measurement = mean(measurement)” which takes  the mean of the values under the column “measurement”, the columns and data in the data set “grouped” are still present the only difference is that the data set now contains the average of each variable for each activity and each subject under the column “measurements.” this new data set is then stored an independent data set namely “ave_summary”. 

Using the write.table function, “ave_summary” data set is saved in the local directory “specdata”. 
