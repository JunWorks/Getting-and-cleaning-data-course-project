# Getting and Cleaning Data 

Course project:

In this repo, the file 'run_analysis.R' takes the raw data in foler 'UCI HAR Dataset' and ouputs another set of data 'tidy.txt'. Specifically, it does:

1: read activity_labels and features
2: choose the features we are interested in (mean and std)
3: read X_test (or X_train) and select columns with chosen features
4: combine subject_test, X_test and y_test, merge with activity_lables based on y_test
5: combine test and train datasets
6: calculate the mean for each subject and each activity and put the calculation into a new set of data
7: output the new data to tidy.txt