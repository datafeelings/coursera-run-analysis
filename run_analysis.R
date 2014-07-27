cat ("Hello.", fill = 40)

# check if the directory with the data is available
if (file.exists("./UCI HAR Dataset/")) {
        cat ("Data set found", fill = 40)} else {
        cat ("Please put the unpacked folder 'UCI HAR Dataset' into working 
             directory to proceed!", fill = 80)
        stop()
}

cat ("Loading data.", fill = 40)
cat ("Please be patient...", fill = 40)
cat ("This may take more than 30 seconds", fill = 80)

# 1. MERGING the training and the test sets to create one data set.

# import training datasets
start_time = Sys.time()
cat ("Loading training dataset...", fill = 40)

train = read.table("./UCI HAR Dataset/train/X_train.txt")
train_sub = read.table("./UCI HAR Dataset/train/subject_train.txt")
train_act = read.table("./UCI HAR Dataset/train/y_train.txt")

time1 = Sys.time()
time1 = time1 - start_time
cat ("Loading training dataset...COMPLETE in ", time1, "sec", fill = 80)

# add columns with subjects and activities to the training dataset

train1 = cbind (train_sub, train_act, train)


# import test datasets
cat ("Loading test dataset...", fill = 40)

test = read.table("./UCI HAR Dataset/test/X_test.txt")
test_sub = read.table("./UCI HAR Dataset/test/subject_test.txt")
test_act = read.table("./UCI HAR Dataset/test/y_test.txt")

time2 = Sys.time()
time2 = time2 - time1
cat ("Loading test dataset...COMPLETE", fill = 80)

# add columns with subjects and activities to the test dataset
test1 = cbind (test_sub, test_act, test)

# Generate a merged data frame with the test and the training datasets combined. 
# As columns names are the same, there should be no problems.

cat ("Merging data....", fill = 40)

data = rbind(train1, test1)

# Appropriately LABELING the data set with descriptive VARIABLE NAMES - Step 4.
# from the assignment description is done now to enable easier tracking of
# column names and subsetting of correct columns.

# import feature labels and extract feature label column
feat = read.table("./UCI HAR Dataset/features.txt") 
columns = feat[,2] 
columns = as.vector(columns)

# put features as column names of the merged dataset after subject and 
# activity columns

colnames(data) = c("subject", "activity", columns)

cat ("Merging data....COMPLETE", fill = 40)


# 2. EXTRACTING only the measurements on the mean and standard deviation 
# for each measurement: all columns containing "mean()" and "std()" in the name 
# will be extracted.

cat ("Subsetting data....", fill = 40)


# analyze the columns string and find the necessary locations
mean_columns = grep("mean()", columns, fixed = TRUE)
std_columns = grep ("std()", columns, fixed = TRUE)

# extract columns with activity, subject, mean and std values from the 
# merged dataset into a new dataframe

mean1 = mean_columns + 2 # correct the index as 2 additional columns are preceding
std1 = std_columns + 2 # same here
plus = c (1,2) # column positions for "activity" and "subject" variables
sorting = c(plus,mean1,std1) # this is the string with the column numbers to extract

data = data[, sorting]  # data frame after the subset. 
                        # I replace the original data frame to free up memory.

cat ("Subsetting data....COMPLETE", fill = 40)

# 3. Using descriptive ACTIVITY NAMES to name the activities in the data set

# import activity labels
activities = read.table("./UCI HAR Dataset/activity_labels.txt")
act_labels = as.character(activities [,2])

# replace numbers with the factors in the "activity" column of the data frame
act_labels_f = factor (data$activity, labels = act_labels)
data$activity = act_labels_f

# 4. Appropriately LABELING the data set with descriptive VARIABLE NAMES. 
# This has already been done within step 1.

# 5. CREATE a second, independent TIDY DATA SET with the average of each 
# variable for each activity and each subject. 

cat ("Creating a new tidy data set....", fill = 40)

# create a new data frame containing mean values of all other variables for 
# each pair of "subject" and "activity" variables. And write it to a CSV file in 
# the working directory

agg_data = aggregate( .~ subject + activity, data = data, FUN = mean)
write.csv(agg_data, "./tidy_data.txt", row.names=F)

time3 = Sys.time()
time3 = time3 - start_time

cat ("Tidy data set EXPORTED to ./tidy_data.csv", fill = 40)
cat ("Script finished in", time3, "sec", fill = 80 )

rm(list=ls()) # clears RAM, as the required data has been exported, you can
              # disable this part for debugging / control of variables
cat ("Cleaning up...COMPLETE", fill = 40)