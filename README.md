# Siemens-Manufacturing-OEE-Analysis
This portfolio project analyzes manufacturing Overall Equipment Effectiveness (OEE) using Microsoft SQL Server and Power BI. It explores production performance across machines, shifts, and time, with a focus on OEE, defects, and units produced.

The project demonstrates data cleaning, SQL querying, DAX measures, and dashboard design for manufacturing operations.

## Business Questions

The analysis investigates:

- What records and time period are represented?
- What are the average OEE, Availability, Performance, and Quality?
- How do OEE and defect rates compare across shifts and machines?
- How does OEE change over time?
- Which machines produce the most units?
- Which component is weakest among low-OEE records?
- What are each machine’s worst OEE records?
- How does monthly OEE compare with the previous month?
- Which machine ranks highest within each shift?
- What is the running total of units produced?

## Tools

- Microsoft SQL Server
- Power BI Desktop
- DAX
- GitHub

## Dataset

The dataset contains production records with fields for date, machine, shift, planned and actual hours, OEE components, units produced, and defects.

- Imported records: **975**
- Complete records used: **974**
- Machines: **20**
- Shifts: **3**
- Date range: **January 1, 2023 – May 14, 2024**

One incomplete record was excluded from the cleaned analysis. May 2024 is a partial month.

## Analysis Approach

### SQL Server

SQL was used to load the dataset and answer analysis questions using aggregations, CTEs, and window functions.

### Power BI

Power BI imports the CSV directly. Power Query is used to prepare the data, and DAX measures calculate averages, totals, rankings, month-over-month changes, and running totals.

The three-page dashboard includes:

1. **Key Performance Indicators** — summary metrics and comparisons by machine, shift.
2. **Analysis_1** and  **Analysis_2**  — Analysis by month, Defect rate, Total units, Percentage increase by month, within-shift rankings and running production totals.

Date, machine, and shift slicers let users filter the report. The slicers are synchronized across both pages.

## Key Findings

- Overall average OEE was approximately **64.37%**.
- Average Availability was **81.70%**, Performance **83.95%**, and Quality **93.88%**.
- The lowest-OEE records also had the lowest average Availability among the three OEE components.
- Morning shift had the highest average OEE at approximately **64.56%**; shift averages were close overall.
- Night shift had the highest defect rate at approximately **6.32%**.
- Total production was **3,722,340 units** and **228,276 defects**, for an overall defect rate of approximately **6.13%**.
- MCH-013 had the lowest average OEE at approximately **59.84%**; MCH-020 had the highest at approximately **67.00%**.

## Project Files

- `sql/manufacturing_oee_analysis.sql` — SQL setup, cleaning, and analysis queries.
- `powerbi/manufacturing_oee_dashboard.pbix` — Power BI dashboard.
- `powerbi/powerbi_csv.md` — CSV import steps and DAX measure reference.

Update these paths if your files are stored in different folders.

## Conclusion

The analysis found differences in OEE across machines and months, while average OEE across shifts was relatively similar. Availability was the weakest average OEE component and a useful area for further investigation. Combining SQL and Power BI made it possible to validate the calculations and explore the results interactively.

