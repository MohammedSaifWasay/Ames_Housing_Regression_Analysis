# 🏡 Ames Housing Data Analysis: Regression Diagnostics and Model Selection

## 📘 Introduction

This project investigates the **Ames Housing Dataset** to uncover the key factors that influence house sale prices and to develop a robust predictive model. Using **exploratory data analysis**, **regression diagnostics**, and **model selection techniques**, we aim to build an interpretable and accurate model to predict housing prices. The outcome is valuable for real estate professionals, policymakers, and potential homebuyers to make informed decisions.

---

## 📊 Objectives

- Understand distribution and relationships among variables
- Manage missing data effectively
- Examine multicollinearity and detect outliers
- Build and validate regression models
- Select the best subset of predictors for optimal performance

---

## 🔍 Analysis Walkthrough

### 🧪 1. Exploratory Data Analysis (EDA)

- Descriptive statistics calculated for **SalePrice** (mean, median, sd, min, max).
- Structure, dimensions, and missing data patterns examined.
- Missing values:
  - Numeric: Imputed with mean
  - Categorical: Imputed with mode using a custom `getmode()` function

### 🗺️ 2. Neighborhood Distribution

- Frequency table generated for the `Neighborhood` variable using `table()`.
- Provided a sense of geographical distribution across Ames, Iowa.

---

## 🔗 Correlation Analysis

- Created a **correlation matrix** of numeric variables with `corrplot()`.
- Noted relationships:
  - 🟢 **Gr.Liv.Area** → Strongest positive correlation with `SalePrice`
  - 🟠 **Garage.Area** → Moderate correlation
  - 🔴 **Lot.Area** → Weakest correlation

### 📈 Scatter Plots

- Visualized SalePrice against:
  - Gr.Liv.Area (strong linear relationship)
  - Garage.Area (moderate relationship)
  - Lot.Area (minimal relationship)

---

## 📐 Regression Modeling

### 🏗️ Initial Model

- Predictors: `Gr.Liv.Area`, `Garage.Area`, `Total.Bsmt.SF`
- Interpretation:
  - Larger **Gr.Liv.Area** significantly increases `SalePrice`
  - Other predictors showed moderate contributions

### 🧪 Diagnostics

- Checked model assumptions using:
  - Residuals vs. Fitted
  - Normal Q-Q
  - Scale-Location
  - Residuals vs. Leverage

- **Multicollinearity** tested with **Variance Inflation Factor (VIF)**: No issues found.

---

## 🚨 Outlier Detection

- **Cook’s Distance** used to flag influential data points (threshold: 4/n)
- Model retrained after removing outliers
- Improved residual behavior and performance

---

## ✅ All-Subsets Regression

- Performed using `regsubsets()` from `leaps` package
- Considered predictors: `Gr.Liv.Area`, `Garage.Area`, `Total.Bsmt.SF`, `X1st.Flr.SF`, `Lot.Area`
- **Best model** selected using **adjusted R-squared**:
  - Final predictors: `Gr.Liv.Area`, `X1st.Flr.SF`

---

## 🧾 Conclusion

This regression-based analysis of the Ames Housing dataset successfully:

- Identified **Gr.Liv.Area** and **X1st.Flr.SF** as key drivers of house prices
- Applied diagnostics to ensure assumptions were satisfied
- Used **all-subsets regression** to derive a model that balances **simplicity** and **predictive accuracy**

Future directions may involve:
- Log-transformations
- Outlier-resistant methods
- Regularized regression (e.g., LASSO, Ridge)

---

## 📚 References

1. [R Documentation – Introduction to R](https://cran.r-project.org/doc/manuals/r-release/R-intro.html#Related-software-and-documentation)
2. Albusairi, F. (2023). *Mastering Simple R Visualizations*.  
   [LinkedIn Article](https://www.linkedin.com/pulse/mastering-simple-r-visualizations-from-scatterplots-heat-albusairi/)

---

## 🧠 Author
**Mohammed Saif Wasay**  
*Data Analytics Graduate — Northeastern University*  
*Machine Learning Enthusiast | Passionate about turning data into insights*

🔗 [Connect with me on LinkedIn](https://www.linkedin.com/in/mohammed-saif-wasay-4b3b64199/)
