# Hospital Operations Analytics — Power BI Capstone
![Dashboard Collage](https://github.com/LawanMercy/Hospital-Operations-Analysis/blob/main/Resources/Dashboard%20Collage.png)
An end-to-end Business Intelligence project built to mirror how analytics actually gets delivered inside a healthcare organization: raw, imperfect data landed in a relational database, profiled and cleaned by hand, modeled into a governed star schema, and shipped as a polished, interactive report an executive could open on day one and trust.

This isn't a "clean CSV in, pretty chart out" exercise. The dataset was deliberately built with the kind of mess real operational systems produce - mixed date formats, silent placeholder values standing in for missing data, duplicate records hiding behind trailing whitespaces. The project walks the full path from PostgreSQL through Power Query, DAX, and data modeling to a 4-page report and stakeholder presentation.

**Network:** 10 hospitals · 40,000 patient visits · January 2021 – December 2025

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


## Data Quality & Cleaning
|# ||Table | Issue | Rows Affected | Resoultion
|---|---|---|---|---|
|1| FactPatientVisits |2 exact duplicate rows (duplicate VisitID) | 2 | 	Removed, keep first
|2|FactPatientVisits |VisitDate in 3 mixed formats: YYYY-MM-DD, MM-DD-YYYY, DD/MM/YYYY | 40,000 | Detected format by pattern, parsed to a single date type
|3|FactPatientVisits |TreatmentCost / MedicationCost stored as text with thousands-commas |40,000 | Stripped commas, converted to Decimal Number
|4|FactPatientVisits |Negative treatment/medication costs (sign-entry errors — costs only take 5 fixed tiers) | 6,715 / 9,904| Converted to absolute value
|5|FactPatientVisits |TreatmentCost missing | 6,734 |	Left null — excluded automatically from SUM measures
|6|FactPatientVisits |SatisfactionScore pinned at sentinel value 25 (scale is 1–10)| 5,631| Set to null (not recorded)
|7|FactPatientVisits |WaitTimeMinutes pinned at sentinel value 1500| 7,940| Set to null (not recorded)
|8|FactPatientVisits |LengthOfStay pinned at sentinel value 365)|6,692| Set to null (not recorded)
|9|FactPatientVisits |Readmitted30Days inconsistent case ("Yes"/"YES"/"No")|~40,000|Standardized to Title Case
|10|FactPatientVisits |InsuranceKey missing|1,941|Mapped to new "Not Recorded" member
|11|DimDiagnosis |150 rows but only 18 real diagnoses (trailing-space duplicates, e.g. "Ulcer" vs "Ulcer  ")|132 duplicate rows|Trimmed, Title Cased, deduplicated; Fact table remapped to canonical keys
|12|DimInsurance|20 rows but only 5 real providers (surrogate-key duplicates)|15 duplicate rows|Deduplicated to 5 + added "Not Recorded"; Fact table remapped
|13|DimDiagnosis |150 rows but only 18 real diagnoses (trailing-space duplicates, e.g. "Ulcer" vs "Ulcer  ")|132 duplicate rows|Trimmed, Title Cased, deduplicated; Fact table remapped to canonical keys

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

- **Readmission rate (66.7%) is well above typical industry benchmarks (~15–20%)**,flagged for clinical audit to determine whether this reflects a genuine care-quality issue or a definitional/coding problem in how readmissions are logged.
- **16–28% of key operational fields** (satisfaction score, wait time, length of stay, treatment cost) were not being captured at intake, previously hidden behind sentinel placeholder values rather than true nulls.
- **Revenue is evenly distributed across the network** (8% spread top-to-bottom) no single hospital dominates or underperforms sharply, meaning growth opportunities lie in case-mix and service lines rather than fixing an underperforming site.
- **Patient caseload is concentrated among a small group of top physicians**,worth a scheduling review to balance workload without sacrificing the revenue they generate.
- **Doctor caseload is concentrated among top performers, but satisfaction scores stay tightly clustered (5.18–5.36) regardless of volume, high caseload isn't measurably hurting care quality
- **Emergency visit rate sits at ~50% network-wide, and department-level emergency load is fairly even (48–52%), not concentrated in specific departments

Full recommendations are in the presentation deck, click here to access it 

## Tools Used

`PostgreSQL`, `Power BI Desktop` · `Power Query (M)` · `DAX` · `Star Schema Modeling`

## Author

[Opeyemi Mercy Lawan](https://www.linkedin.com/in/opeyemi-mercy-lawan-81a048276/)
