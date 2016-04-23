==================================================
Aimee Doggett, Data Science course Coursera, aimee@bestnotes.com
Codebook for : run_analysis.R
==================================================================

The following three goals are accomplished and stored in:
1. Tidy data set: mergedrecords
2. Average of all values by Activity: activitymeans
3. Average of all values by Subject: subjectmeans

Script uses: data.table and dplyr libraries

Summary of main variables used:
- activitylabels - this will be used as a lookup table
- featurelabels - this will be used as a lookup table

- subjecttest - contains the subject identifiers for each record in testrecords
- subjecttrain - contains the subject identifiers for each record in trainrecords

- testactivitydesc - contains the activity description for each record in testrecords
- trainactivitydesc - contains the activity description for each record in trainrecords

- testrecords - contains feature measurements for test group, during processing add subject and activity columns 
- trainrecords - contains feature measurements for train group, during processing add subject and activity columns

- filteredtest - contains only feature measurements for test group for mean and std
- filteredtrain - contains only feature measurements for train group for mean and std

- mergedrecords - merged test and train records

- activitygroup - mergedrecords grouped by activity
- activitymeans - mean values by activitygroup

- subjectgroup - mergedrecords grouped by subject
- subjectmeans - mean values by subjectgroup

Using activitylabels object, replace the activity values (1-5) with the activity description in testactivitydesc and trainactivitydesc
Using featurelabels object and colnames function, rename column headers in testrecords and trainrecords datasets 
Using grep, find only column names that contain 'mean' and 'std' and create filteredtest and filteredtrain dataset from testrecords and trainrecords

update the testrecords and trainrecords dataset using data.frame to include activity and subject data values

Merge the testrecords and trainrecords datasets to created mergedrecords - 10299 obs. of 81 variables

Use group_by and summarize_each get the mean of each value by activitygroup and store in activitymeans
Use group_by and summarize_each get the mean of each value by subjectgroup and store in subjectmeans

