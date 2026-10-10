-- 1. What records are in the table?
SELECT *
FROM OEE_Data
LIMIT 10;

-- 2. How many machines, shifts, and dates are represented?
SELECT
COUNT(DISTINCT machine_id) AS machine_count,
COUNT(DISTINCT shift) AS shift_count,
MIN(date) AS first_date,
MAX(date) AS last_date
FROM  OEE_Data;

-- 3. What is the average OEE?
SELECT 
AVG(oee_pct) AS average_oee
FROM OEE_Data;

-- 4. What are the average availability, performance, and quality values?
SELECT
AVG(availability_pct) AS average_avalability_pct,
AVG(performance_pct) AS average_performance_pct,
AVG(quality_pct) AS average_quality_pct
FROM OEE_Data ;

-- 5. How many units and defects are in the data, and what is the defect rate?
SELECT
SUM(units_produced) AS total_units,
SUM(defects) AS total_defects,
SUM(defects) /SUM(units_produced) * 100 AS defect_rate
FROM OEE_Data ;

-- 6. Which shift has the highest average OEE?
SELECT
shift,
AVG(oee_pct) AS average_oee_pct
FROM OEE_Data
GROUP BY shift
ORDER BY  average_oee_pct DESC ;

-- 7. Which machines have the highest and lowest average OEE?
(SELECT
machine_id,
AVG(oee_pct) AS average_oee_pct
FROM OEE_Data
GROUP BY machine_id
ORDER BY average_oee_pct ASC
LIMIT 1)
UNION ALL
(SELECT
machine_id,
AVG(oee_pct) AS average_oee_pct
FROM OEE_Data
GROUP BY machine_id
ORDER BY average_oee_pct DESC
LIMIT 1) ;

-- 8. How does OEE vary by month?
SELECT
YEAR(date) AS yr,
MONTH(date) AS mth,
ROUND(AVG(oee_pct)*100,1) AS average_pct
FROM OEE_Data
GROUP BY YEAR(date),MONTH(date)
ORDER BY yr, mth ;

-- 9. Which shift has the highest and lowest average OEE ?
SELECT
shift,
ROUND(AVG(oee_pct)*100,1) AS average_pct
FROM OEE_Data
GROUP BY shift
ORDER BY  average_pct DESC ;

-- 10. Which shift has the highest defect rate?
SELECT
shift,
SUM(defects) / SUM(units_produced) * 100 AS defect_rate
FROM OEE_Data
GROUP BY shift
ORDER BY defect_rate DESC ;

-- 11. Which machines produced the most units?
SELECT
machine_id,
SUM(units_produced) AS total_units
FROM OEE_Data
GROUP BY machine_id
ORDER BY total_units DESC
LIMIT 5 ;

-- 12. In the lowest quarter of OEE records, which component is weakest?

WITH OEEGroups AS (
    SELECT *,
        NTILE(4) OVER (ORDER BY oee_pct) AS oee_quartile
    FROM OEE_Data
)
SELECT
    COUNT(*) AS record_count,
    AVG(oee_pct) AS average_oee,
    AVG(availability_pct) AS average_availability,
    AVG(performance_pct) AS average_performance,
    AVG(quality_pct) AS average_quality
FROM OEEGroups
WHERE oee_quartile = 1;

-- 13. What is each machine’s worst OEE record?
WITH RankedRecords AS (
    SELECT
        date,
        machine_id,
        shift,
        oee_pct,
        ROW_NUMBER() OVER ( PARTITION BY machine_id ORDER BY oee_pct ASC ) AS row_num
    FROM OEE_Data
)
SELECT
    date,
    machine_id,
    shift,
    oee_pct
FROM RankedRecords
WHERE row_num = 1
ORDER BY oee_pct;

-- 14. How did monthly OEE change compared with the previous month?
WITH MonthlyOEE AS (
    SELECT
        DATE_FORMAT(DATE, '%Y-%m-01') AS month_start,
        ROUND(AVG(oee_pct)*100,1) AS average_oee
    FROM OEE_Data
    GROUP BY DATE_FORMAT (DATE, '%Y-%m-01')
),
MonthlyChange AS (
    SELECT
        month_start,
        average_oee,
        LAG(average_oee) OVER (ORDER BY month_start) AS previous_month_oee
    FROM MonthlyOEE
)
SELECT
    month_start,
    average_oee,
    previous_month_oee,
    average_oee - previous_month_oee AS change_from_previous_month
FROM MonthlyChange
ORDER BY month_start;

-- 15. Which machines have the highest average OEE within each shift?

WITH MachineShiftOEE AS (
    SELECT
        shift,
        machine_id,
        COUNT(*) AS record_count,
        AVG(oee_pct) AS average_oee
    FROM OEE_Data
    GROUP BY shift, machine_id
),
RankedMachines AS (
    SELECT * ,
	RANK() OVER (PARTITION BY shift ORDER BY average_oee DESC) AS shift_rank
    FROM MachineShiftOEE
)
SELECT
    shift,
    machine_id,
    record_count,
    average_oee
FROM RankedMachines
WHERE shift_rank = 1
ORDER BY shift;

-- 16. What is the running total of units produced over time?
WITH DailyProduction AS (
    SELECT
        `date`,
        SUM(units_produced) AS units_for_day
    FROM OEE_Data
    GROUP BY `date`
)
SELECT
    date,
      units_for_day,
    SUM(units_for_day) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_units
FROM DailyProduction
ORDER BY date;






