/* High-Value Customers with Multiple Products 
Scenario: The business wants to identify customers who have both a savings and an investment plan (cross-selling opportunity). 
Task: Write a query to find customers with at least one funded savings plan AND one 
funded investment plan, sorted by total deposits.*/
-- Q1: Identify high-value customers with both funded savings and investment plans, sorted by total deposits.

SELECT 
    cu.id                                        AS owner_id,
    COALESCE(cu.name, CONCAT(cu.first_name, ' ', cu.last_name)) AS name,
    s.savings_count,
    i.investment_count,
    ROUND(td.total_deposits / 100, 2)           AS total_deposits_naira
FROM users_customuser cu
JOIN (
    SELECT 
        p.owner_id,
        COUNT(DISTINCT p.id)                   AS savings_count
    FROM plans_plan p
    JOIN savings_savingsaccount sa ON sa.plan_id = p.id
    WHERE p.is_regular_savings = 1 AND sa.confirmed_amount > 0
    GROUP BY p.owner_id
) s ON s.owner_id = cu.id
JOIN (
    SELECT 
        p.owner_id,
        COUNT(DISTINCT p.id)                   AS investment_count
    FROM plans_plan p
    JOIN savings_savingsaccount sa ON sa.plan_id = p.id
    WHERE p.is_a_fund = 1 AND sa.confirmed_amount > 0
    GROUP BY p.owner_id
) i ON i.owner_id = cu.id
JOIN (
    SELECT 
        owner_id,
        SUM(confirmed_amount)                 AS total_deposits
    FROM savings_savingsaccount
    WHERE confirmed_amount > 0
    GROUP BY owner_id
) td ON td.owner_id = cu.id
ORDER BY total_deposits DESC;
