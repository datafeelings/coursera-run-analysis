### Readme

This is a description of the course project R script for the Coursera class 
"Getting and Cleaning Data". The assignment details can be found here:
https://class.coursera.org/getdata-005/human_grading/view/courses/972582/assessments/3/submissions

Assignment: you should create one R script called run_analysis.R that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

Here is the solution. Please note that I changed the order of the required operations.


### Required data
You need to download and unpack the following file into the same folder where the script is.
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

If you clone this full repository, you will already have all the files you need.
You then should run the script "run_analysis.R" to get the tidy dataset.
It will be stored in the file "tidy_data.txt" in the same directory. Refer to Codebook.md for the explanation of its contents.

This are the steps "run_analysis.R" goes through to generate the result. Please open the script in RStudio to see the variables performing the operations described below.

### STEP 0. 
Check if the directory with the data is available

### STEP 1. 
MERGING the training and the test sets to create one data set.

* Import training datasets
* Add columns with subjects and activities to the training dataset
* Import test datasets
* Add columns with subjects and activities to the test dataset
* Generate a merged data frame with the test and the training datasets combined. As columns names are the same, there should be no problems.

### STEP 4. 
Appropriately LABELING the data set with descriptive VARIABLE NAMES from the assignment description is done now to enable easier tracking of column names and subsetting of correct columns.

* Import feature labels and extract feature label column
* Put features as column names of the merged dataset after subject and activity columns


### STEP 2. 
EXTRACTING only the measurements on the mean and standard deviation for each measurement: all columns containing "mean()" and "std()" in the name will be extracted.

* Analyze the columns string and find the necessary locations
* Extract columns with activity, subject, mean and std values from the merged dataset from STEP 1 and 4 into a new dataframe
* Just the new data frame subset is used further on to free up memory.

### STEP 3. 
Using descriptive ACTIVITY NAMES to name the activities in the data set

* Import activity labels
* Replace numbers with the factors in the "activity" column of the data frame from STEP 2.

### STEP 5. 
CREATE a second, independent TIDY DATA SET with the average of each variable for each activity and each subject. 

* Create a new data frame containing mean values of all other variables for each pair of "subject" and "activity" variables. And write it to a CSV file in the working directory.

### Final step:

* Clear RAM, as the required data has been exported - this part can be disabled for debugging / control of variables in RStudio.