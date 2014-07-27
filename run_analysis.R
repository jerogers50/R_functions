## You should create one R script called run_analysis.R that does the following. 
## Merges the training and the test sets to create one data set.
## Extracts only the measurements on the mean and standard deviation for each measurement. 
## Uses descriptive activity names to name the activities in the data set
## Appropriately labels the data set with descriptive variable names. 
## Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

  setwd("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/")
  
## Collecting test data
  X_test<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/test/X_test.txt", header=FALSE)
  Y_test<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/test/Y_test.txt", header=FALSE)
  subject_test<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/test/subject_test.txt", header=FALSE)
  
  features<-read.table("features.txt")[,2]
  names(X_test)<-features
  extract_features<-grepl("mean|std", features)
  
  
  X_test<-X_test[,extract_features]
  
  AL<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/activity_labels.txt", header=FALSE)[,2]
  
  Y_test[,2]<-AL[Y_test[,1]]
  names(Y_test)<-c("Activity_ID", "Activity_Label")
  names(subject_test)<-"subject"
  
  test_data <- cbind(data.table(subject_test), Y_test, X_test)
  
## Collecting train data
  X_train<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/train/X_train.txt", header=FALSE)
  Y_train<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/train/Y_train.txt", header=FALSE)
  subject_train<-read.table("/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/train/subject_train.txt", header=FALSE)
  
  names(X_train)<-features
  
  X_train<-X_train[,extract_features]
  
  Y_train[,2] = AL[Y_train[,1]]
  names(Y_train) = c("Activity_ID", "Activity_Label")
  names(subject_train)<-"subject"
  
  train_data <- cbind(data.table(subject_train), Y_train, X_train)
  
## Merge the training and test tests
  data<-rbind(test_data, train_data)
  
  id_labels<-c("subject", "Activity_ID", "Activity_Label")
  data_labels<-setdiff(colnames(data), id_labels)
  melt_data<-melt(data, id = id_labels, measure.vars = data_labels)
  
  tidy_data<-dcast(melt_data, subject + Activity_Label ~ variable, mean)
  
  write.table(tidy_data, file = "/Users/jerogers50/Documents/Coursera/UCI HAR Dataset/tidy_data.txt")
  
