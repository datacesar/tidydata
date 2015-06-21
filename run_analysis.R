##Step 1, Merge the train and test sets in a data set
###
traintestdata<-rbind(read.table(file="X_train.txt"),read.table(file="X_test.txt"))

## Step 4 add the features.txt data as colum names
###
featuresdata<-read.table(file="features.txt")
features<-as.character(featuresdata$V2)
names(traintestdata)<-features

## Step 2, Extracting the measurements on the means and standar derivations usin grep()
###
columMeasure<-c(grep('mean(',features,fixed=TRUE),grep('std(',features,fixed=TRUE))
traintestdata<-traintestdata[,columMeasure]

## Step 3, Name the activities in the data set. First I merge the y_train and y_test datas,
## then I assing the activity names from activity_labels txt and merge with the main data set
###
activityData<-rbind(read.table(file="y_train.txt"),read.table(file="y_test.txt"))
activityName<-inner_join(activityData,read.table("activity_labels.txt"),by="V1")
colnames(activityName)<-c("activity","activity_name")
traintestdata<-cbind(activityName,traintestdata)

## Step 5, Firs add the subjects to the dataset (traintestdata)
## then create the tydy data
###
subjectsdata<-rbind(read.table(file="subject_train.txt"),read.table(file="subject_test.txt"))
names(subjectsdata)<-"subject"
traintestdata<-cbind(subjectsdata,traintestdata)
tidyData<-melt(traintestdata, id=c("subject","activity_name"),measure.vars=c(4:69))
castTidyData<-dcast(tidyData,subject+activity_name~variable,mean )


