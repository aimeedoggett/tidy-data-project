#load library
library(data.table)
library(dplyr)

#read in feature labels used for both data sets
featurelabels<-read.table("./features.txt")

#read in activity labels used for both data sets
activitylabels<-read.table("./activity_labels.txt")

#read activity records and merge to get activity description using activity labels object
testactivity<-read.table("./test/y_test.txt",header=FALSE)
trainactivity<-read.table("./train/y_train.txt",header=FALSE)
testactivitydesc<-merge(testactivity,activitylabels, by = "V1")
trainactivitydesc<-merge(trainactivity,activitylabels, by = "V1")

#clear out first column of original numbered activities so we are left with activity name as value
testactivitydesc$V1<-NULL
trainactivitydesc$V1<-NULL

#assign Activity column header to both sets
colnames(testactivitydesc)[1]<-"Activity"
colnames(trainactivitydesc)[1]<-"Activity"

#get subject identifiers
subjecttest<-read.table("./test/subject_test.txt",header=FALSE)
subjecttrain<-read.table("./train/subject_train.txt",header=FALSE)

#read in 561 body measurements for test and training
testrecords<-read.table("./test/X_test.txt",header=FALSE)
trainrecords<-read.table("./train/X_train.txt",header=FALSE)

#assign measurement, or feature, labels as column names
colnames(testrecords)<-featurelabels[,2]
colnames(trainrecords)<-featurelabels[,2]

#find just the columns for mean and standard dev calculations
filterdcolumns<-grep("-mean|-std",featurelabels$V2)

#create new data sets with just mean std columns, 79 columns
filterdtest<-testrecords[,filterdcolumns]
filterdtrain<-trainrecords[,filterdcolumns]

#add activity and subject columns
testrecords<-data.frame(filterdtest,testactivitydesc,subjecttest)
trainrecords<-data.frame(filterdtrain,trainactivitydesc,subjecttrain)

#merge the sets together and rename subject column
mergedrecords<-merge(testrecords,trainrecords, all=TRUE)
colnames(mergedrecords)[81]<-"Subject"

#create data set with average of values by activity
activitygroup<-group_by(mergedrecords, Activity)
activitymeans<-summarize_each(activitygroup,funs(mean))

#create data set with average of values by subject
subjectgroup<-group_by(mergedrecords, Subject)
subjectmeans<-summarize_each(subjectgroup,funs(mean))

