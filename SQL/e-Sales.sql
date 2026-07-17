
-- Data
SELECT * FROM data;

-- Total Records 
SELECT count(*) AS Total_Records FROM data;

-- Total Sales
SELECT sum(Sales) AS Total_Sales FROM data;

-- Total Profit
SELECT sum(Profit) AS Total_Profit FROM data;

-- Average Sales
SELECT avg(Sales) AS Average_Sales FROM data;

-- Average Profit
SELECT avg(Profit) AS Average_Profit FROM data;

-- Maximum Sales
SELECT max(Sales) AS Maximum_Sales FROM data;

-- Minimum Sales
SELECT min(Sales) AS Minimum_Sales FROM data;

-- Category Wise Profit
SELECT Category,sum(Profit) AS Total_Profit FROM data group by Category order by Total_Profit DESC;

-- City Wise Sales
SELECT City, sum(Sales) AS Total_Sales FROM data group by City order by Total_Sales DESC;   

-- Region Wise Profit
SELECT Region,sum(Profit) AS Total_RegionProfit FROM data GROUP BY Region ORDER BY Total_RegionProfit DESC;

-- Top 10 Product
SELECT `Product Name`, sum(Sales) AS Total_Sales FROM data GROUP BY `Product Name` ORDER BY Total_Sales DESC LIMIT 10; 

-- Bottom 10 Product
SELECT `Product Name`, sum(Sales) AS Total_Sales FROM data GROUP BY `Product Name` ORDER BY Total_Sales ASC LIMIT 10;

--  TOP 10 Customers
SELECT `Customer Name`,sum(Sales) AS Total_Sales FROM data GROUP BY `Customer Name` ORDER BY Total_Sales DESC LIMIT 10;

-- Highest Profit Orders
SELECT * FROM data ORDER BY Profit DESC LIMIT 10; 

-- Lowest Profit Orders
SELECT * FROM data ORDER BY Profit ASC LIMIT 10;

-- Total Quantity Sold
SELECT sum(Quantity)  AS Total_Quantity FROM data;

-- Average Discount
SELECT avg(Discount) AS Average_Discount FROM data;

-- Sales By Sub-Category
SELECT `Sub-Category`, sum(Sales) AS Total_Sales FROM data GROUP BY `Sub-Category` ORDER BY Total_Sales DESC;

-- Order With Profit > 1000
SELECT * FROM data WHERE Profit > 1000;

-- Order With Loss
SELECT * FROM data WHERE Profit < 0;

-- Top 5 Cities By Profit
SELECT City,sum(Profit) AS Total_Profit FROM data GROUP BY City ORDER BY Total_Profit DESC LIMIT 5;

-- Having Sales
SELECT Category,sum(Sales) AS Total_Sales FROM data GROUP BY Category having sum(Sales) > 100000;

-- CASE WHEN Status
SELECT 	`Order ID`,Profit, CASE WHEN Profit > 0 THEN 'Profit' WHEN Profit = 0 THEN 'No Profit' ELSE 'Loss' END AS Status FROM data;

-- Avg > Sales
SELECT * FROM data WHERE Sales > (SELECT avg(Sales) FROM data);

-- Avg Sales High Sales Product 
SELECT * FROM data d1 WHERE Sales > (SELECT AVG(Sales) FROM data d2 WHERE d1.Category = d2.Category);

-- CTE TOP 3 Category By Sales
with CategorySales AS ( SELECT Category, sum(Sales) AS TotalSales FROM data GROUP BY Category) SELECT * FROM  CategorySales ORDER BY TotalSales DESC LIMIT 3;

-- Row_Num
SELECT Category,`Product Name`, Sales,ROW_NUMBER() OVER(PARTITION BY Category ORDER BY Sales DESC) AS RowNo FROM data; 

-- Rank Product Sales
SELECT `Product Name`,Sales,RANK() OVER(ORDER BY Sales DESC) AS Ranking FROM data;

-- DENSE_RANK Profit Ranking
SELECT `Product Name`,Profit, DENSE_RANK() OVER(ORDER BY Profit DESC) AS Ranking FROM data;

-- LAG Previous Order
SELECT `Order Date`, Sales, LAG(Sales) OVER(ORDER BY `Order Date`) AS PreviousSales FROM data;

-- Next Order Sales
SELECT `Order Date`, Sales, LEAD(Sales) OVER(ORDER BY `Order Date`) AS NextSales FROM data;

-- Running Total 
SELECT `Order Date`, Sales, sum(Sales) OVER(order by `Order Date`) AS RunningSales FROM data;

-- Region By Running Sales
SELECT Region,Sales,sum(Sales) OVER(PARTITION BY Region ORDER BY `Order Date`) AS RegionSales FROM data;

-- Month By Total Sale
SELECT MONTH(`Order Date`) AS MonthNo,sum(Sales) AS TotalSales FROM data GROUP BY MONTH(`Order Date`) ORDER BY MonthNo;

-- Region By Loss
SELECT Region,sum(Profit) AS TotalLoss FROM data GROUP BY Region ORDER BY TotalLoss ASC LIMIT 1;
