run_analysis <- function() {
        ## Where dataset = data directory
        ## Load "plyr" package
        library(plyr)
        
        ## Read and combine data from test and train data sets and assign proper
        ## column names
        activity_labels <- 
                read.table(
                        "activity_labels.txt",
                        col.names = c("code", "activity")
                )
        features <- read.table("features.txt", colClasses = "character")
        features <- features[, 2]
        data <- read.table("test/X_test.txt", col.names = features)
        data <-
                rbind(
                        data,
                        read.table("train/X_train.txt", col.names = features)
                )
        
        ## Generate list of columns to keep, i.e., only those calculating mean
        ## and standard deviation
        keep <- numeric()
        for(i in seq_along(features)) {
                if(length(grep("Freq", features[i])) != 0) {
                        next
                }
                else if(length(grep("angle", features[1])) != 0) {
                        next
                }
                else if(length(grep("mean()", features[i])) != 0) {
                        keep <- c(keep, i)
                        next
                }
                else if(length(grep("std()", features[i])) != 0) {
                        keep <- c(keep, i)
                        next
                }
                else
                        next
        }

        ## Use generated list to keep only wanted columns
        data <- data[, keep]

        ## Add subjects and activities from test and train data sets to data
        subject <- rbind(
                        read.table(
                                "test/subject_test.txt",
                                col.names = "subject"
                        ),
                        read.table(
                                "train/subject_train.txt",
                                col.names = "subject"
                        )
                   )
        activity <- rbind(
                        read.table(
                                "test/y_test.txt",
                                col.names = "activity",
                                colClasses = "numeric"
                        ),
                        read.table(
                                "train/y_train.txt",
                                col.names = "activity",
                                colClasses = "numeric"
                                )
                        )
        data <- cbind(subject, activity, data)
        
        ## Add descriptive activity and variable names
        data$activity <- as.factor(data$activity)
        data$activity <-
                mapvalues(
                        data$activity,
                        from = 1:6,
                        to = c(
                                "WALKING",
                                "WALKING_UPSTAIRS",
                                "WALKING_DONWSTAIRS",
                                "SITTING",
                                "STANDING",
                                "LAYING"
                        )
                )
        colnames(data)[3:42] <-
                sub("t", "Time", colnames(data)[3:42])
        colnames(data) <-
                sub("AccJerk", "LinearAccleration", colnames(data))
        colnames(data) <-
                sub("GyroJerk", "AngularVelocity", colnames(data))
        colnames(data) <-
                sub("yAcc", "yAccelerometerSignal", colnames(data))
        colnames(data) <-
                sub("Gyro", "AngularVelocity", colnames(data))
        colnames(data) <-
                sub("Mag", "Magnitiude", colnames(data))
        colnames(data) <-
                sub("f", "Frequency", colnames(data))
        
        ## Create new data set with average of each variable per activity and
        ## subject
        summary <- 
                aggregate(
                        data[, 3:68],
                        by = list(
                                subject = data$subject,
                                activity = data$activity
                        ),
                        FUN = mean
                )
        write.table(summary, file = "DataSummary.txt", row.names = FALSE)
}