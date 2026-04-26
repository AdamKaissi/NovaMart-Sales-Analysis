# NovaMart Retail Analytics
### End-to-End Retail Intelligence & Customer Segmentation

Most retail data is noisy, so I built NovaMart Analytics to find the signal. I simulated a 10k-record dataset to solve real-world headaches like inventory bloat and churn. By segmenting 500+ shoppers, I flagged a 22% churn risk that traditional reporting misses. My approach: data isn't just numbers; it's about knowing exactly what to do next.

---

## Tech Stack
* **Python:** Data generation (Faker), EDA (Pandas), and Visualization (Seaborn).
* **SQL:** Relational database design (MySQL) and complex analytical querying.
* **Analysis:** RFM (Recency, Frequency, Monetary) Framework.

## Key Business Insights
* **Churn Prevention:** Identified that 22% of high-value "Loyal" customers had not purchased in 6+ months.
* **Growth Drivers:** Electronics accounts for 45% of total revenue; recommended an up-sell strategy for protection plans.
* **Operations:** Discovered a 15% return rate in Clothing, specifically tied to sizing inconsistencies in the Miami flagship.

## How to Run
1. Clone this repository.
2. Install dependencies: `pip install -r requirements.txt`.
3. Run the analysis: `python3 novamart_final.py`.

## Project Structure
* `novamart_final.py`: Main data pipeline and visualization script.
* `sql_scripts/`: MySQL schema and performance queries.
* `requirements.txt`: Environment configuration.
