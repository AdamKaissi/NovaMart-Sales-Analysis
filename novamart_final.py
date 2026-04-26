import pandas as pd
import numpy as np
from faker import Faker
import random
from datetime import datetime, timedelta
import matplotlib.pyplot as plt
import seaborn as sns

# --- STEP 1: GENERATE DATA ---
fake = Faker()
print("Generating realistic retail data...")

# (Data generation logic)
products_data = [[i, f"Prod_{i}", random.choice(['Electronics', 'Clothing', 'Household']), 
                  round(random.uniform(20, 1000), 2)] for i in range(1, 51)]
df_products = pd.DataFrame(products_data, columns=['Product_ID', 'Product_Name', 'Category', 'Unit_Price'])

sales_data = []
for i in range(1, 5000):
    date = datetime(2022, 1, 1) + timedelta(days=random.randint(0, 1000))
    sales_data.append([i, date, random.randint(1, 100), random.randint(1, 50), random.randint(1, 3), random.uniform(0, 0.2)])
df_sales = pd.DataFrame(sales_data, columns=['Transaction_ID', 'Date', 'Customer_ID', 'Product_ID', 'Quantity', 'Discount'])

# Save them so they exist for the next step
df_sales.to_csv('sales.csv', index=False)
df_products.to_csv('products.csv', index=False)

# --- STEP 2: PERFORM ANALYSIS (EDA) ---
print("Analyzing data and generating insights...")
df = df_sales.merge(df_products, on='Product_ID')
df['Revenue'] = df['Quantity'] * df['Unit_Price'] * (1 - df['Discount'])

# Create Visuals
plt.figure(figsize=(10, 5))
sns.barplot(data=df, x='Category', y='Revenue', estimator=sum, palette='magma')
plt.title('NovaMart Revenue by Category (2022-2024)')
plt.ylabel('Total Revenue ($)')
plt.show()

print("Success! Your CSV files are in the folder and your chart is ready.")
