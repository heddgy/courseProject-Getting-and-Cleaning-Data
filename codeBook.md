Additional info about original data may be found in 'UCI HAR Dataset' folder.

# Data and variables describing of the resulting file 'tidy_data_set.txt':
1. subject - integer from 1 to 30, corresponding to id of observed volunteer.
2. activity - factor with 6 levels:
* LAYING
* SITTING
* STANDING
* WALKING
* WALKING_DOWNSTAIRS
* WALKING_UPSTAIRS
and 66 numeric variables, which components of names should be treated as:
* time for time domain measurements
* frequency for frequency domain measurements
* Accelerometer for accelerometer related measurements
* Body for body accelerometer
* and Gravity for gravity accelerometer measurements
* Gyroscope for gyroscope related measurements
* Jerk and Magnitude for corresponding measurements from original data
* Mean and Std stands for mean() and std() related variables from original data
* X, Y, Z for axial differencies in measurements

# Transformations to the original data
1. Binding train and test data sets into one data set in activities, subjects and processed measurements of original data.
2. Naming appropriately via 'features.txt' file and filtering only mean() and std() related measurements, not meanFreq().
3. Labeling activity_id by activity names given in 'activity_labels.txt' of original data and nullifying activity_id column.
4. Grouping all data by subject and activity with averaging variables.
5. Cleaning variable names from dots, underscores and changing some shortages to descriptive names (t > time, Acc -> Accelerometer, etc.).
6. Saving resulting tidy data to 'tidy_data_set.txt' in working directory.