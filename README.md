# Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy

Pharmacy billing plays a critical role in the financial success of a healthcare system. Accurate billing and efficient reimbursement processes ensure sustainability while minimizing revenue leakage due to billing errors, denied claims, or underpayments. The Revenue Cycle Manager is responsible for overseeing these processes and improving key billing performance indicators.

This department uses a structured claims dataset capturing detailed information about each prescription billed, dispensed, and reimbursed.

---

### **Business Problem:**

The Revenue Cycle Manager has observed inconsistencies in reimbursement rates across similar prescriptions and an increasing number of service adjustments and billing denials. Additionally, the dispensing fee and total billed amounts often don’t correlate with the actual amounts paid, raising concerns about billing inefficiencies and potential compliance issues.

The goal is to identify billing patterns, inefficiencies, and revenue loss drivers, and to develop actionable insights to improve billing practices and reimbursement outcomes.
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

---

### About Dataset:

The Dataset consisted of 41 Columns  and 10.3 million rows.

The dataset is dated between 01-01-2010 and 12-31-2018.

The data structure and explanation of columns can be found [here](https://github.com/jowo21/Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy/blob/main/about_dataset.md)

The steps taken to clean this data can be found here [here](https://github.com/jowo21/Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy/blob/main/pharmacy%20billing%20cleaning%20steps.txt)

The SQL code for Exploratory Data Analysis can be found [here](https://github.com/jowo21/Optimizing-Pharmacy-Billing-Efficiency-and-Reimbursement-Accuracy/blob/main/PHARMACY%20BILLING%20EDA%20AND%20KPIs%202.sql)
<br>
<br>

---

### Executive Summary:

The largest determining factors of billing inefficiencies are:

- Medications that have a large gap between the billing amount and the paid amount with the paid amounts being larger than those billed is a great indicator of billing inefficiencies and it is essential to track those specific items

    Top 10 Medications with bill to payment gaps far into negative

| NDC | Billed to payment gap | Drug Name |
| --- | --- | --- |
| 38779028208 | -196069.72 | DIPHENHYDRAMINE HCL (U.S.P.) |
| 63275990808 | -158511.06 | TRAMADOL HCL POW |
| 62991278103 | -106064.92 | LOPERAMIDE HCL |
| 00074379902 | -59562.59 | HUMIRA |
| 00007464013 | -59309.7 | PROMACTA |
| 63459050830 | -56653.62 | ACTIQ |
| 69866103001 | -43272.32 | MACI         MIS |
| 59148002050 | -41889.94 | SAMSCA |
| 58468102501 | -37599.6 | CARTICEL |
| 51552142508 | -35524.1 | LIPOPEN ULTRA BASE |

<br>
<br>

- Medications with higher than average adjustment rates also have a high impact on billing inefficiency and delays and are also essential to track.

    Top 10 Items that are at or above the average adjustment rate of 74.8%

| NDC | Total Claims | Total Adjustments | Adjustment rate percent | Drug Name |
| --- | --- | --- | --- | --- |
| 68382000905 | 49 | 89 | 181.63 | LAMOTRIGINE |
| 00224185206 | 49 | 87 | 177.55 | KONSYL |
| 66336067330 | 70 | 95 | 135.71 | AMITRIPTYLINE HCL |
| 49884031901 | 45 | 58 | 128.89 | NABUMETONE |
| 00536187579 | 135 | 172 | 127.41 | REGULOID |
| 11917009407 | 86 | 109 | 126.74 | CERTAINTY FITTED BRIEFS/L |
| 66336063530 | 58 | 72 | 124.14 | CARISOPRODOL |
| 00597012168 | 45 | 49 | 108.89 | ZANTAC 150 MAXIMUM STRENG |
| 66336040830 | 58 | 62 | 106.9 | HYDROCODONE/ACETAMINOPHEN |
| 68001022804 | 54 | 55 | 101.85 | TROSPIUM CHLORIDE ER |

<br>
<br>

- Medications that have a lower reimbursement rate

    Top 10 Items that are below the average Reimbursement rate of 69.7%

| NDC | Total Claims | Reimbursement rate | Drug Name |
| --- | --- | --- | --- |
| 99070000000 | 40 | 0% | DRUGS SUPPLIED BY PHYS |
| 66336063530 | 58 | 6.9% | CARISOPRODOL |
| 66336067330 | 70 | 7.14% | AMITRIPTYLINE HCL |
| 52512069102 | 35 | 12.34% | THERAGEN HP |
| 66336040830 | 58 | 13.79% | HYDROCODONE/ACETAMINOPHEN |
| 70074058296 | 37 | 21.19% | ENSURE      LIQSTRW/CRM |
| 00121072104 | 59 | 21.49% | FLUOXETINE HCL |
| 60429076910 | 47 | 22.43% | TOPIRAMATE 25 MG |
| 68382000905 | 49 | 24.78% | LAMOTRIGINE |
| 52959000930 | 39 | 32.82% | CLONAZEPAM 0.5 MG CLONAZEPAM |

<br>
<br>
<br>
<br>

---

### Other Insights:

- The Average Billed amount vs Paid amount difference is $43.93.
- The percentage of Dispensing fees is only 0.03% meaning that it is not a strong determining factor in revenue inefficiency.
- The reimbursement rates based on Dispensed as Written codes did not have much variance nor did the adjustment rates even though they were all below but within range of the average, as well as being close to average reimbursement rates, therefore having less impact on inefficiencies:
    
    
    | DAW Code | Reimbursement Rate | Adjustment Rate |
    | --- | --- | --- |
    | 0 | 69.57% | 63.88% |
    | 1 | 74.84% | 61.90% |
    | 9 | 64.36% | 56.24% |
    | 4 | 72.56% | 42.45% |
    | 3 | 65.65% | 52.16% |
    | 8 | 80.09% | 55.73% |
    | 2 | 72.69% | 65.39% |
    | 6 | 84.03% | 59.24% |
    | 5 | 60.63% | 50.45% |
    | 7 | 82.31% | 65.07% |

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

  <br>
  <br>

Assuming Contractual Obligations (CO) probably can’t be avoided in the selection of medications, those that fall under Other Adjustments (OA) can be tracked and have the option to redirect to a less costly item.

- The Average adjustment amounts over time showed slight increases in Q3 of the year which may help to adjust or prepare for high revenue deltas during that timeframe.
<br>
  By Quarter
  <img width="1844" height="1208" alt="image" src="https://github.com/user-attachments/assets/32522af1-0f21-4876-b05f-8344e4d6521d" />
<br>
  By Month
  <img width="1832" height="1205" alt="image" src="https://github.com/user-attachments/assets/4fafed06-9bab-4313-baeb-a98225828c09" />
  
<br>
<br>
<br>
<br>

---

  ### Recommendations:

The best way to reduce inefficiencies and improve cost reduction based on this data is to track the medications that are most correlated with the following inefficiencies:

- Service Adjustment code OA
- 3 or more Service Adjustments
- Lower that average reimbursement rates (lower than 69.7%)

<br>
<br>

 The following dashboard will help with this task by allowing the user to search a filtered table for the NDC billed code, the drug name, or the amount of service adjustments:
<img width="2214" height="1205" alt="image" src="https://github.com/user-attachments/assets/65d88402-c46f-4916-9068-5edb29beb5ae" />
By identifying the medications that fit this criteria, it will help to make better decisions on which similar medications that can be dispensed with more optimal metrics.

