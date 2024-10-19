library(stringr)
library(dplyr)

# Set the current directory
data_dir = './UCI HAR Dataset'

# Define actual file names to be loaded
train_X = paste(data_dir,'/train/X_train.txt',sep='')
train_Y = paste(data_dir,'/train/Y_train.txt',sep='')
train_subject = paste(data_dir,'/train/subject_train.txt',sep='')
test_X = paste(data_dir,'/test/X_test.txt',sep='')
test_Y = paste(data_dir,'/test/Y_test.txt',sep='')
test_subject = paste(data_dir,'/test/subject_test.txt',sep='')
features = paste(data_dir,'/features.txt', sep='')

# Load each of the files
train_X_df = read.table(train_X, header=FALSE)
train_Y_df = read.table(train_Y, header=FALSE)
train_subject_df = read.table(train_subject, header=FALSE)
test_X_df = read.table(test_X, header=FALSE)
test_Y_df = read.table(test_Y, header=FALSE)
test_subject_df = read.table(test_subject, header=FALSE)
features_list = read.csv(features,sep=' ', header=FALSE)

# Join the train and test datasets
X_df = rbind(train_X_df, test_X_df) 
Y_df = rbind(train_Y_df, test_Y_df)
subject_df = rbind(train_subject_df, test_subject_df)

# Name the columns based on the feature list
features_list[,'V2'] = str_replace_all(features_list[,'V2'],',','_')
colnames(X_df) <-features_list[,'V2']
colnames(Y_df) <-c('activity')
colnames(subject_df) <-c('subject')

# find the feature indexes for mean or standard deviation
relevant_features = grep('(std|mean)',features_list[,'V2'])

# Join X and Y
df = cbind(X_df, Y_df, subject_df)

# Calculate the column means
final_features = features_list[relevant_features,'V2']
new_df = df[,c(final_features,'activity','subject') ]
new_df = tbl_df(new_df)

grouped_df <- new_df %>% group_by(activity,subject) %>% reframe(across(everything(), list(mean=mean)))

write.csv(grouped_df, './final_dataset.csv')
write.table(grouped_df, './final_dataset.txt', row.name=FALSE)