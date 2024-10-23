# Loading and cleaning data

## File load

We need to load two sets of three files.  Each set corresponds to the test and train data and the files are the X, Y variables, as well as the subject who is performing the actions.
In addition to that, we need a file that contains the features so, in the first section we assemble the file paths for each of these files to load them into a dataframe using the read.table commands

## File join

Given that the X and Y files are all similar, meaning the train and test set, we paste them together using the rbind() function.  We do the same for each of the subject files, binding them together.
Once those are bound one after the other, we now need to join them side by side using the cbind() function, so now X, Y and subject are all togeher into a single data frame.
It is important at this point to maintain the order of files for test and train data sets.

## Column titles

In the middle of the previous step we assign the column names based on an auxiliary file containing the feature names, we load the data frame and use the column containing the relevant name.
The assignment is done with colnames() function.

## Relevant features.

Since we care about mean and std, we use grep() to filter for those features containing either of those keywords, and use the resulting list to filter on the needed columns.

## Final summarization.

Now we have the subject and activity(target or Y), which we use to group_by() and with that group, apply the mean to the relevant features we had identified previously.  This outputs a dataset containing the average for every feature, split by activity and subject.

## Writing to a directory

We write to file as CSV and TXT for users to consume.

## This is a new change

Some more info
