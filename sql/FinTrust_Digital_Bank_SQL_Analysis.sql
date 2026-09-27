	
-- Business Question 1
-- Which customer segment has the highest number of customers?
	
SELECT  TOP 1 
Customer_Segment, COUNT(Customer_Segment) AS Customer_Segment_count
FROM dbo.FinTrust_Customers_Cleaned_Data
GROUP BY Customer_Segment
ORDER BY Customer_Segment_count DESC;
	

-- Result:
-- Everyday customers: 711

-- Business Interpretation:
-- The Everyday customer segment has the largest customer population,
-- with 711 customers. This indicates that Everyday customers make up
-- the largest segment within the customer dataset.


-- Business Question 2
-- How does customer tenure relate to transaction activity?


WITH Tenure_Groups AS ( SELECT fc.Tenure_Months, CASE
    WHEN Tenure_Months BETWEEN 0 AND 24 THEN '0-24 months'
    WHEN Tenure_Months BETWEEN 25 AND 48 THEN '25-48 months'
    WHEN Tenure_Months BETWEEN 49 AND 72 THEN '49-72 months'
    ELSE '73-96 months'
END AS Tenure_Group, ft.Transaction_ID

	FROM dbo.FinTrust_Transactions_Cleaned_Data as ft
	JOIN dbo.FinTrust_Customers_Cleaned_Data as fc
	On ft.Customer_ID = fc.Customer_ID )
	 

	SELECT Tenure_Group, Count(Transaction_ID) as Transaction_Count
	FROM Tenure_Groups
	GROUP BY Tenure_Group
	ORDER BY Transaction_count DESC;

 -- Result:
-- 73-96 months: 3,240 transactions
-- 49-72 months: 3,063 transactions
-- 0-24 months: 2,854 transactions
-- 25-48 months: 2,843 transactions

-- Business Interpretation:
-- The 73-96 month tenure group recorded the highest transaction activity,
-- with 3,240 transactions, while the 25-48 month group recorded the lowest
-- with 2,843 transactions. The differences in transaction volume between
-- the tenure groups were relatively moderate, so the results do not show  
-- a strong relationship between tenure and transaction activity.

-- Business Question 3
-- What is the overall transaction volume and distribution by transaction status?

SELECT 
    Transaction_Status,
    COUNT(Transaction_ID) AS Transaction_Count
FROM dbo.FinTrust_Transactions_Cleaned_Data
GROUP BY Transaction_Status;

-- Result:
-- Successful: 10,856 transactions
-- Failed: 630 transactions
-- Reversed: 326 transactions
-- Pending: 188 transactions

-- Business Interpretation:
-- Successful transactions accounted for the majority of transaction activity,
-- with 10,856 transactions. There were 630 failed transactions, 326 reversed
-- transactions, and 188 pending transactions. The failed transactions represent
-- an important area for further analysis to identify patterns associated with
-- transaction failure.

-- Business Question 4
-- -- Which transaction channel had the highest transaction volume?

SELECT TOP 1
    Channel,
    COUNT(Transaction_ID) AS Transaction_Count
FROM dbo.FinTrust_Transactions_Cleaned_Data
GROUP BY Channel
ORDER BY Transaction_Count DESC;

-- Result:
-- Mobile App: 5,102 transactions

-- Business Interpretation:
-- The Mobile App was the most frequently used transaction channel,
-- accounting for 5,102 transactions in the analysed dataset.

-- Business Question 5
-- How does transaction value differ across transaction statuses?

SELECT 
    Transaction_Status,
    SUM(Amount_NGN) AS Total_Amount
FROM dbo.FinTrust_Transactions_Cleaned_Data
GROUP BY Transaction_Status
ORDER BY Total_Amount DESC;

-- Result:
-- Successful: ₦510,807,441.97
-- Failed: ₦24,825,751.11
-- Reversed: ₦15,626,118.27
-- Pending: ₦9,218,044.00

-- Business Interpretation:
-- Successful transactions accounted for the largest total transaction value,
-- at approximately ₦510.81 million. Failed transactions represented
-- approximately ₦24.83 million in transaction value, followed by reversed
-- transactions at approximately ₦15.63 million and pending transactions
-- at approximately ₦9.22 million.

-- Business Question 6
-- Which customer segments have the highest average transaction value?

SELECT
    fc.Customer_Segment,
    AVG(ft.Amount_NGN) AS Average_Transaction_Value
FROM dbo.FinTrust_Transactions_Cleaned_Data AS ft
JOIN dbo.FinTrust_Customers_Cleaned_Data AS fc
    ON ft.Customer_ID = fc.Customer_ID
GROUP BY fc.Customer_Segment
ORDER BY Average_Transaction_Value DESC;

-- Result:
-- SME: ₦49,115.69 average transaction value
-- Student: ₦46,953.20 average transaction value
-- Everyday: ₦46,325.11 average transaction value
-- Premium: ₦45,637.95 average transaction value

-- Business Interpretation:
-- SME customers recorded the highest average transaction value at approximately
-- ₦49,115.69, while Premium customers recorded the lowest at approximately
-- ₦45,637.95. The difference between the highest and lowest segment averages
-- was relatively modest.


-- Business Question 7
-- Which transaction types have the highest transaction volumes and failure rates?

WITH transaction_activity AS 
(
    SELECT 
        Transaction_Type, 
        COUNT(Transaction_ID) AS Transaction_Count, 
        SUM(
            CASE 
                WHEN Transaction_Status = 'Failed' THEN 1 
                ELSE NULL 
            END
        ) AS Failed_Transaction 
    FROM dbo.FinTrust_Transactions_Cleaned_Data 
    GROUP BY Transaction_Type
)

SELECT 
    Transaction_Type, 
    Transaction_Count, 
    (Failed_Transaction * 1.0 / Transaction_Count * 100) AS Failure_Rates 
FROM transaction_activity
ORDER BY Failure_Rates DESC;


-- Result:
-- Bill Payment: 1,475 transactions, 5.83% failure rate
-- Airtime/Data: 1,185 transactions, 5.32% failure rate
-- Transfer: 3,549 transactions, 5.27% failure rate
-- Card Purchase: 3,033 transactions, 5.24% failure rate
-- Cash Withdrawal: 1,430 transactions, 5.10% failure rate
-- Deposit: 1,328 transactions, 4.67% failure rate

-- Business Interpretation:
-- Transfer transactions had the highest transaction volume, with 3,549 transactions.
-- However, Bill Payment had the highest failure rate at 5.83%.
-- This shows that the transaction type with the highest volume does not necessarily
-- have the highest failure rate. Failure rate provides a fairer comparison of
-- transaction reliability across transaction types with different transaction volumes.

-- Business Question 8
-- Which transaction channels have the highest failure rates?

WITH transaction_activity AS 
(
    SELECT 
        Channel, 
        COUNT(Transaction_ID) AS Transaction_Count, 
        SUM(
            CASE 
                WHEN Transaction_Status = 'Failed' THEN 1 
                ELSE NULL 
            END
        ) AS Failed_Transaction 
    FROM dbo.FinTrust_Transactions_Cleaned_Data 
    GROUP BY Channel
)

SELECT 
    Channel, 
    Transaction_Count, 
    (Failed_Transaction * 1.0 / Transaction_Count * 100) AS Failure_Rates 
FROM transaction_activity
ORDER BY Failure_Rates DESC;


-- Result:
-- Mobile App: 5,102 transactions, 5.80% failure rate
-- USSD: 889 transactions, 5.40% failure rate
-- POS: 2,393 transactions, 5.22% failure rate
-- Web: 1,869 transactions, 4.71% failure rate
-- ATM: 1,747 transactions, 4.18% failure rate

-- Business Interpretation:
-- Mobile App had the highest failure rate at 5.80%, while ATM had the
-- lowest failure rate at 4.18%. The results show that a channel's
-- transaction volume does not necessarily correspond to a higher failure rate.

-- Business Question 9
-- How do risk-reviewed transactions compare with non-risk-reviewed transactions in terms of failure rate?

WITH transaction_activity AS 
(
    SELECT 
        Risk_Review_Flag, 
        COUNT(Transaction_ID) AS Transaction_Count, 
        SUM(
            CASE 
                WHEN Transaction_Status = 'Failed' THEN 1 
                ELSE NULL 
            END
        ) AS Failed_Transaction 
    FROM dbo.FinTrust_Transactions_Cleaned_Data 
    GROUP BY Risk_Review_Flag
)

SELECT 
    Risk_Review_Flag, 
    Transaction_Count, 
    (Failed_Transaction * 1.0 / Transaction_Count * 100) AS Failure_Rates 
FROM transaction_activity
ORDER BY Failure_Rates DESC;


-- Result:
-- Risk-reviewed (1): 2,352 transactions, 7.23% failure rate
-- Non-risk-reviewed (0): 9,648 transactions, 4.77% failure rate

-- Business Interpretation:
-- Risk-reviewed transactions had a higher failure rate of 7.23% compared
-- with 4.77% for non-risk-reviewed transactions. This represents a
-- 2.46 percentage-point difference and is worth investigating to understand
-- whether risk-review processes, transaction characteristics, or other factors
-- are associated with the higher failure rate.


-- Business Question 10
-- Does the relationship between device type and transaction failure change
-- depending on whether a transaction was flagged for risk review?

WITH transaction_activity AS 
(
    SELECT 
        Risk_Review_Flag,
        Device_Type,
        COUNT(Transaction_ID) AS Transaction_Count, 
        SUM(
            CASE 
                WHEN Transaction_Status = 'Failed' THEN 1 
                ELSE NULL 
            END
        ) AS Failed_Transaction 
    FROM dbo.FinTrust_Transactions_Cleaned_Data 
    GROUP BY Risk_Review_Flag, Device_Type
)

SELECT 
    Risk_Review_Flag,
    Device_Type,
    Transaction_Count,
    (Failed_Transaction * 1.0 / Transaction_Count * 100) AS Failure_Rates 
FROM transaction_activity
ORDER BY Failure_Rates DESC;


-- Result:
-- Risk-reviewed:
-- Unknown: 16 transactions, 12.50% failure rate
-- iOS: 540 transactions, 9.26% failure rate
-- ATM Terminal: 253 transactions, 7.51% failure rate
-- Android: 957 transactions, 7.11% failure rate
-- POS Terminal: 295 transactions, 6.78% failure rate
-- Web Browser: 291 transactions, 3.78% failure rate
--
-- Non-risk-reviewed:
-- Unknown: 80 transactions, 5.00% failure rate
-- iOS: 2,380 transactions, 4.96% failure rate
-- Android: 3,840 transactions, 4.95% failure rate
-- Web Browser: 1,156 transactions, 4.58% failure rate
-- POS Terminal: 1,276 transactions, 4.47% failure rate
-- ATM Terminal: 916 transactions, 4.15% failure rate

-- Business Interpretation:
-- The relationship between device type and transaction failure changed
-- depending on risk review status. Risk-reviewed transactions generally
-- had higher failure rates across device types, with iOS recording a
-- 9.26% failure rate compared with 4.96% for non-risk-reviewed iOS
-- transactions. Web Browser was an exception, with a lower failure rate
-- among risk-reviewed transactions (3.78%) than non-risk-reviewed
-- transactions (4.58%). The Unknown device category had a small number
-- of risk-reviewed transactions, so its 12.50% failure rate should be
-- interpreted with caution.