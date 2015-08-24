# Getting-and-Cleaning-Data
The course project for the Getting and Cleaning Data course

The purpose of this project is to clean and run ans analysis on a large data set.  The data used was obtained using smart phones to measure different physical activities.  The project can be found here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip [1]

The CodeBook.rmd file contains the original Code Book for the data set.  It explains how the data was collected, how variables were calcuated, and lists the labels that are present in the raw data file.  An additional section has been added to the Code Book that explains the data cleaning and analysis steps taken as well as the new labels used in the final data set.

The run_analysis.R file contains the script for repeating the data cleaning and analysis.  Place both the unzipped raw data files and the R script in your working directory to run the program.

The final file is a text file that contains the output from running run_analysis.R.  Note that the dplyr package is required to run the analysis; make sure it is installed.

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012