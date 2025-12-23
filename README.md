# Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy

Pharmacy billing plays a critical role in the financial success of a healthcare system. Accurate billing and efficient reimbursement processes ensure sustainability while minimizing revenue leakage due to billing errors, denied claims, or underpayments. The Revenue Cycle Manager is responsible for overseeing these processes and improving key billing performance indicators.

This department uses a structured claims dataset capturing detailed information about each prescription billed, dispensed, and reimbursed.

---

The Pharmacy Manager has observed inconsistencies in reimbursement rates across similar prescriptions and an increasing number of service adjustments and billing denials. Additionally, the dispensing fee and total billed amounts often don’t correlate with the actual amounts paid, raising concerns about billing inefficiencies and potential compliance issues.

Based on the dataset provided that contains over 10 million prescription billing entries compiled from 2010 to 2018, the goal is to identify billing patterns, inefficiencies, causes of delays, and revenue loss drivers, and to develop actionable insights to improve billing practices and reimbursement outcomes.

<br>
<br>
<br>
<br>

---

### **Objectives:**

1. Analyze billing patterns to identify **frequent adjustment reasons** and **discrepancies** between billed and paid amounts.
2. Identify **high-cost drugs** and **low reimbursement rates** by NDC codes or drug names.
3. Detect **providers and medications** with unusually high adjustment frequencies.
4. Determine the **impact of the Dispensed as Written (DAW) Code** and **Basis of Cost Determination** on reimbursement outcomes.
5. Recommend strategies to **reduce claim adjustments** and improve **net revenue per prescription line**.

<br>
<br>
<br>
<br>

---

### About Dataset:

The Dataset consisted of 41 Columns  and 10.3 million rows.

The dataset is dated between 01-01-2010 and 12-31-2018.

The data structure and explanation of columns can be found [here](https://github.com/jowo21/Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy/blob/main/about_dataset.md)

The steps taken to clean this data can be found here [here](https://github.com/jowo21/Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy/blob/main/pharmacy%20billing%20cleaning%20steps.txt)

The SQL code for Exploratory Data Analysis can be found [here](https://github.com/jowo21/Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy/blob/main/PHARMACY%20BILLING%20EDA%20AND%20KPIs%202.sql)


<br>
<br>
<br>
<br>

---

## **Executive Summary**

- This analysis evaluated over **10.3 million pharmacy claims from 2010–2018** to identify drivers of reimbursement variability, billing inefficiencies, and revenue leakage. The results indicate that while overall pharmacy billing performance is stable at a macro level, **a concentrated subset of prescriptions disproportionately drives revenue loss, payment delays, and operational inefficiency**.

- Key findings show that **38% of prescriptions exhibit an unacceptable billing-to-payment gap exceeding 70%**, resulting in **$403.8M in realized revenue loss over eight years**, or approximately **$50.5M annually**. The **overall reimbursement rate of 70%** further implies **$454.0M in billed revenue that was never reimbursed**, signaling systemic underpayment rather than isolated billing errors.

- Service adjustments are a major operational friction point. Although only **0.08% of prescriptions exceed the average adjustment rate**, these claims experience **significant delays**, with prescriptions requiring **3–5 service adjustments taking an average of 42 additional days to resolve**. These delays negatively affect cash flow, increase administrative burden, and elevate compliance risk.

- Importantly, **DAW codes and dispensing fees are not material contributors to reimbursement inefficiency**, suggesting that improvement efforts should focus elsewhere. Instead, **specific NDCs, medications, and adjustment group codes, particularly “Other Adjustments (OA),represent the greatest opportunities for targeted intervention**. Seasonal patterns also emerged, with **April, August, and December** showing consistent increases in underpayment gaps and adjustment amounts, enabling proactive planning.

- Overall, this analysis demonstrates that **pharmacy revenue optimization is best achieved through focused intervention on a small subset of high-risk prescriptions rather than broad operational changes**. By combining data driven medication selection, adjustment monitoring, and predictive analytics, the Pharmacy Manager can significantly improve net revenue, reduce delays, and strengthen financial sustainability.

<br>
<br>
<br>
<br>

## **Insights Deep Dive**

### 1. Reimbursement **Efficiency and Revenue Leakage**

Medications that have large underpayments (a large gap between the billing amount and the paid amount) is an important indicator of billing inefficiencies and it is essential to track those specific items.

- We will define the medications that have a billing to payment gap **larger than 70% to be in the unacceptable range.**
    - The total count of these items were **3,892,516 or 38%** of the entire dataset.
    - Month over month, the average **underpayment gaps** have slight **increases in April, August, and December**

<img width="1514" height="472" alt="image" src="https://github.com/user-attachments/assets/50078af8-078f-4dbd-a30e-4cfd0737936f" />

- Among all of the medications that showed any positive amount billing gap, there were 900 medications that had reimbursements that were not covered by service adjustments (0.08% of the entire dataset) which amounted to a loss of $282.428.65.

 - The overall average reimbursement rate, calculated by the overall percentage of the paid amount from the billing amount, is 70%.

<br>
<br>

### 2. Adjustment Frequency and Impact

- Medications with higher than average adjustment rates also have a high impact on billing delays and are also essential to track.
    - The average adjustment rate is 75%
    - 7913 items were above the average adjustment rate (0.08% of dataset)
    - The items that had more than 2 service adjustments had significantly higher than average delays between the initial billing date and the fill date.
    - On average, the items that had 3 to 5 service adjustments were delayed by 42 days more than those that had 0 to 2 adjustments.
 
<img width="1096" height="625" alt="image" src="https://github.com/user-attachments/assets/cbebfa47-d371-47f0-9301-41479c70a957" />

<br>
<br>
<br>
<br>


## **Other Insights**

### Analysis of Dispensing Fees

- The percentage of Dispensing fees is only 0.03% of the total billing amounts meaning that it is not a strong determining factor in revenue inefficiency.

<br>
<br>

### **DAW Code and Service Adjustment Cost Determination Analysis**

- The reimbursement rates based on Dispensed as Written codes did not have much variance nor did the adjustment rates even though they were all below but within range of the average, as well as being close to average reimbursement rates, therefore having less impact on inefficiencies:

| DAW Code | Reimbursement Rate | Adjustment Rate |
| --- | --- | --- |
| 0 | 70% | 64% |
| 1 | 75% | 62% |
| 9 | 65% | 56% |
| 4 | 73% | 42% |
| 3 | 66% | 52% |
| 8 | 80% | 56% |
| 2 | 73% | 65% |
| 6 | 84% | 59% |
| 5 | 61% | 50% |
| 7 | 82% | 65% |


<br>
<br>

 - The adjustment codes that amounted to the most revenue changes are the following:

| Group Code | Count of GC | Total Amount | Average Amount |
| --- | --- | --- | --- |
| CO | 4908376 | $232,431,401.64 | $30.82 |
| OA | 1607641 | $120,015,008.04 | $53.96 |
| PI | 1201092 | $132,864,572.5 | $121.75 |
| PR | 18160 | $2,120,614.17 | $48.07 |
| MA | 397 | $72,041.01 | $170.64 |

Assuming Contractual Obligations (CO) probably can’t be avoided in the selection of medications, those that fall under Other Adjustments (OA) can possibly be tracked and have the option to be redirected to an item that is more likely to have a less costly adjustment group.

<br>
<br>

 - The Average adjustment amounts over time showed slight increases in Q3 of the year which may help to adjust or prepare for high revenue deltas during that time frame.
<img width="1832" height="1205" alt="image" src="https://github.com/user-attachments/assets/9a0a5f9e-fe31-4ee2-943e-741a3ae1fe0d" />

<br>
<br>
<br>
<br>

## **Recommendations**

### 1. Establish a High-Risk Prescription Watch list

**Objective:** 

Prevent revenue leakage before it occurs.

**Actions:**

- Create a dynamic watch list of NDCs and medications that target the following criteria:
<img width="2405" height="356" alt="image" src="https://github.com/user-attachments/assets/240c5a93-8c77-43fb-a1b5-d62e22243081" />

This can be achieved by utilizing the following dashboard which will allow the user to search medications by NDC or Drug name and quickly identify those that fall under the less performing criteria:

<img width="2055" height="878" alt="image" src="https://github.com/user-attachments/assets/e8520173-0c77-49c3-b65d-464eac5d7c0c" />

**Expected Impact:** 

Immediate reduction in under performing prescriptions and improved net revenue per claim.

### 2. Optimize Medication Selection Through Reimbursement Performance

**Objective:** 

Shift volume toward financially efficient medications.

**Actions:**

- Utilize the dashboard to **compare alternative NDCs within the same medication class**.
- Favor options with:
    - Lower bill-to-pay gaps
    - Fewer service adjustments
    - Faster reimbursement turnaround
- Embed reimbursement efficiency as a **formal criterion** alongside clinical equivalence and acquisition cost.

**Expected Impact:** 

Sustainable revenue improvement without increasing patient or provider burden.

### 3. Target Other Adjustments (OA) for Process Improvement

**Objective:** 

Reduce avoidable and variable adjustment costs.

**Actions:**

- Conduct root-cause analysis on top OA-adjusted medications:
    - Missing documentation
    - Coding inconsistencies
    - Payer-specific requirements
- Where possible, **redirect prescribing to equivalent medications** with lower OA exposure.
- Develop payer-specific billing rules to reduce repeat OA adjustments.

**Expected Impact:** 

Reduction in volatile revenue losses not driven by contractual obligations.

### 4. Implement Seasonal Forecasting and Resource Planning

**Objective:** 

Anticipate predictable revenue and adjustment spikes.

**Actions:**

- Use historical trends to prepare for **Q2 and Q3 increases in underpayment and adjustment amounts**.
- Adjust staffing, follow-up cadence, and payer outreach during peak risk months.
- Incorporate seasonal adjustment expectations into financial forecasting.

**Expected Impact:** 

Improved cash-flow predictability and operational readiness.










