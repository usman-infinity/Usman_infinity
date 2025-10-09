
set.seed(123)  # For reproducibility

# Create dataset with 600 patients and 7 columns
medical_data <- data.frame(
  Patient_ID = 1:600,
  Age = sample(18:90, 600, replace = TRUE),
  Gender = sample(c("Male", "Female"), 600, replace = TRUE),
  Blood_Pressure = round(rnorm(600, mean = 120, sd = 15), 0),
  Cholesterol = round(rnorm(600, mean = 200, sd = 30), 0),
  Glucose_Level = round(rnorm(600, mean = 100, sd = 20), 0),
  Diagnosis = sample(c("Healthy", "Diabetes", "Hypertension", "Heart Disease"), 600, replace = TRUE)
)

# View first few rows
head(medical_data)

# Check number of rows and columns
dim(medical_data)

# Summary of data
summary(medical_data)

str(medical_data) 

# APPLY ALL BASIC DATA CLEANING STEPS
# Check for missing values
colSums(is.na(medical_data))
# No missing values in this simulated dataset
# Convert data types if necessary
medical_data$Patient_ID <- as.integer(medical_data$Patient_ID)
medical_data$Age <- as.integer(medical_data$Age)
medical_data$Gender <- as.factor(medical_data$Gender)
medical_data$Blood_Pressure <- as.integer(medical_data$Blood_Pressure)
medical_data$Cholesterol <- as.integer(medical_data$Cholesterol)
medical_data$Glucose_Level <- as.integer(medical_data$Glucose_Level)
medical_data$Diagnosis <- as.factor(medical_data$Diagnosis)

# REMOVE DUPLICATE ROWS IF ANY
medical_data <- medical_data[!duplicated(medical_data), ]

# VERIFY NO DUPLICATES
sum(duplicated(medical_data))

# HANDLE OUTLIERS IF ANY
# For simplicity, we'll just cap extreme values at 3 standard deviations from the mean
cap_outliers <- function(x) {
  mu <- mean(x)
  sigma <- sd(x)
  x[x < (mu - 3 * sigma)] <- mu - 3 * sigma
  x[x > (mu + 3 * sigma)] <- mu + 3 * sigma
  return(x)
} 
medical_data$Blood_Pressure <- cap_outliers(medical_data$Blood_Pressure)
medical_data$Cholesterol <- cap_outliers(medical_data$Cholesterol)
medical_data$Glucose_Level <- cap_outliers(medical_data$Glucose_Level)
# Verify outliers handled
summary(medical_data)

# The medical_data dataframe is now cleaned and ready for analysis
str(medical_data)
summary(medical_data)
head(medical_data) 

# APPLY EDA TECHNIQUES
library(ggplot2)
library(dplyr)
library(tidyr) 

# — analyzing one variable at a time (univariate analysis)
# 1. Summary statistics for numeric columns
summary(select(medical_data, Age, Blood_Pressure, Cholesterol, Glucose_Level)) 
# 2. Frequency table for categorical variables
table(medical_data$Gender)
table(medical_data$Diagnosis) 
# 3. Visualizations 
# Histogram of Age
ggplot(medical_data, aes(x = Age)) +
  geom_histogram(binwidth = 5, fill = "skyblue", color = "black") +
  labs(title = "Distribution of Patient Age", x = "Age", y = "Count") +
  theme_minimal()
# Histogram of Blood Pressure
ggplot(medical_data, aes(x = Blood_Pressure)) +
  geom_histogram(binwidth = 5, fill = "orange", color = "black") +
  labs(title = "Distribution of Blood Pressure", x = "Blood Pressure", y = "Count") +
  theme_minimal()
# Bar chart of Diagnosis
ggplot(medical_data, aes(x = Diagnosis, fill = Diagnosis)) +
  geom_bar() +
  labs(title = "Count of Patients by Diagnosis", x = "Diagnosis", y = "Count") +
  theme_minimal() 
# — analyzing relationships between two variables (bivariate analysis)
# 1. Correlation between numeric variables
cor_matrix <- cor(select(medical_data, Age, Blood_Pressure, Cholesterol, Glucose_Level))
cor_matrix
# 2. Scatter plot of Cholesterol vs Blood Pressure
ggplot(medical_data, aes(x = Cholesterol, y = Blood_Pressure, color = Diagnosis)) +
  geom_point() +
  labs(title = "Cholesterol vs Blood Pressure by Diagnosis",
       x = "Cholesterol", y = "Blood Pressure") +
  theme_minimal() 
# 3. Boxplot: Blood Pressure by Gender
ggplot(medical_data, aes(x = Gender, y = Blood_Pressure, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Blood Pressure by Gender", x = "Gender", y = "Blood Pressure") +
  theme_minimal()
# 4. Average Cholesterol by Diagnosis
medical_data %>% 
  group_by(Diagnosis) %>%
  summarise(mean_cholesterol = mean(Cholesterol, na.rm = TRUE))
# — analyzing 3 or more variables together (multivariate analysis)
# 1. Scatter plot of 3 variables (color by Diagnosis)
ggplot(medical_data, aes(x = Age, y = Blood_Pressure, color = Diagnosis, size = Cholesterol)) +
  geom_point(alpha = 0.7) +
  labs(title = "Multivariate: Age vs Blood Pressure, Colored by Diagnosis & Sized by Cholesterol") +
  theme_minimal()
# 2. Boxplot comparing Cholesterol across both Gender and Diagnosis
ggplot(medical_data, aes(x = Diagnosis, y = Cholesterol, fill = Gender)) +
  geom_boxplot() +
  labs(title = "Cholesterol by Diagnosis and Gender", x = "Diagnosis", y = "Cholesterol") +
  theme_minimal()
# 3. Correlation matrix for numeric variables 
numeric_cols <- select(medical_data, Age, Blood_Pressure, Cholesterol, Glucose_Level)
cor_matrix <- cor(numeric_cols, use = "complete.obs")
print(cor_matrix) 

# The medical_data dataframe has been cleaned and EDA techniques have been applied

