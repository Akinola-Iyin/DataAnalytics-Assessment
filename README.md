# DataAnalytics-Assessment

This repository contains my solutions to the Cowrywise Data Analyst SQL Assessment.

---

## 🔍 Overview

Each question was solved using a single SQL query and the logic for each is explained below:

### ✅ Assessment_Q1.sql
**Task:** Identify customers with both funded savings and investment plans  
**Tables Used:** `users_customuser`, `savings_savingsaccount`, `plans_plan`  
**Approach:**   
- I filtered the plans_plan table for:
is_regular_savings = 1 (for savings plans)
is_a_fund = 1 (for investment plans)

- I then filtered the savings_savingsaccount table where confirmed_amount > 0 and did a join with the results above to ensured the plans are funded.

- Afterwards, I took a count of distinct savings and investment plans per customer using GROUP BY owner_id.

- I summed all deposit values per customer from savings_savingsaccount.

- I combined all three subqueries using JOIN on owner_id.

- Lastly, I used the COALESCE function to fallback to first_name + last_name for instances where the name was NULL.

---

### ✅ Assessment_Q2.sql
**Task:** Transaction frequency categorization per customer  
**Tables Used:** `users_customuser`, `savings_savingsaccount`  
**Approach:**  
- First, I counted the deposit transactions (confirmed_amount > 0) per user.

- Calculated the number of months between the user’s first and last transaction using TIMESTAMPDIFF.

- I then used GREATEST(..., 1) to ensure minimum tenure of 1 month (and to avoid division by zero).

- I Calculated average transactions per month for each user.

- I then classified them according to the requirements using a CASE statement:

High Frequency (≥10/month)

Medium Frequency (3–9/month)

Low Frequency (≤2/month)

- I grouped results by category and aggregated the total users and average frequency.

---

### ✅ Assessment_Q3.sql
**Task:** Identify inactive savings/investment accounts in the last 365 days  
**Tables Used:** `plans_plan`, `savings_savingsaccount`  
**Approach:**  
- I filtered the plans_plan table for active accounts (i.e is_deleted = 0 and is_archived = 0). I assumed these to be the criteria for active accounts, since it wasn't stated otherwise.

- I then joined the result with a subquery that returned the last transaction date per plan_id from the savings_savingsaccount table.

- I could now calculate the inactivity days using DATEDIFF(NOW(), last_transaction_date)

- Afterwards, I selected only accounts with no deposits in the last 365+ days

- Lastly, categorized each plan as 'Savings', 'Investment', or 'Other' based on plan type flags

---

### ✅ Assessment_Q4.sql
**Task:** Estimate Customer Lifetime Value (CLV)  
**Tables Used:** `users_customuser`, `savings_savingsaccount`  
**Approach:**  
- I retrieved the date_joined from users_customuser and calculated the tenure in months using TIMESTAMPDIFF.

- I applied the GREATEST function here again to ensure the tenures were at least 1 month.

- Summed all deposit transactions (confirmed_amount) per user to get the total transaction volume.

- I applied the given CLV formula:

-  Also, I converted final CLV value from kobo to naira, dividing by 100.

- I then used the ORDER BY to arrange the estimated CLV in descending order.

---

## 💡 Challenges Faced
- Some user records had a NULL in the name field, so I had to apply the fallback logic using first_name and last_name to ensure consistent naming.
  
- Both savings and investment plans were stored in the same palns_plan table. This brought about some complexity when I tried to segment funded accounts, especially when both flags were 0 or both were 1.
   
- Some plans had limited or no deposit activity, so identifying the true last activity date meant joining across tables and ensuring no false positives (plans with deposits recorded as 0 or NULL.
  
- For users with only one transaction, using TIMESTAMPDIFF resulted in 0 months, which could cause division-by-zero errors so I had to use the GREATEST function
  to enforce the minimum monthly interval.

- Also, had to keep in mind that all values were in Kobo and needed a division factor of 100 to convert to Naira for clearer reporting.
  
- I had to use CTEs to maintain readability and performance when I had to carry out large joins across multiple tables.
