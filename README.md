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
![Executive Summary](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%201%20-%20Executive%20Summary.png)
A provided network-wide performance visibility across all 10 hospitals from January 2021 to December 2025 period. The core KPIs: Total Revenue (₦1.27B), Total Patients (40,000), Readmission Rate (66.7%), and Average Satisfaction Score (5.23/10) are presented with year-over-year variance to distinguish structural trends from period-specific fluctuation. The five-year revenue trend indicates a stable but non-compounding growth pattern, with a ~6% dip in 2023 that recovered by 2024–25. The satisfaction gauge benchmarks current performance against a defined target (7/10), and the emergency-versus-scheduled visit split (50/50) quantifies unplanned-care load at the network level. This page is designed as the primary decision-support surface for leadership, prioritizing directional clarity over granular detail.

### Hospital Performance
![Hospital Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%202%20-%20Hospital%20Performance.png)
This page evaluates the comparative performance across the 10-hospital network on revenue, patient volume, and average wait time. Analysis indicates a high degree of operational parity: revenue variance across sites is approximately 8% (₦122.7M–₦132.5M), and average wait times cluster within a 3-minute band (46–49 minutes) network-wide. This suggests that performance differentials are attributable to case mix rather than site-level operational inefficiency, a materially different conclusion than would follow from a wider spread. The hospital detail table quantifies revenue, patient volume, and average length of stay per site, with drill-through enabled to isolate department- and diagnosis-level activity for any selected hospital, supporting root-cause investigation beyond the summary view.

### Clinical Performance
![Clinical Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%203%20-Clinical%20Performance.png)
This page assesses clinical and operational load: diagnosis volume, length of stay by department, emergency visit rate by department, and readmission rate trend over time. The most consequential finding on this page is a network-wide 30-day readmission rate of 66.7%, which exceeds typical industry benchmarks (approximately 15–20%) by a substantial margin. This metric is flagged for clinical audit rather than presented as a settled conclusion, since it may reflect either a genuine care-quality issue or a definitional inconsistency in how readmissions are logged at intake. Department-level emergency visit rates show limited variance (48–52% across departments), indicating emergency load is distributed evenly rather than concentrated in specific service lines.

### Doctor's Performance
![Doctor Performance](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Page%204%20-%20Doctor's%20Performance.png)
This page provides individual-physician-level performance data: revenue generated, patient volume, and satisfaction scores, supported by a ranked top-10 view and a volume-versus-satisfaction scatter to test whether caseload correlates with care quality. Satisfaction scores remain tightly clustered (5.18–5.36) across physicians with substantially different patient volumes, indicating that higher caseload is not, on this data, associated with a measurable decline in patient-reported satisfaction. The scorecard table applies conditional formatting across revenue and satisfaction fields to surface performance patterns at a glance, supporting workload-balancing and staffing decisions at the individual level.

## Key Findings

- **Readmission rate (66.7%) is well above typical industry benchmarks (~15–20%)** — flagged for clinical audit to determine whether this reflects a genuine care-quality issue or a definitional/coding problem in how readmissions are logged.
- **16–28% of key operational fields** (satisfaction score, wait time, length of stay, treatment cost) were not being captured at intake — previously hidden behind sentinel placeholder values rather than true nulls.
- **Revenue is evenly distributed across the network** (8% spread top-to-bottom) — no single hospital dominates or underperforms sharply, meaning growth opportunities lie in case-mix and service lines rather than fixing an underperforming site.
- **Patient caseload is concentrated among a small group of top physicians** — worth a scheduling review to balance workload without sacrificing the revenue they generate.

Full recommendations are in the presentation deck.

## Tools Used

`Power BI Desktop` · `Power Query (M)` · `DAX` · `Star Schema Modeling`

## Author

[Opeyemi Mercy Lawan](https://www.linkedin.com/in/opeyemi-mercy-lawan-81a048276/)
