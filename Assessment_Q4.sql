/* Customer Lifetime Value (CLV) Estimation 
Scenario: Marketing wants to estimate CLV based on account tenure and transaction volume (simplified model). 
Task: For each customer, assuming the profit_per_transaction is 0.1% of the transaction value, calculate: 
● Account tenure (months since signup) 
● Total transactions 
● Estimated CLV (Assume: CLV = (total_transactions / tenure) * 12 * avg_profit_per_transaction) 
● Order by estimated CLV from highest to lowest */

-- Q4: Estimate customer lifetime value based on tenure and total transaction volume

WITH customer_transactions AS (
    SELECT 
        owner_id,
        SUM(confirmed_amount)                 AS total_transactions_kobo
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
),
customer_tenure AS (
    SELECT 
        id                                    AS customer_id,
        COALESCE(name, CONCAT(first_name, ' ', last_name)) AS customer_name,
        GREATEST(TIMESTAMPDIFF(MONTH, date_joined, NOW()), 1) AS tenure_months
    FROM users_customuser
)
SELECT 
    ct.customer_id,
    ct.customer_name,
    ct.tenure_months,
    ROUND(tx.total_transactions_kobo, 2)      AS total_transactions_kobo,
    ROUND((tx.total_transactions_kobo / ct.tenure_months) * 12 * 0.001 / 100, 2) AS estimated_clv_naira
FROM customer_tenure ct
JOIN customer_transactions tx ON ct.customer_id = tx.owner_id
ORDER BY estimated_clv_naira DESC;
