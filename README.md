GCD-project
===========
run_analysis.R Read me

OVERVIEW OF THE REPOSITORY
There are three files in this repo:
- run_analysis.R
- CodeBook.md
- README.md

SHORT EXPLANATION ABOUT THE STUDY
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz were captured. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. 

For each record it is provided: 

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables
- Its activity label
- An identifier of the subject who carried out the experiment

INPUT FILES AND LOCATION
- measures data: "UCI HAR Dataset/test/X_test.txt"
- measures data: "UCI HAR Dataset/train/X_train.txt"
- activity per obs: "UCI HAR Dataset/test/y_test.txt"
- activity per obs: "UCI HAR Dataset/train/y_train.txt"
- measure names: "UCI HAR Dataset/features.txt"
- activity verbiage: "UCI HAR Dataset/activity_labels.txt"
- subject per obs: "UCI HAR Dataset/train/subject_train.txt"
- subject per obs: "UCI HAR Dataset/test/subject_test.txt"

HOW DOES run_analysis.R WORKS? 
Firstly, run_analysis downloads the data file included in the UCI webpage provided by the teacher and decompresses it (I know this was not necessary, but I enjoyed doing it). Then, the script reads them, rename columns in a comprehensive way and merges them into a single data frame based on the standard deviation and mean observations. It continues by changing labels names so that names of columns can be easily understood. The resulting data is then aggregated per subject and activity to create a proper data set. Next, the second column is renamed according to the activity types. Finally, tidy data is created at the working directory with the name “Human activity recognition using smartphones data.txt”.

REASONS WHY THE RESULTING TXT FILE IS TIDY DATA
- Each variable measure is in one column
- Each different observation of that variable is in a different row
- There is one table for each kind of variable
- The column subject_ID allows to link all the tables in the text file


Additional information can be found in the CodeBook.md file.


Job done based on the data provided by Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
