##Project file: Getting & Cleaning Data Course 
## Marcos Alexandre Lodis

##Assuming that data are dwonload in working directory
setwd("C:/Users/Marcos/Desktop/getting data")

# variable name are same as filename
##Use head() to view the data
x_train<-read.table("X_train.txt")
head(x_train)
x_test<-read.table("X_test.txt")
head(x_test)
y_train<-read.table("y_train.txt")
head(y_train)
y_test<-read.table("y_test.txt")
head(y_test)
Subject_train<-read.table("subject_train.txt")
head(Subject_train)
Subject_test<-read.table("subject_test.txt")
head(Subject_test)
activity_labels<-read.table("activity_labels.txt")
head(activity_labels)
features<-read.table("features.txt")
##head(features)

##Start cleaning data
##lowercase
features$V2<-tolower(features$V2)
head(features)
##removing punctuation
features$V2 <- gsub("[[:punct:]]","", features$V2, ignore.case = FALSE, perl = FALSE) 
##features
##removing "-"
features$V2 <- gsub("-","",features$V2)
##removing "(")
features$V2<-gsub("\\(","",features$V2)
##removing ")")
features$V2<-gsub("\\)","",features$V2) 


##Nameing missing labels of data & update cleaning data
colnames(x_train) <- colNames
colnames(Subject_train) <- "subject"
colnames(y_train) <- "activity"
colnames(x_test) <- colNames
colnames(Subject_test) <- "subject"
colnames(y_test) <- "activity"



##Merges the training and the test sets to create one data set.

test_All <- cbind(Subject_test, y_test,x_test)
train_All <- cbind(Subject_train,y_train,x_train)
all <- rbind(train_All,test_All)


##Extract only measurements on the mean & standard deviation and create dataset only with measurements  
measure <- all[, grep("mean|std|subject|activity", names(all))]
##head(measure)
##names(measure)

##Uses descriptive activity names to name the activities in the data set.
labels <- c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")
measure$activity <- labels[measure$activity]

## Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
require(reshape2)
tidy0 = melt(measure, id.var = c("subject", "activity"))
tidy = dcast(tidy0 , subject + activity ~ variable,mean)
##head(tidy)

# Write tidy data
write.table(tidy, file = "Finalydata.txt")




