/* =========================================================================
   Exercise 4: PIVOT and UNPIVOT
   Goal: Monthly sales quantity per product, pivoted into columns and back.
   ========================================================================= */

USE OnlineRetailStoreDB;
GO

-- Add a few more orders across different months so the pivot has something to show
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderID = 11)
BEGIN
    INSERT INTO dbo.Orders (OrderID, CustomerID, OrderDate) VALUES
    (11, 2, '2025-02-02'),
    (12, 4, '2025-02-14'),
    (13, 5, '2025-03-05'),
    (14, 1, '2025-03-19');

    INSERT INTO dbo.OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
    (15, 11, 1, 3),
    (16, 11, 8, 2),
    (17, 12, 2, 1),
    (18, 13, 1, 4),
    (19, 14, 2, 2);
END
GO

-- Step 1: Aggregate quantity sold by Product and Month
WITH MonthlySales AS (
    SELECT
        p.ProductName,
        DATENAME(MONTH, o.OrderDate) AS SalesMonth,
        SUM(od.Quantity) AS QuantitySold
    FROM dbo.Orders o
    JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
    JOIN dbo.Products p      ON p.ProductID = od.ProductID
    GROUP BY p.ProductName, DATENAME(MONTH, o.OrderDate)
)
SELECT * FROM MonthlySales ORDER BY ProductName, SalesMonth;
GO

-- Step 2: PIVOT - one column per month
WITH MonthlySales AS (
    SELECT
        p.ProductName,
        DATENAME(MONTH, o.OrderDate) AS SalesMonth,
        od.Quantity
    FROM dbo.Orders o
    JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
    JOIN dbo.Products p      ON p.ProductID = od.ProductID
)
SELECT
    ProductName,
    ISNULL([January], 0) AS January,
    ISNULL([February], 0) AS February,
    ISNULL([March], 0) AS March
FROM MonthlySales
PIVOT (
    SUM(Quantity)
    FOR SalesMonth IN ([January], [February], [March])
) AS PivotedSales
ORDER BY ProductName;
GO

-- Step 3: UNPIVOT - convert the pivoted table back into row format
WITH PivotedResult AS (
    SELECT * FROM (
        SELECT
            p.ProductName,
            DATENAME(MONTH, o.OrderDate) AS SalesMonth,
            od.Quantity
        FROM dbo.Orders o
        JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
        JOIN dbo.Products p      ON p.ProductID = od.ProductID
    ) AS SourceData
    PIVOT (
        SUM(Quantity)
        FOR SalesMonth IN ([January], [February], [March])
    ) AS PivotTable
)
SELECT ProductName, SalesMonth, QuantitySold
FROM PivotedResult
UNPIVOT (
    QuantitySold FOR SalesMonth IN ([January], [February], [March])
) AS UnpivotedSales
ORDER BY ProductName, SalesMonth;
GO
