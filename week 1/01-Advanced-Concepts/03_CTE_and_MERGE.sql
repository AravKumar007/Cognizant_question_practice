/* =========================================================================
   Exercise 3: CTEs and MERGE
   Goal: Recursive CTE to build a calendar table; MERGE to sync staged prices.
   ========================================================================= */

USE OnlineRetailStoreDB;
GO

-- Step 1: Recursive CTE generating every date from 2025-01-01 to 2025-01-31
WITH DateSequence AS (
    SELECT CAST('2025-01-01' AS DATE) AS CalendarDate
    UNION ALL
    SELECT DATEADD(DAY, 1, CalendarDate)
    FROM DateSequence
    WHERE CalendarDate < '2025-01-31'
)
SELECT
    CalendarDate,
    DATENAME(WEEKDAY, CalendarDate) AS DayName,
    DATEPART(WEEK, CalendarDate)    AS WeekNumber
FROM DateSequence
OPTION (MAXRECURSION 100);
GO

-- Step 2: Staging table holding updated/new product prices
IF OBJECT_ID('dbo.StagingProducts', 'U') IS NOT NULL DROP TABLE dbo.StagingProducts;
GO

CREATE TABLE dbo.StagingProducts (
    ProductID   INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category    VARCHAR(50)  NOT NULL,
    Price       DECIMAL(10,2) NOT NULL
);
GO

-- A mix of price updates for existing products (1, 5) and one brand-new product (11)
INSERT INTO dbo.StagingProducts (ProductID, ProductName, Category, Price) VALUES
(1,  'Wireless Mouse', 'Electronics', 749.00),   -- price drop
(5,  'Office Chair',   'Furniture',   7999.00),  -- price increase
(11, 'Webcam 1080p',   'Electronics', 2299.00);  -- new product
GO

-- Step 3: MERGE existing products with staged data - update matches, insert new rows
MERGE dbo.Products AS Target
USING dbo.StagingProducts AS Source
   ON Target.ProductID = Source.ProductID
WHEN MATCHED AND Target.Price <> Source.Price THEN
    UPDATE SET
        Target.ProductName = Source.ProductName,
        Target.Category    = Source.Category,
        Target.Price       = Source.Price
WHEN NOT MATCHED BY TARGET THEN
    INSERT (ProductID, ProductName, Category, Price)
    VALUES (Source.ProductID, Source.ProductName, Source.Category, Source.Price)
OUTPUT $action AS ActionTaken, inserted.ProductID, inserted.Price;
GO

-- Verify the merge result
SELECT * FROM dbo.Products ORDER BY ProductID;
GO
