# Hospital Operations Analytics — Power BI Capstone
![Dashboard Collage](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Dashboard%20Collage.png)
An end-to-end Business Intelligence project analyzing 5 years of multi-hospital operational data from raw, error-riddled source files through a governed star-schema model to a 4-page interactive Power BI report.

**Network:** 10 hospitals · 40,000 patient visits · Jan 2021 – Dec 2025

## Business Problem

A healthcare group operating multiple hospitals had five years of raw operational data but no unified way to monitor revenue, patient experience, or clinical performance. This project turns that raw data into a governed data model and an interactive report management can act on directly.

## What's in this repo

| File | Description |
|---|---|
| `Hospital_Operations_Analytics.pbix` | The full Power BI report — data model, DAX measures, 4 dashboard pages |
| `docs/PowerBI_Build_Guide.md` | Power Query M code, DAX measure library, star schema design, and dashboard build spec |
| `presentation/Hospital_Operations_Analytics.pptx` | Stakeholder-facing summary of findings and recommendations |
| `screenshots/` | Page-by-page dashboard preview (below) |

## Data Quality & Cleaning

The raw dataset was deliberately messy 15+ distinct issues were identified and resolved in Power Query, including:

- Dates stored in 3 different mixed formats across rows
- Costs stored as text with thousands-separators and sign-entry errors (negative values)
- Sentinel/placeholder values masking missing data (e.g. every unrecorded wait time defaulted to a fixed 1500 minutes)
- Duplicate dimension records from trailing whitespace (150 raw diagnosis rows collapsed to 18 real diagnoses; 20 raw insurance rows collapsed to 5 real providers)
- Inconsistent text casing across gender, Yes/No fields, and provider names

Full details, row counts, and the exact Power Query M code used for each fix are documented in [`docs/PowerBI_Build_Guide.md`](docs/PowerBI_Build_Guide.md).

## Data Model

![Star Schema](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Star%20Schema.png)
Star schema: one fact table (`FactPatientVisits`) with 7 dimensions (Date, Doctor, Department, Diagnosis, Hospital, Insurance, PatientType), all single-direction 1:* relationships — no ambiguous filter paths.

## Report Pages

### Executive Summary
![Hospital Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%201%20-%20Executive%20Summary.png)
Network-wide KPIs with YoY context, revenue trend, satisfaction-vs-target gauge, and emergency/scheduled visit split.

### Hospital Performance
![Hospital Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%201%20-%20Executive%20Summary.png)
Revenue and patient volume by hospital, wait-time comparison, and a full hospital detail breakdown with drill-through to department- and diagnosis-level detail per hospital.

### Clinical Performance
![Clinical Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%203%20-Clinical%20Performance.png).
Top diagnoses by volume, length-of-stay by department, emergency visit rate by department, and readmission rate trend.

### Doctor's Performance
![Doctor Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%204%20-%20Doctor's%20Performance.png)
Top performers by revenue, patient-volume-vs-satisfaction scatter, and a full doctor scorecard with conditional formatting.

## Key Findings

- **Readmission rate (66.7%) is well above typical industry benchmarks (~15–20%)** — flagged for clinical audit to determine whether this reflects a genuine care-quality issue or a definitional/coding problem in how readmissions are logged.
- **16–28% of key operational fields** (satisfaction score, wait time, length of stay, treatment cost) were not being captured at intake — previously hidden behind sentinel placeholder values rather than true nulls.
- **Revenue is evenly distributed across the network** (8% spread top-to-bottom) — no single hospital dominates or underperforms sharply, meaning growth opportunities lie in case-mix and service lines rather than fixing an underperforming site.
- **Patient caseload is concentrated among a small group of top physicians** — worth a scheduling review to balance workload without sacrificing the revenue they generate.

Full recommendations are in the presentation deck.

## Tools Used

`Power BI Desktop` · `Power Query (M)` · `DAX` · `Star Schema Modeling`

## Author

**Opeyemi Mercy Lawan** — Business Data Analyst
