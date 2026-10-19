# 🛡️ Fintech Fraud & Expected Loss Executive Command Center

![Dashboard Preview](assets/dashboard_screenshot.png)

## 📌 Executive Summary
This project delivers an interactive, executive-grade fintech risk command center built to monitor portfolio exposure, expected loss, and emerging fraud vectors across transaction records[cite: 9]. Designed for a C-suite audience, the dashboard utilizes a sleek dark-mode UI to surface actionable risk intelligence regarding device types and proxy (VPN) usage[cite: 9].

🔗 **[Live Interactive Dashboard on Tableau Public](https://public.tableau.com/views/fraud_analysis/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)**

---

## 📊 Key Portfolio Metrics
* **Total Portfolio Exposure (EAD):** **$2,648,530.79** baseline monetary exposure across active transaction streams[cite: 9].
* **Total Expected Loss (EL):** **$45,195.56** calculated across localized default rates and exposure amounts[cite: 9].
* **Overall Portfolio Loss Rate:** **1.71%**, operating within baseline target risk parameters[cite: 9].
* **Primary Threat Vector:** ATM Machines and Android devices utilizing active **VPN proxies** exhibit localized fraud rates peaking up to **~7.50%**[cite: 9].

---

## 🛠️ End-to-End Data Pipeline & Methodology

### Phase 1: Excel Data Cleansing & Validation
Before database ingestion, raw transaction data underwent rigorous preprocessing in Excel:
* **Data Hygiene:** Inspected records for null values, duplicates, and malformed categorical entries.
* **Feature Standardization:** Cleaned device type nomenclature (`ATM Machine`, `Android Phone`, `POS Terminal`, etc.) and validated boolean VPN proxy flags (`TRUE`/`FALSE`)[cite: 9].
* **Initial Sanity Checks:** Utilized pivot tables to review baseline loss percentages prior to database loading.

### Phase 2: SQL Data Modeling & Risk Calculations
Data was modeled and aggregated in SQL (`sql/queries.sql`) to optimize performance for reporting:
* **Risk Formula Implemented:** 
  $$\text{Expected Loss (EL)} = \text{PD} \times \text{LGD} \times \text{EAD}$$
  * **PD (Probability of Default):** Calculated historical fraud rate per segment.
  * **LGD (Loss Given Default):** Standardized fintech baseline recovery rate ($50\%$).
  * **EAD (Exposure at Default):** Total transaction dollar exposure.

### Phase 3: Tableau Executive Command Center & Visual Design
The dashboard was engineered in Tableau Public following modern enterprise BI standards[cite: 9]:
* **Dark-Mode UI Theme:** Designed with a deep navy/slate background (`#0F172A`) to minimize eye strain and simulate a real-time monitoring command center[cite: 9].
* **Layout Architecture:** Strict utilization of tiled horizontal and vertical containers to eliminate visual overlap and maintain responsive scaling[cite: 9].
* **Dynamic Interactivity:** Configured bi-directional filter actions allowing executives to click on high-risk clusters in the Risk Matrix to instantly filter the entire command center view[cite: 9].

---

## 📁 Repository Structure
* `/sql/queries.sql` — Complete SQL scripts for risk tiers, velocity ranking, and device/VPN aggregations.
* `/data/vpn_risk_summary.csv` — Aggregated dataset used for reporting and Excel baseline validation.
* `/assets dashboard.png` — Visual preview of the final Tableau command center.
