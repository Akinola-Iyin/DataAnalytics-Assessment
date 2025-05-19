/* Transaction Frequency Analysis 
Scenario: The finance team wants to analyze how often customers transact to segment them (e.g., frequent vs. occasional users). 
Task: Calculate the average number of transactions per customer per month and categorize them: 
● "High Frequency" (≥10 transactions/month) 
● "Medium Frequency" (3-9 transactions/month) 
● "Low Frequency" (≤2 transactions/month) */

-- Q2: Segment users based on average monthly transaction frequency

WITH customer_txn_summary AS (
    SELECT 
        owner_id,
        COUNT(*)                               AS total_transactions,
        MIN(transaction_date)                  AS first_txn,
        MAX(transaction_date)                  AS last_txn
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
txn_frequency AS (
    SELECT 
        cts.owner_id,
        COALESCE(cu.name, CONCAT(cu.first_name, ' ', cu.last_name)) AS customer_name,
        cts.total_transactions,
        GREATEST(TIMESTAMPDIFF(MONTH, cts.first_txn, cts.last_txn), 1) AS active_months,
        ROUND(cts.total_transactions / GREATEST(TIMESTAMPDIFF(MONTH, cts.first_txn, cts.last_txn), 1), 2) AS avg_txn_per_month
    FROM customer_txn_summary cts
    JOIN users_customuser cu ON cu.id = cts.owner_id
)
SELECT 
    CASE
        WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
        WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END                                        AS frequency_category,
    COUNT(*)                                   AS customer_count,
    ROUND(AVG(avg_txn_per_month), 2)          AS avg_transactions_per_month
FROM txn_frequency
GROUP BY frequency_category
ORDER BY FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
