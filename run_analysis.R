library(data.table)
library(reshape2)
#Import the data into R.
train1<-fread("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\train\\X_train.txt")
train2<-fread("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\train\\Y_train.txt")
train3<-fread("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\train\\subject_train.txt")
train<-cbind(train3,train2,train1)

test1<-fread("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\test\\X_test.txt")
test2<-fread("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\test\\Y_test.txt")
test3<-fread("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\test\\subject_test.txt")
test<-cbind(test3,test2,test1)

#Merge the datasets
df<-rbind(train,test)

#Import Column Names
colnames1 <- readLines("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\features.txt")
colnames2 <- readLines("C:\\Users\\TSM\\Downloads\\UCI HAR Dataset\\activity_labels.txt")


colnames(df)<- c("Subject","Activity",str)

#Only get columns with mean and std
cols1 <- grep("*.mean.*",str,value=TRUE)
cols2 <- grep("*.std.*",str,value=TRUE)

cols <- c("Subject","Activity",cols1,cols2)

df2 <-as.data.frame(df)
df3<-df2[cols]

df3$Subject <- as.factor(df3$Subject)
df3$Activity <- as.factor(df3$Activity)

df_melted <- melt(df3, id=c("Subject","Activity"))
df_mean <- dcast(df_melted, Subject + Activity ~ variable, mean)

write.table(df_mean, "tidy.txt",row.names=FALSE,quote=FALSE)

