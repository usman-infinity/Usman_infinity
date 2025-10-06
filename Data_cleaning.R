data <- data.frame(
  Student_ID = c(101,102,103,104,105,106,107,108,109,110),
  Name = c("Ali","Sara","Ahmed","Rida","Hassan","Fatima","Bilal","Ayesha","Ali","-"),
  Age = c(18,17,NA,19,18,17,18,17,18,20),
  Gender = c("Male","Female","Male","Female","Male","Female","male","Female","Male","Female"),
  Marks = c(85,NA,70,95,40,77,65,82,85,55),
  Grade = c("A","B","C","A+","F","B","C","A","A","D"),
  Attendance = c(90,88,75,92,NA,85,60,88,90,70),
  City = c("Lahore","Karachi","Islamabad","Lahore","Karachi","Rawalpindi","Islamabad","lahore","Lahore","Karachi")
)
# View the original data
print("Original Data:")
print(data)
# 1. Handling Missing Values
# Impute missing Age with mean age
data$Age[is.na(data$Age)] <- round(mean(data$Age, na.rm = TRUE))
# Impute missing Marks with median marks
data$Marks[is.na(data$Marks)] <- median(data$Marks, na.rm = TRUE)
# Impute missing Attendance with mean attendance
data$Attendance[is.na(data$Attendance)] <- round(mean(data$Attendance, na.rm = TRUE))
print("After Handling Missing Values:")
print(data)

# 2. handling city names
data$City <- tolower(data$City)
data$City <- tools::toTitleCase(data$City)
print("After Standardizing City Names:")
print(data)
# 3. Correcting Inconsistent Categorical Data
data$Gender <- tolower(data$Gender)
data$Gender <- tools::toTitleCase(data$Gender)
print("After Standardizing Categorical Data:")
print(data)
# 4. Removing Duplicates 
data <- data[!duplicated(data), ]
print("After Removing Duplicates:")
print(data)
# 5. Handling
# Remove rows with invalid names (e.g., "-")
data <- data[data$Name != "-", ]
print("After Removing Invalid Names:")
print(data)
# 6. Outlier Detection and Treatment
# For simplicity, we'll cap Marks at 100 and Attendance at 100
data$Marks[data$Marks > 100] <- 100
data$Attendance[data$Attendance > 100] <- 100
print("After Handling Outliers:")
print(data)
# Final Cleaned Data
print("Final Cleaned Data:")
print(data)
# compare with original data
print("Comparison with Original Data:")
print(data.frame(
  Original = c(101,102,103,104,105,106,107,108,109),
  Cleaned = data$Student_ID
))
# Summary of changes made
print("Summary of Changes Made:")
print("1. Imputed missing Age, Marks, and Attendance.")
print("2. Standardized categorical data.")
print("3. Removed duplicate records.")
print("4. Removed invalid names.")
print("5. Handled outliers in Marks and Attendance.")
# The cleaned data is now ready for analysis.

                      