
# FinTrust Digital Bank – Data Analytics Project

## Part 1: Data Understanding and Profiling

### Project Overview

FinTrust Digital Bank is a fictional digital banking dataset containing customer and transaction information. The purpose of this project is to understand customer and transaction data and investigate patterns that may help explain unsuccessful transactions.

The project follows a structured analytics process:

**Business Understanding → Data Understanding → Data Analysis → Insights → Recommendations**

---

## 1. Business Understanding

### Main Business Question

**Why are there a high number of failed transactions at FinTrust Digital Bank?**

This question will guide the analysis throughout the project.

Other areas of business interest include:

* How customers use FinTrust's transaction channels
* Which transaction types are most common
* How transaction activity varies across customer groups and locations
* Whether there are transaction patterns that require further investigation

### Decisions Data Analysis Could Support

The analysis could help FinTrust identify patterns associated with failed transactions and determine where further investigation may be required. The findings could support decisions around transaction processes, customer experience, monitoring, and operational improvements.

### Key Stakeholders

The analysis could be useful to:

* Operations teams
* Risk and compliance teams
* Digital banking/product teams
* Customer service teams
* Management

---

# 2. Data Understanding

Two datasets were provided:

* **Customer Dataset** – 1,500 customer records and 12 columns
* **Transaction Dataset** – 12,000 transaction records and 11 columns

The datasets contain customer information and transaction activity, with `Customer_ID` providing the link between the two datasets.

## Customer Dataset

The customer dataset contains information such as:

* Customer ID and name
* Age and gender
* City
* Customer segment
* Account type
* Tenure
* Digital engagement
* Monthly income band
* Preferred channel
* Account status

### Numerical Variables

* `Age`
* `Tenure_Months`
* `Digital_Engagement_Score`

### Categorical Variables

* `Gender`
* `City`
* `Customer_Segment`
* `Account_Type`
* `Monthly_Income_Band`
* `Preferred_Channel`
* `Account_Status`

`Customer_ID` and `Customer_Name` were treated as identifier/descriptive fields rather than analytical variables.

The dataset contained no missing values or duplicate customer records.

The categorical columns were reviewed using unique values to understand the categories present and check for obvious inconsistencies.

The numerical variables were reviewed using summary statistics to understand their ranges and distributions.

---

## Transaction Dataset

The transaction dataset contains information about individual transactions, including:

* Transaction ID
* Customer ID
* Transaction date and time
* Transaction type
* Transaction amount
* Channel
* Device type
* Location
* International transaction indicator
* Transaction status
* Risk review flag

### Numerical Variable

* `Amount_NGN`

### Date/Time Variable

* `Transaction_DateTime`

### Categorical Variables

* `Transaction_Type`
* `Channel`
* `Device_Type`
* `Location`
* `International_Transaction`
* `Transaction_Status`
* `Risk_Review_Flag`

`Transaction_ID` and `Customer_ID` were treated as identifiers.

The transaction date/time column was converted to a datetime format using `pd.to_datetime()`.

The dataset contained 96 missing values in `Device_Type` and 96 missing values in `Location`. These represent 0.8% of the transaction records for each column.

No duplicate transaction IDs were identified.

The categorical columns were reviewed using unique values to understand the categories present and identify any obvious inconsistencies.

The transaction amount was reviewed using summary statistics. The mean transaction amount was higher than the median, indicating that the distribution is right-skewed and that some higher-value transactions may require further investigation during the analysis stage.

---

# 3. Initial Data Quality Checks

The following checks were performed during the data-understanding stage:

* Dataset structure and data types using `info()`
* Missing values using `isnull().sum()`
* Duplicate records and duplicate IDs
* Unique values in categorical variables
* Numerical summary statistics using `describe()`
* Date/time conversion and validation

No extensive cleaning or transformation was performed at this stage because the purpose was to first understand the datasets before beginning the main analysis.

---

# 4. Analytical Questions

The main analysis will investigate the failed transaction problem through the following questions:

1. How large is the failed transaction problem?
2. Which age groups are more affected by failed transactions?
3. Are male or female customers more affected by failed transactions, considering the size of each customer group?
4. Which transaction types have the highest failed transaction rates?
5. Which channels have the highest failed transaction rates?
6. Which locations and devices have the highest failed transaction rates?
7. At what time of day are failed transactions most common?
8. Are risk-reviewed transactions more likely to be unsuccessful than transactions that are not flagged for review?

---

# 5. Planned Analysis

The analysis will begin by measuring the size of the failed transaction problem and then breaking it down by relevant customer and transaction characteristics.

Where interesting patterns are identified, further drill-down analysis will be performed to investigate whether other variables are associated with those patterns.

The analysis will distinguish between **observed associations and confirmed causes**, since the available data may show relationships without proving why a transaction failed.

---

## Tools

* Python
* Pandas
* SQL
* Power BI
* Excel

## Project Status

**Part 1 – Data Understanding:** Completed
**Part 2 – Data Analysis:** In progress
