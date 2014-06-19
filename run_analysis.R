require(plyr)

## Download .zip file to working directory
url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
wk_dir=getwd()
zip_file = paste(wk_dir,"/Dataset.zip", sep="")
download.file(url, destfile=zip_file)

## Extract .zip to subdirectory datadir under working directory
extractdir = paste(wk_dir,"/datadir", sep="")
unzip(zip_file, overwrite=TRUE, exdir=extractdir)

## Set rootdir as the roo directory that caontins all extracted data files
rootdir = paste(extractdir, "/UCI HAR Dataset/", sep="")

## Set test data path
test_dir = paste(rootdir, "test/", sep="")

## Set train data path
train_dir = paste(rootdir, "train/", sep="")

## Set file paths to all related data files
feature_file = paste(rootdir, "features.txt", sep="")

test_x_file = paste(test_dir,"X_test.txt", sep="")
test_y_file = paste(test_dir,"Y_test.txt", sep="")
test_subject_file = paste(test_dir,"subject_test.txt", sep="")
train_x_file = paste(train_dir,"X_train.txt", sep="")
train_y_file = paste(train_dir,"Y_train.txt", sep="")
train_subject_file = paste(train_dir,"subject_train.txt", sep="")

## Read features data - the data will be used as column names for X data
df_features = read.table(feature_file, col.names=c("num","name"))
featurenames = df_features$name

## Read test and train X data and combine the data
df_test_x = read.table(test_x_file)
df_train_x = read.table(train_x_file)

## Read test and train Y data and combine the data 
df_test_y = read.table(test_y_file, col.name=c("activity"))
df_train_y = read.table(train_y_file, col.name=c("activity"))

## Read test and train subject data and combine the data 
df_test_subject = read.table(test_subject_file, col.name=c("subject"))
df_train_subject = read.table(train_subject_file, col.name=c("subject"))

## Merge Y, subject and X datasets into one dataset
## For: 1.Merges the training and the test sets to create one data set.
df_alldata_x = rbind(df_train_x, df_test_x)
df_alldata_y = rbind(df_train_y,df_test_y)
df_subject=rbind(df_train_subject, df_test_subject)

df_alldata=cbind(df_alldata_y, df_subject, df_alldata_x)

## Get mean and std of each measurement and also keep activity and subject data
## For 2.Extracts only the measurements on the mean and standard deviation for each measurement
cnames=c("activity", "subject", as.character(featurenames))
selector = grepl("mean|std",cnames) 
exclude = grepl("meanFreq",cnames)
selector=xor(selector, exclude)
# Keep activity and subject
selector[1:2] = TRUE
df_mean_std = df_alldata[selector]

## read activity labels
act_file = paste(rootdir, "activity_labels.txt", sep="")
df_act = read.table(act_file,col.names=c("activity","actname"))
df_act$actname = sub("_","",tolower(df_act$actname))

## Uses descriptive activity names to name the activities in the data set
## by joining dataset df_all_data_y and df_act (on "activity")
## For 3.Uses descriptive activity names to name the activities in the data set
df_y_names = join(df_alldata_y, df_act)
actname = df_y_names$actname

## Label the rows with descriptive label names
## For: 4.Appropriately labels the data set with descriptive variable names
## Remove special characters like ( ) - etc
## change to lower case
## Change bodybody to body
cnames = sub("bodybody","body",tolower(gsub("[^[:alnum:]]","",cnames)))
cnames_tidy = cnames[selector]
names(df_mean_std) = cnames_tidy
df_mean_std_labels = cbind(actname,df_mean_std)


## Aggregate by activity and subject using FUN mean
## 5.Creates a second, independent tidy data set with the average of 
## each variable for each activity and each subject.
cnames1 = colnames(df_mean_std_labels)
len = length(cnames1)
df_mean_tidy = aggregate(df_mean_std_labels[4:len], by=list(df_mean_std_labels$actname,
  df_mean_std_labels$activity,df_mean_std_labels$subject), FUN=mean)
colnames(df_mean_tidy) = cnames1

df_mean_tidy = df_mean_tidy[c(-2)]
names(df_mean_tidy)[1]='activity'

## Save tidy dataset as csv format with .txt extension for uploading
outfile=paste(rootdir,"tidy_data.txt",sep="")
write.csv(df_mean_tidy, outfile)

## The following save the dataset as rda format
outfile1=paste(rootdir,"tidy.Rda",sep="")
save(df_mean_tidy, file=outfile1)

