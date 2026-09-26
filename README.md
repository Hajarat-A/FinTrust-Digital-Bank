# FinTrust Digital Bank – Data Analytics Project

## Project Overview

FinTrust Digital Bank is a fictional digital banking dataset containing customer and transaction information. The purpose of this project is to investigate patterns associated with unsuccessful transactions and identify areas that may require further investigation.

The project follows a structured analytics process:

**Business Understanding → Data Understanding → Data Quality & Cleaning → Data Analysis → Insights → Recommendations**

---

# Part 1: Data Understanding and Profiling

## 1. Business Understanding

### Main Business Question

**Why are there a high number of failed transactions at FinTrust Digital Bank?**

This question guides the analysis throughout the project.

Other areas of business interest include:

* How customers use FinTrust's transaction channels
* Which transaction types are most common
* How transaction activity varies across customer groups
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

The transaction amount was reviewed using summary statistics. The mean transaction amount was higher than the median, indicating that the distribution is right-skewed and that some higher-value transactions may require further investigation.

---

# 3. Data Quality and Cleaning

The datasets were further reviewed and cleaned before the main analysis.

### Data Quality Checks

The following checks were performed:

* Number of records and columns
* Missing values
* Duplicate records
* Unique Customer_ID and Transaction_ID values
* Data types
* Category consistency
* Customer–Transaction relationship
* Potential statistical outliers
* Date/time validity

### Data Type Validation

All columns were checked in Power Query to confirm that they had an appropriate data type for their intended use.

The following data type corrections were identified:

* `Age` – changed to Whole Number
* `Tenure_Months` – changed to Whole Number
* `Digital_Engagement_Score` – changed to Decimal Number
* `Amount_NGN` – changed to an appropriate numerical format
* `Transaction_DateTime` – changed/validated as Date/Time

The remaining columns were reviewed and confirmed to have appropriate data types for their intended use.

### Missing Values

The 96 missing `Device_Type` values and 96 missing `Location` values were replaced with `Unknown` rather than removing the affected transaction records.

### Duplicates and Relationships

No duplicate customer or transaction records were identified.

All transaction `Customer_ID` values matched an existing customer record, allowing the datasets to be reliably joined.

### Outlier Review

Potential outliers were assessed using the 1.5 × IQR method.

Four potential outliers were identified in `Digital_Engagement_Score`, but all were within the valid range and were retained.

No statistical outliers were identified for Age or Tenure_Months.

1,474 potential outliers were identified for `Amount_NGN`. These values were reviewed and appeared to represent plausible transaction amounts, so they were retained.

---

# Part 2: Data Analysis

## 4. SQL Business Analysis

SQL was used to investigate customer behaviour, transaction activity, transaction values, transaction types, channels, transaction status and risk-review patterns.

The analysis included:

### Customer Segment

The **Everyday** segment had the largest customer population, with **711 customers**.

### Tenure and Transaction Activity

The 73–96 month tenure group recorded the highest transaction volume with **3,240 transactions**, while the 25–48 month group recorded **2,843 transactions**.

The differences between the groups were relatively moderate and did not show a strong relationship between tenure and transaction activity.

### Transaction Status

Successful transactions accounted for the majority of transaction activity:

* Successful: 10,856
* Failed: 630
* Reversed: 326
* Pending: 188

### Transaction Channel

The **Mobile App** recorded the highest transaction volume, with **5,102 transactions**.

### Transaction Value

Successful transactions accounted for the largest total transaction value at approximately **₦510.81 million**.

Failed transactions accounted for approximately **₦24.83 million**.

### Transaction Type

**Bill Payment** had the highest failure rate at **5.83%**.

Transfer transactions had the highest transaction volume, with **3,549 transactions**.

This showed that the transaction type with the highest volume did not necessarily have the highest failure rate.

### Transaction Channel Failure Rate

The highest failure rate was recorded for the **Mobile App at 5.80%**, while ATM had the lowest at **4.18%**.

### Risk Review

Risk-reviewed transactions had a failure rate of **7.23%**, compared with **4.77%** for transactions that were not risk-reviewed.

This represents a **2.46 percentage-point difference**.

The result shows an association between risk-review status and transaction failure, but does not establish that risk review itself causes transaction failures.

### Device Type and Risk Review

The relationship between device type and transaction failure varied depending on risk-review status.

For example, risk-reviewed iOS transactions had a **9.26% failure rate**, compared with **4.96%** for non-risk-reviewed iOS transactions.

Web Browser was an exception, with a lower failure rate among risk-reviewed transactions.

The Unknown device category had a small number of risk-reviewed transactions and was therefore interpreted cautiously.

---

# 5. Power BI Analysis

Power BI was used to present the main findings from the analysis through an interactive dashboard.

The dashboard includes:

* Customer profile
* Transaction profile
* Transaction status
* Failure rate by risk review
* Failure rate by device type
* Failure rate by time of day
* Failure rate by international transaction
* Device type and risk-review comparison

The dashboard was designed to move from the overall transaction picture into the patterns associated with failed transactions.

---

# 6. Key Findings

The analysis identified several patterns requiring further investigation:

1. Risk-reviewed transactions had a higher observed failure rate than non-risk-reviewed transactions.
2. iOS transactions showed a higher failure rate, particularly among risk-reviewed transactions.
3. Failure rates varied across transaction channels, with Mobile App recording the highest observed channel failure rate.
4. Failure rates varied by time of day, with afternoon and evening showing higher observed failure rates than morning and night.
5. Transaction type volume and failure rate did not always follow the same pattern.
6. High transaction values identified as statistical outliers were retained because they appeared plausible rather than clearly representing data-entry errors.

These findings represent observed patterns in the dataset and do not by themselves establish causation.

---

# 7. Recommendations

Based on the observed patterns, the following areas could be investigated further:

### 1. Review Risk-Review Processes

Investigate why risk-reviewed transactions have a higher observed failure rate and whether particular risk rules, authentication requirements or transaction characteristics are associated with the difference.

### 2. Investigate iOS Transactions

Review iOS transactions, particularly those that are risk-reviewed, to determine whether authentication, risk rules or transaction-processing issues may be contributing to the higher observed failure rate.

### 3. Monitor Peak Transaction Periods

Monitor transaction volumes, system performance and error trends during afternoon and evening periods where higher failure rates were observed.

---

# 8. Tools

* Python
* Pandas
* SQL Server / SSMS
* Power BI
* Excel
* Power Query

---

# 9. Project Status

**Part 1 – Data Understanding:** Completed
**Data Quality & Cleaning:** Completed
**SQL Business Analysis:** Completed
**Power BI Analysis:** Completed
**Insights & Recommendations:** Completed
