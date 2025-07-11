#Mohammed Saif Wasay
#NUID: 002815958
#ALY6015 Intermediate Analytics

cat("\014") # clears console
rm(list = ls()) # clears global environment
try(dev.off(dev.list()["RStudioGD"]), silent = TRUE) # clears plots
try(p_unload(p_loaded(), character.only = TRUE), silent = TRUE) #clears packages
options(scipen = 100) # disables scientific notation for entire R session

# Load necessary libraries
library(dplyr)
library(psych)
library(ggplot2)
library(corrplot)
library(car)
# Load the dataset
ames_data <- read.csv("C:/Users/Mohammed Saif Wasay/Documents/code/data/AmesHousing.csv")
data <- ames_data
print(data)

# Basic Descriptive Statistics
summary(data)
mean(data$SalePrice, na.rm = TRUE) # Example for a specific column
median(data$SalePrice, na.rm = TRUE)
sd(data$SalePrice, na.rm = TRUE)
var(data$SalePrice, na.rm = TRUE)
min(data$SalePrice, na.rm = TRUE)
max(data$SalePrice, na.rm = TRUE)

# Exploring Data Structure
str(data)
dim(data)
nrow(data)
ncol(data)
head(data)
tail(data)

# Checking for Missing Values
sum(is.na(data))
colSums(is.na(data))

# Frequency Table for a Categorical Variable
table(data$Neighborhood)

# Check for missing values
missing_values <- colSums(is.na(data))
missing_values[missing_values > 0]

# Step 2: Impute Missing Values
# Define a custom mode function
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}

# Impute missing values
for (col in names(data)) {
  if (is.numeric(data[[col]])) {
    # Impute numeric columns with the mean
    data[[col]][is.na(data[[col]])] <- mean(data[[col]], na.rm = TRUE)
  } else {
    # Impute categorical columns with the mode (using custom getmode function)
    data[[col]][is.na(data[[col]])] <- getmode(data[[col]])
  }
}

# Selecting only numeric columns for correlation analysis
numeric_data <- data %>% select(where(is.numeric))
cor_matrix <- cor(numeric_data, use = "complete.obs")

# Plotting the correlation matrix
corrplot(cor_matrix, method = "color", order = "hclust", tl.cex = 0.6, tl.col = "black")

# Find the variable with highest and lowest correlation with SalePrice
correlations <- sort(cor_matrix[,"SalePrice"], decreasing = TRUE)

# Highest correlation with SalePrice (ignoring SalePrice itself)
high_cor_var <- names(correlations[2])
low_cor_var <- names(correlations[length(correlations)])

# Variable closest to 0.5 correlation with SalePrice
moderate_cor_var <- names(which.min(abs(correlations - 0.5)))

# Scatter Plots
plot(data[[high_cor_var]], data$SalePrice, main = paste("High Correlation:", high_cor_var, "vs SalePrice"),
     xlab = high_cor_var, ylab = "SalePrice")

plot(data[[low_cor_var]], data$SalePrice, main = paste("Low Correlation:", low_cor_var, "vs SalePrice"),
     xlab = low_cor_var, ylab = "SalePrice")

plot(data[[moderate_cor_var]], data$SalePrice, main = paste("Moderate Correlation:", moderate_cor_var, "vs SalePrice"),
     xlab = moderate_cor_var, ylab = "SalePrice")
# Fit a linear regression model using at least 3 continuous variables
model <- lm(SalePrice ~ Gr.Liv.Area + Garage.Area + Total.Bsmt.SF, data = data)

# Model summary
summary(model)

# Diagnostic plots for the regression model
plot(model)
# Calculate Variance Inflation Factor (VIF) to check for multicollinearity
library(car)
vif(model)
# Interpret VIF values: VIF > 5 or 10 indicates a high level of multicollinearity
# Use Cook's Distance to identify influential outliers
cooksd <- cooks.distance(model)
influential <- which(cooksd > (4/length(cooksd)))  # Threshold for identifying influential observations

# Remove influential outliers if necessary
data_no_outliers <- data[-influential, ]
model_no_outliers <- lm(SalePrice ~ Gr.Liv.Area + Garage.Area + Total.Bsmt.SF, data = data_no_outliers)
summary(model_no_outliers)

# Load necessary library for all subsets regression
library(leaps)

# Perform all subsets regression
subsets <- regsubsets(SalePrice ~ Gr.Liv.Area + Garage.Area + Total.Bsmt.SF + X1st.Flr.SF + Lot.Area, data = data, nbest = 1)
summary(subsets)

# Identify the preferred model
# Example: SalePrice ~ GrLivArea + X1stFlrSF (if this turns out to be the best subset)
preferred_model <- lm(SalePrice ~ Gr.Liv.Area + X1st.Flr.SF, data = data)
summary(preferred_model)


