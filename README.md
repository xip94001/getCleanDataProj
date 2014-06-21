getCleanDataProj
================
For Getting and Cleaning Data project

Instructions to run run_analysis.R

1.Get run_analysis.R from the github repo to your local

https://github.com/xip94001/getCleanDataProj/blob/master/run_analysis.R

2.Start RStudio and open run_analysis.R in RStudio


3.Make sure you have internet connection when running run_analysis.R


4.Pre-requisite:

1) Make sure R package plyr is installed. If not, please install it.

2) Make sure you have enough disk space in your RStudio working space(1GB+). 

You can run getwd() in RStudio to find the working directory. 


5.Highlight all content of run_analysis.R 

(by clicking in the run_analysis.R source window and then ctrl-A to select all), 

then click on the Run button at the top-right of the run_analysis.R source window to run the script.


6.run_analysis.R contains detailed comments on what the R scrip is doing:

Data download, load and pre-processing

1) Download the .zip file to working directory

2) Extract the .zip to subdirectory datadir under working directory

3) Read features data - the data will be used as column names after modification for X data

4) Read test and train X data and combine the data

5) Read test and train Y data and combine the data 

6) Read test and train subject data and combine the data 

Step 1.Merges the training and the test sets to create one data set.

Step 2.Extracts only the measurements on the mean and standard deviation for each measurement.
Also include activity and subject. 

Step 3.Uses descriptive activity names to name the activities in the data set

1) read activity labels

2) Uses descriptive activity names to name the activities in the data set
by joining the extracted dataset (from step 2) and activity labels dataset on "activity"

Step 4.Appropriately labels the data set with descriptive variable names

1) Remove special characters like ( ) - etc from the feature names read above

2) change to lower case

3) Change bodybody to body

Step 5.Creates a second, independent tidy data set with the average of 
Aggregate by activity and subject using FUN mean

Finally, save tidy dataset as csv format (comma separated) with .txt extension for uploading


Note:

To install R package plyr in RStudio:

1.Click on the Packages tab in the lower-right pane of RStudio.


2.Click on "Install Packages"


3.In the Packages input field, type plyr and then click on install.

