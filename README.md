# DataAnalytics-Assessment

This repository contains my solutions to the Cowrywise Data Analyst SQL Assessment.

---

## 🔍 Overview

Each question was solved using a single SQL query and the logic for each is explained below:

### ✅ Assessment_Q1.sql
**Task:** Identify customers with both funded savings and investment plans  
**Tables Used:** `users_customuser`, `savings_savingsaccount`, `plans_plan`  
**Approach:**  
- Joined users with savings and plans
- Filtered for confirmed deposits
- Aggregated savings and investment counts per customer
- Calculated total deposits  
> 💡 *Details of logic and joins will go here after solution is finalized*

---

### ✅ Assessment_Q2.sql
**Task:** Transaction frequency categorization per customer  
**Tables Used:** `users_customuser`, `savings_savingsaccount`  
**Approach:**  
- Counted monthly transactions per user
- Calculated averages
- Applied categorization rules using CASE statement

---

### ✅ Assessment_Q3.sql
**Task:** Identify inactive savings/investment accounts in the last 365 days  
**Tables Used:** `plans_plan`, `savings_savingsaccount`  
**Approach:**  
- Retrieved last transaction date per account
- Compared with current date to calculate inactivity
- Filtered for > 365 days

---

### ✅ Assessment_Q4.sql
**Task:** Estimate Customer Lifetime Value (CLV)  
**Tables Used:** `users_customuser`, `savings_savingsaccount`  
**Approach:**  
- Calculated account tenure in months
- Summed up all transactions per customer
- Applied simplified CLV formula based on provided logic

---

## 💡 Challenges Faced
- [ ] Will be updated once I work on each query  
- [ ] Ensuring accuracy of joins between savings and investment plans  
- [ ] Optimizing grouping and subqueries for performance  

---

## ✅ Final Notes
- All data amounts are in **kobo**
- Foreign keys were used to join tables correctly
- Queries include comments and formatting for clarity

