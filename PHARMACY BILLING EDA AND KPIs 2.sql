#Adjustment rate % of billed lines with at least one service adjustment
SELECT ROUND((SUM(Number_of_Service_Adjustments) / COUNT(*) * 100),2) AS Adjustment_rate_percent
FROM pharmacy_rx_billing
;

#Average Billed vs Paid Delta: Mean difference between Drugs/supplies billed amount vs total amount paid per line
SELECT ROUND(AVG(Drugs_Supplies_Billed_Amount) - AVG(Total_Amount_Paid_Per_line),2) AS average_billed_vs_paid_delta
FROM pharmacy_rx_billing
;


#Percentage of Dispensing Fees paid 
SELECT SUM(Drugs_Supplies_Dispensing_Fee) / SUM(Drugs_Supplies_Billed_Amount) *100 AS dispense_fee_percent
FROM pharmacy_rx_billing
;


#Reimbursement Rate
SELECT ROUND((SUM(Total_Amount_Paid_Per_line) / SUM(Drugs_Supplies_Billed_Amount) * 100),2) AS reimbursement_rate
FROM pharmacy_rx_billing
;

#Top 20 Providers determined by number of adjustments
SELECT 
Rendering_Line_Provider_National_Provider_ID AS provider_NPI, 
SUM(Number_of_Service_Adjustments) AS service_adjustments, 
ROUND(AVG(Number_of_Service_Adjustments),2) AS average_adjustments
FROM pharmacy_rx_billing
WHERE Rendering_Line_Provider_National_Provider_ID IS NOT NULL 
AND Rendering_Line_Provider_National_Provider_ID <> ''
GROUP BY Rendering_Line_Provider_National_Provider_ID
ORDER BY service_adjustments DESC
LIMIT 20
;

#Bottom 20 Providers determined by number of adjustments (not that useful since many have 0 or 1 adjustments)
SELECT Rendering_Line_Provider_National_Provider_ID AS provider_NPI, SUM(Number_of_Service_Adjustments) AS service_adjustments
FROM pharmacy_rx_billing
GROUP BY Rendering_Line_Provider_National_Provider_ID
HAVING Rendering_Line_Provider_National_Provider_ID <> "" AND service_adjustments > 0
ORDER BY 2 ASC
LIMIT 20
;

#Average Reimbursement rates and Adjustment rates by DAW  Code
SELECT DAW_Code, ROUND((SUM(Total_Amount_Paid_Per_line) / SUM(Drugs_Supplies_Billed_Amount) * 100),2) AS reimbursement_rate,
ROUND((SUM(CASE WHEN Number_of_Service_Adjustments > 0 THEN 1 ELSE 0 END) / COUNT(*) * 100),2) AS adjustment_rate
FROM pharmacy_rx_billing
GROUP BY DAW_Code
;











#Top 25 NDCs and Drugs with largest negative billing to payment gap (BY SUM)
WITH ndc AS
(
SELECT DISTINCT NDC_Billed_Code, ROUND(SUM(Total_Amount_Paid_Per_line) - SUM(Drugs_Supplies_Billed_Amount), 2) AS billed_to_payment_gap
FROM pharmacy_rx_billing
WHERE NDC_Billed_Code NOT IN (99999999999, 00000000000)
GROUP BY NDC_Billed_Code
),

drugs AS
(
SELECT DISTINCT NDC_Billed_Code, Drug_name
FROM pharmacy_rx_billing
),

joined_data AS
(
SELECT ndc.NDC_Billed_Code, ndc.billed_to_payment_gap, drugs.Drug_name
FROM ndc
JOIN drugs 
ON ndc.NDC_Billed_Code = drugs.NDC_Billed_Code
),

unique_ndcs AS 
(
SELECT NDC_Billed_Code
FROM joined_data
GROUP BY NDC_Billed_Code
HAVING COUNT(*) = 1
)

SELECT jd.*
FROM joined_data jd
JOIN unique_ndcs un 
ON jd.NDC_Billed_Code = un.NDC_Billed_Code
ORDER BY jd.billed_to_payment_gap ASC
LIMIT 25
;


#Top 25 NDCs and Drugs with largest negative billing to payment gap (BY AVG)
WITH ndc AS
(
SELECT DISTINCT NDC_Billed_Code, ROUND(AVG(Total_Amount_Paid_Per_line) - AVG(Drugs_Supplies_Billed_Amount), 2) AS billed_to_payment_gap
FROM pharmacy_rx_billing
WHERE NDC_Billed_Code NOT IN (99999999999, 00000000000)
GROUP BY NDC_Billed_Code
),

drugs AS
(
SELECT DISTINCT NDC_Billed_Code, Drug_name
FROM pharmacy_rx_billing
),

joined_data AS
(
SELECT ndc.NDC_Billed_Code, ndc.billed_to_payment_gap, drugs.Drug_name
FROM ndc
JOIN drugs 
ON ndc.NDC_Billed_Code = drugs.NDC_Billed_Code
),

unique_ndcs AS 
(
SELECT NDC_Billed_Code
FROM joined_data
GROUP BY NDC_Billed_Code
HAVING COUNT(*) = 1
)

SELECT jd.*
FROM joined_data jd
JOIN unique_ndcs un 
ON jd.NDC_Billed_Code = un.NDC_Billed_Code
ORDER BY jd.billed_to_payment_gap ASC
LIMIT 25
;

#Average Service Adjustments per service group
SELECT 
ROUND(AVG(Service_Adjustment_Amount_1),2) AS avg_service_adjustment_1,
ROUND(AVG(Service_Adjustment_Amount_2),2) AS avg_service_adjustment_2,
ROUND(AVG(Service_Adjustment_Amount_3),2) AS avg_service_adjustment_3,
ROUND(AVG(Service_Adjustment_Amount_4),2) AS avg_service_adjustment_4,
ROUND(AVG(Service_Adjustment_Amount_5),2) AS avg_service_adjustment_5
FROM pharmacy_rx_billing
;















#Number of adjustment types and revenue per code
WITH gc1 AS
(SELECT Service_Adjustment_Group_Code_1 AS group_code, 
COUNT(Service_Adjustment_Group_Code_1 )AS count_of_gc ,
ROUND(SUM(Service_Adjustment_Amount_1),2) AS sum_service_adjustment, 
ROUND(AVG(Service_Adjustment_Amount_1),2) AS avg_adjustment_amount 
FROM pharmacy_rx_billing
GROUP BY Service_Adjustment_Group_Code_1),

gc2 AS
(SELECT Service_Adjustment_Group_Code_2 AS group_code, 
COUNT(Service_Adjustment_Group_Code_2 )AS count_of_gc ,
ROUND(SUM(Service_Adjustment_Amount_2),2) AS sum_service_adjustment, 
ROUND(AVG(Service_Adjustment_Amount_2),2) AS avg_adjustment_amount  
FROM pharmacy_rx_billing 
GROUP BY Service_Adjustment_Group_Code_2),

gc3 AS
(SELECT Service_Adjustment_Group_Code_3 AS group_code, 
COUNT(Service_Adjustment_Group_Code_3 )AS count_of_gc ,
ROUND(SUM(Service_Adjustment_Amount_3),2) AS sum_service_adjustment, 
ROUND(AVG(Service_Adjustment_Amount_3),2) AS avg_adjustment_amount  
FROM pharmacy_rx_billing 
GROUP BY Service_Adjustment_Group_Code_3),

gc4 AS
(SELECT Service_Adjustment_Group_Code_4 AS group_code, 
COUNT(Service_Adjustment_Group_Code_4 )AS count_of_gc ,
ROUND(SUM(Service_Adjustment_Amount_4),2) AS sum_service_adjustment, 
ROUND(AVG(Service_Adjustment_Amount_4),2) AS avg_adjustment_amount 
FROM pharmacy_rx_billing
GROUP BY Service_Adjustment_Group_Code_4),

gc5 AS
(SELECT Service_Adjustment_Group_Code_5 AS group_code,
COUNT(Service_Adjustment_Group_Code_5 )AS count_of_gc ,
ROUND(SUM(Service_Adjustment_Amount_5),2) AS sum_service_adjustment, 
ROUND(AVG(Service_Adjustment_Amount_5),2) AS avg_adjustment_amount  
FROM pharmacy_rx_billing
GROUP BY Service_Adjustment_Group_Code_5),

gc_combo AS
(
SELECT * FROM gc1
UNION ALL
SELECT * FROM gc2
UNION ALL
SELECT * FROM gc3
UNION ALL
SELECT * FROM gc4
UNION ALL
SELECT * FROM gc5
)

SELECT group_code, SUM(count_of_gc) AS count_gc, ROUND(SUM(sum_service_adjustment),2) AS amount_of_service_adjustments, ROUND(AVG(avg_adjustment_amount),2) AS amount_of_service_adjustments
FROM gc_combo
GROUP BY group_code
HAVING group_code <> ""
ORDER BY 2 DESC
;


#Top 25 NDCs and Drugs with largest adjustment counts and above average adjustment rates
WITH ndc AS 
(
SELECT 
 NDC_Billed_Code, 
COUNT(*) AS total_claims,
SUM(Number_of_Service_Adjustments) AS total_adjustments,
ROUND((SUM(Number_of_Service_Adjustments) * 100.0 / COUNT(*)), 2) AS Adjustment_rate_percent
FROM pharmacy_rx_billing
WHERE NDC_Billed_Code NOT IN (99999999999, 00000000000)
GROUP BY NDC_Billed_Code
),

drugs AS 
(
SELECT DISTINCT NDC_Billed_Code, Drug_name
FROM pharmacy_rx_billing
),

joined_data AS 
(
SELECT ndc.NDC_Billed_Code, ndc.total_claims, ndc.total_adjustments, ndc.Adjustment_rate_percent, drugs.Drug_name
FROM ndc
JOIN drugs 
ON ndc.NDC_Billed_Code = drugs.NDC_Billed_Code
),

unique_ndcs AS 
(
SELECT NDC_Billed_Code
FROM joined_data
GROUP BY NDC_Billed_Code
HAVING COUNT(*) = 1
)

SELECT jd.*
FROM joined_data jd
JOIN unique_ndcs un 
ON jd.NDC_Billed_Code = un.NDC_Billed_Code
WHERE jd.Adjustment_rate_percent > 74.86
ORDER BY jd.total_claims DESC
LIMIT 25
;




#Top 25 NDCs and Drugs with largest total claims and below average reimbursement rates
WITH ndc AS 
(
SELECT 
 NDC_Billed_Code, 
COUNT(*) AS total_claims,
ROUND((SUM(Total_Amount_Paid_Per_line) / SUM(Drugs_Supplies_Billed_Amount) * 100),2) AS reimbursement_rate
FROM pharmacy_rx_billing
WHERE NDC_Billed_Code NOT IN (99999999999, 00000000000)
GROUP BY NDC_Billed_Code
),

drugs AS 
(
SELECT DISTINCT NDC_Billed_Code, Drug_name
FROM pharmacy_rx_billing
),

joined_data AS 
(
SELECT ndc.NDC_Billed_Code, ndc.total_claims, ndc.reimbursement_rate, drugs.Drug_name
FROM ndc
JOIN drugs 
ON ndc.NDC_Billed_Code = drugs.NDC_Billed_Code
),

unique_ndcs AS 
(
SELECT NDC_Billed_Code
FROM joined_data
GROUP BY NDC_Billed_Code
HAVING COUNT(*) = 1
)

SELECT jd.*
FROM joined_data jd
JOIN unique_ndcs un 
ON jd.NDC_Billed_Code = un.NDC_Billed_Code
WHERE jd.reimbursement_rate < 69.7
ORDER BY jd.total_claims DESC
LIMIT 25
;