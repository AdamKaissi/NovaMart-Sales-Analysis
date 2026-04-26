-- 1. Monthly Sales Trends
SELECT 
    DATE_FORMAT(Date, '%Y-%m-01') AS Sale_Month,
    SUM(Quantity * Unit_Price * (1 - Discount)) AS Monthly_Revenue
FROM Fact_Sales s
JOIN Dim_Products p ON s.Product_ID = p.Product_ID
GROUP BY 1;

-- 2. Customer Lifetime Value (CLV) Ranking
SELECT 
    c.Customer_Name,
    SUM(s.Quantity * p.Unit_Price * (1 - s.Discount)) AS Total_Spent,
    RANK() OVER (ORDER BY SUM(s.Quantity * p.Unit_Price * (1 - s.Discount)) DESC) AS Customer_Rank
FROM Dim_Customers c
JOIN Fact_Sales s ON c.Customer_ID = s.Customer_ID
JOIN Dim_Products p ON s.Product_ID = p.Product_ID
GROUP BY c.Customer_ID, c.Customer_Name
LIMIT 10;