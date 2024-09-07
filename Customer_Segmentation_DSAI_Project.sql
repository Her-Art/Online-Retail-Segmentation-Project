#Checking for Datatypes and basic table information in SQL
DESCRIBE Retaildb.ORetail;
SELECT MAX(InvoiceDate) AS MAX, MIN(InvoiceDate) AS MIN
FROM Retaildb.ORetail;

#To Change datetime column to SQL datetime Format
ALTER TABLE Retaildb.ORetail
MODIFY InvoiceDate DATETIME;

UPDATE Retaildb.ORetail
SET InvoiceDate = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');

SELECT COLUMN_NAME 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'Retaildb' 
AND TABLE_NAME = 'ORetail' 
AND COLUMN_KEY = 'PRI';

UPDATE Retaildb.ORetail
SET NewInvoiceDate = STR_TO_DATE(InvoiceDate, '%m/%d/%Y');
SELECT DATE_FORMAT(InvoiceDate, '%Y-%m') AS Month, COUNT(*) AS NumberOfSales, SUM(Quantity * UnitPrice) AS TotalSales
FROM Retaildb.ORetail
GROUP BY Month
ORDER BY Month;

SELECT Country, COUNT(DISTINCT CustomerID) AS CustomerCount
FROM Retaildb.ORetail
GROUP BY Country
order by CustomerCount Desc;

SELECT CustomerID, SUM(Quantity) AS TotalQuantity
FROM Retaildb.ORetail
GROUP BY CustomerID;

SELECT CustomerID, SUM(Quantity * UnitPrice) AS TotalAmountSpent
FROM Retaildb.ORetail
GROUP BY CustomerID
ORDER BY TotalAmountSpent DESC
LIMIT 10;  -- Limiting to top 10 customers

SELECT StockCode, Description, SUM(Quantity) AS TotalQuantitySold
FROM Retaildb.ORetail
GROUP BY StockCode, Description
ORDER BY TotalQuantitySold DESC;

SELECT CustomerID, COUNT(DISTINCT InvoiceDate) AS PurchaseDates
FROM Retaildb.ORetail
GROUP BY CustomerID
HAVING COUNT(DISTINCT InvoiceDate) > 1;
SELECT CustomerID, SUM(Quantity * UnitPrice) AS OrderValue
FROM Retaildb.ORetail
GROUP BY CustomerID;
SELECT CustomerID, COUNT(DISTINCT StockCode) AS UniqueProductsCount
FROM Retaildb.ORetail
GROUP BY CustomerID;

Select * from Retaildb.ORetail;



SELECT CustomerID
FROM Retaildb.ORetail
GROUP BY CustomerID
HAVING COUNT(InvoiceNo) = 1;

SELECT Country, AVG(Quantity * UnitPrice) AS AvgOrderValue
FROM Retaildb.ORetail
GROUP BY Country;
SELECT a.StockCode AS ProductA, b.StockCode AS ProductB, COUNT(*) AS PurchaseCount
FROM Retaildb.ORetail a
JOIN Retaildb.ORetail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode < b.StockCode
GROUP BY ProductA, ProductB
ORDER BY PurchaseCount DESC;

SELECT CustomerID,
       CASE 
           WHEN COUNT(InvoiceNo) > 50 THEN 'High Frequency'
           WHEN COUNT(InvoiceNo) BETWEEN 30 AND 49 THEN 'Medium Frequency'
           ELSE 'Low Frequency'
       END AS PurchaseFrequency
FROM Retaildb.ORetail
GROUP BY CustomerID;
#ChurnAnlysis
SELECT DATE '2011-06-30' AS asw;
SELECT '2011-01-01 12:15:00' AS aswq;
#Pattern Analysis
SELECT CustomerID
FROM Retaildb.ORetail
WHERE InvoiceDate < DATE_SUB('2011-06-30 12:15:00', INTERVAL 6 MONTH)
GROUP BY CustomerID
HAVING COUNT(InvoiceNo) = 0;
#Items Often Purchased Together
SELECT a.StockCode AS ProductA, b.StockCode AS ProductB, COUNT(*) AS PurchaseCount
FROM Retaildb.ORetail a
JOIN Retaildb.ORetail b ON a.InvoiceNo = b.InvoiceNo AND a.StockCode < b.StockCode
GROUP BY ProductA, ProductB
ORDER BY PurchaseCount DESC;

SELECT 
    'CustomerID' AS Customer,
    COUNT(DISTINCT Column1) AS DistinctValues
FROM Retaildb.ORetail
UNION ALL
SELECT 
    'Unitprice' AS ColumnName,
    COUNT(DISTINCT Column2) AS DistinctValues
FROM Retaildb.ORetail
-- Repeat for each column in your table

#TimeSeries Analysis of Purchase Patterns
SELECT CustomerID 
FROM Retaildb.ORetail 
WHERE InvoiceDate < DATE_SUB('2012-06-30 12:15:00', INTERVAL 6 MONTH) 
GROUP BY CustomerID 
HAVING COUNT(InvoiceNo) = 0;
#REcency
SELECT CustomerID, MAX(InvoiceDate) AS LastPurchaseDate,
       DATEDIFF('2011-06-30 12:15:00', MAX(InvoiceDate)) AS Recency
FROM retailshop.online_retail
GROUP BY CustomerID;









