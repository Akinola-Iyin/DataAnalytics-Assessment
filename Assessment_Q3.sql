/* Account Inactivity Alert 
Scenario: The ops team wants to flag accounts with no inflow transactions for over one year. 
Task: Find all active accounts (savings or investments) with no transactions in the last 1 year (365 days) . */

-- Q3: Identify active plans with no deposit transactions in the last 365 days

WITH last_transactions AS (
    SELECT 
        plan_id,
        MAX(transaction_date)                 AS last_transaction_date
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY plan_id
)
SELECT 
    p.id                                       AS plan_id,
    p.owner_id,
    CASE 
        WHEN p.is_regular_savings = 1 THEN 'Savings'
        WHEN p.is_a_fund = 1 THEN 'Investment'
        ELSE 'Other'
    END                                        AS type,
    lt.last_transaction_date,
    DATEDIFF(NOW(), lt.last_transaction_date) AS inactivity_days
FROM plans_plan p
JOIN last_transactions lt ON lt.plan_id = p.id
WHERE p.is_deleted = 0
  AND p.is_archived = 0
  AND DATEDIFF(NOW(), lt.last_transaction_date) > 365
ORDER BY inactivity_days DESC;
