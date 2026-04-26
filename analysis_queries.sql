-- 1. Create Dimension Tables
-- Disable foreign key checks so we can drop tables in any order
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS Fact_Returns;
DROP TABLE IF EXISTS Fact_Sales;
DROP TABLE IF EXISTS Dim_Customers;
DROP TABLE IF EXISTS Dim_Stores;
DROP TABLE IF EXISTS Dim_Products;

SET FOREIGN_KEY_CHECKS = 1;

-- 1. Create Dimension Tables
CREATE TABLE Dim_Products (
    Product_ID INT UNSIGNED PRIMARY KEY,
    Product_Name VARCHAR(100),
    Category VARCHAR(50),
    Unit_Price DECIMAL(10, 2),
    Cost_Price DECIMAL(10, 2)
);

CREATE TABLE Dim_Stores (
    Store_ID INT UNSIGNED PRIMARY KEY,
    City VARCHAR(50),
    Store_Type VARCHAR(20),
    Manager_Name VARCHAR(100)
);

CREATE TABLE Dim_Customers (
    Customer_ID INT UNSIGNED PRIMARY KEY,
    Customer_Name VARCHAR(100),
    Gender VARCHAR(10),
    Signup_Date DATE
);

-- 2. Create Fact Tables
CREATE TABLE Fact_Sales (
    Transaction_ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Date DATE NOT NULL,
    Customer_ID INT UNSIGNED,
    Product_ID INT UNSIGNED,
    Store_ID INT UNSIGNED,
    Quantity INT CHECK (Quantity > 0),
    Discount DECIMAL(5, 2) DEFAULT 0.00,
    CONSTRAINT fk_sales_customer FOREIGN KEY (Customer_ID) REFERENCES Dim_Customers(Customer_ID),
    CONSTRAINT fk_sales_product FOREIGN KEY (Product_ID) REFERENCES Dim_Products(Product_ID),
    CONSTRAINT fk_sales_store FOREIGN KEY (Store_ID) REFERENCES Dim_Stores(Store_ID)
);

CREATE TABLE Fact_Returns (
    Return_ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Transaction_ID INT UNSIGNED NOT NULL,
    Return_Date DATE NOT NULL,
    Reason VARCHAR(255),
    CONSTRAINT fk_returns_transaction FOREIGN KEY (Transaction_ID) REFERENCES Fact_Sales(Transaction_ID)
);
WITH MonthlySales AS (
    SELECT 
        DATE_FORMAT(Date, '%Y-%m-01') AS Sale_Month,
        SUM(Quantity * Unit_Price * (1 - Discount)) AS Monthly_Revenue
    FROM Fact_Sales s
    JOIN Dim_Products p ON s.Product_ID = p.Product_ID
    GROUP BY 1
)
SELECT 
    Sale_Month,
    Monthly_Revenue,
    LAG(Monthly_Revenue) OVER (ORDER BY Sale_Month) AS Prev_Month_Revenue,
    ((Monthly_Revenue - LAG(Monthly_Revenue) OVER (ORDER BY Sale_Month)) / 
        LAG(Monthly_Revenue) OVER (ORDER BY Sale_Month)) * 100 AS MoM_Growth_Pct
FROM MonthlySales;
SELECT 
    c.Customer_Name,
    SUM(s.Quantity * p.Unit_Price * (1 - s.Discount)) AS Total_Spent,
    RANK() OVER (ORDER BY SUM(s.Quantity * p.Unit_Price * (1 - s.Discount)) DESC) AS Customer_Rank
FROM Dim_Customers c
JOIN Fact_Sales s ON c.Customer_ID = s.Customer_ID
JOIN Dim_Products p ON s.Product_ID = p.Product_ID
GROUP BY c.Customer_ID, c.Customer_Name
LIMIT 10;
SELECT 
    p.Category,
    COUNT(s.Transaction_ID) AS Total_Sales_Count,
    COUNT(r.Return_ID) AS Total_Returns_Count,
    (COUNT(r.Return_ID) / COUNT(s.Transaction_ID)) * 100 AS Return_Rate_Pct
FROM Dim_Products p
JOIN Fact_Sales s ON p.Product_ID = s.Product_ID
LEFT JOIN Fact_Returns r ON s.Transaction_ID = r.Transaction_ID
GROUP BY p.Category
ORDER BY Return_Rate_Pct DESC;
WITH StoreRevenue AS (
    SELECT 
        st.City,
        st.Store_ID,
        SUM(s.Quantity * p.Unit_Price * (1 - s.Discount)) AS Store_Total
    FROM Dim_Stores st
    JOIN Fact_Sales s ON st.Store_ID = s.Store_ID
    JOIN Dim_Products p ON s.Product_ID = p.Product_ID
    GROUP BY st.City, st.Store_ID
)
SELECT 
    City,
    Store_ID,
    Store_Total,
    AVG(Store_Total) OVER(PARTITION BY City) AS City_Avg_Revenue,
    (Store_Total - AVG(Store_Total) OVER(PARTITION BY City)) AS Variance_From_Avg
FROM StoreRevenue;
