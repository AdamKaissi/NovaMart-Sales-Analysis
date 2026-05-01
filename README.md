# NovaMart Retail Analytics
### Executive Summary

I transformed 10,000+ raw retail transactions into a Power BI executive tool to solve NovaMart’s lack of visibility into categorical profitability. Using DAX and relational modeling, I identified a $5.26M revenue total and uncovered a critical 15% return anomaly in the Clothing category.

Strategic Impact:

Inventory Optimization: Recommend doubling down on Electronics, which drives 37.6% of total revenue.

Quality Control: Advised an immediate audit of Clothing suppliers to address the high return rate and protect margins.

KPI Evolution: Proposed transitioning to Average Order Value (AOV) tracking to better measure customer lifetime value.
 
 ## Business Problem

NovaMart, a growing retail entity, possessed large volumes of transactional data across multiple years but lacked a centralized system to track profitability and categorical performance. Management was unable to identify which product categories were driving growth or explain why certain periods showed significant revenue plateaus. The primary goal was to transform raw CSV data into an interactive intelligence tool to support data-driven inventory and marketing decisions.

## Methodology

To resolve these visibility gaps, I implemented a robust end-to-end data pipeline:

Data Integration: Merged separate "Sales" and "Products" data sources using a Left Outer Join in Power Query to connect transaction volume with unit pricing.

Modeling & Logic: Developed a relational schema and authored custom DAX measures including Total Revenue using SUMX and RELATED logic to ensure accurate row-level calculations.

Visual Storytelling: Designed a high-density dashboard featuring:

KPI Cards: For immediate "at-a-glance" revenue totals ($5.26M).

Donut & Stacked Bar Charts: To visualize categorical distribution and YoY composition.

Trend Analysis: A line chart to monitor revenue velocity from 2022 through 2024.

## Key Insights & Findings

Category Dominance: Electronics is the primary revenue driver, accounting for 37.6% of total value, followed closely by Household goods.

The 2023 Anomaly: Analysis revealed a significant performance plateau in mid-2023. Further investigation into the data identified a 15% return rate specifically within the Clothing category during this period.

Volume vs. Value: While Clothing has the highest unit volume (3,865 units), it contributes less to the bottom line than Electronics, indicating lower price points or higher operational costs per unit.

## Strategic Recommendations

Supplier Audit: Conduct an immediate quality review of Clothing suppliers from the Q3 2023 period to address the high return anomaly and prevent future margin erosion.

Electronics Expansion: Given that Electronics drives over a third of total revenue, NovaMart should consider expanding this inventory or increasing marketing spend in this category during peak 2024 cycles.

Metric Evolution: Transition from tracking simple "Quantity" to Average Order Value (AOV) and Profit Margin % to better understand the true health of categorical sales.


# Tools

Power BI (Web/Service), DAX, Power Query.

## Skills

Data Modeling, ETL, Statistical Analysis, Data Visualization.

---

## Tech Stack
* **Python:** Data generation (Faker), EDA (Pandas), and Visualization (Seaborn).
* **SQL:** Relational database design (MySQL) and complex analytical querying.
* **Analysis:** RFM (Recency, Frequency, Monetary) Framework.


## How to Run
1. Clone this repository.
2. Install dependencies: `pip install -r requirements.txt`.
3. Run the analysis: `python3 novamart_final.py`.

## Project Structure
* `novamart_final.py`: Main data pipeline and visualization script.
* `sql_scripts/`: MySQL schema and performance queries.
* `requirements.txt`: Environment configuration.
## Code Highlights
* **Python:** [novamart_final.py](./novamart_final.py) - Contains the logic for data generation and RFM segmentation.
* **SQL:** [analysis_queries.sql](./sql_scripts/analysis_queries.sql) - Features complex joins, window functions for customer ranking, and revenue trend analysis.
