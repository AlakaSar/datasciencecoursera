## This is a readme file for the run_analysis.R script
### Script first gets the files from the web
### It then reads  files from test and train directory and loads then in data frames
### It selects only mean and std features from the feature file
### It appends appropriate activity_label and gives appropriate header to the y_test and y_train data frames.
### Now it binds columns from  test files and prepends a column for subject to add the values from subject_t
### Next it binds columns from  train files and prepends a column for subject to add the values from subject_t

###  test_data and train_data is now merged into data

### To create tidy_data from the above merged dataset, data is grouped by and them summarized with the mean for each group

### Code book for tidy_data.txt is given in features.txt, feature_info.txt and activity_labels.txt