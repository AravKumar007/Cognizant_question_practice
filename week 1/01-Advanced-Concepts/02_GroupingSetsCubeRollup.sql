/* =========================================================================
   Exercise 2: Aggregation with GROUPING SETS, CUBE, and ROLLUP
   Goal: Total quantity sold by Region and Category, sliced multiple ways.
   ========================================================================= */

USE OnlineRetailStoreDB;
GO

-- Step 1: Base join used by every query below
--   Orders -> OrderDetails -> Products -> Customers
-- (kept here as a comment for reference; each query re-joins independently)

-- Step 2: GROUPING SETS - totals by Region alone, Category alone, and both together
SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold
FROM dbo.Orders o
JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
JOIN dbo.Products p      ON p.ProductID = od.ProductID
JOIN dbo.Customers c     ON c.CustomerID = o.CustomerID
GROUP BY GROUPING SETS (
    (c.Region, p.Category),
    (c.Region),
    (p.Category),
    ()
)
ORDER BY c.Region, p.Category;
GO

-- Step 3: ROLLUP - hierarchical subtotals (Region -> Region+Category) plus a grand total
SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold
FROM dbo.Orders o
JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
JOIN dbo.Products p      ON p.ProductID = od.ProductID
JOIN dbo.Customers c     ON c.CustomerID = o.CustomerID
GROUP BY ROLLUP (c.Region, p.Category)
ORDER BY c.Region, p.Category;
GO

-- Step 4: CUBE - every possible combination of Region and Category, plus subtotals
SELECT
    c.Region,
    p.Category,
    SUM(od.Quantity) AS TotalQuantitySold
FROM dbo.Orders o
JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
JOIN dbo.Products p      ON p.ProductID = od.ProductID
JOIN dbo.Customers c     ON c.CustomerID = o.CustomerID
GROUP BY CUBE (c.Region, p.Category)
ORDER BY c.Region, p.Category;
GO

-- Bonus: GROUPING() function to label subtotal/grand-total rows clearly
SELECT
    CASE WHEN GROUPING(c.Region) = 1 THEN 'ALL REGIONS' ELSE c.Region END AS Region,
    CASE WHEN GROUPING(p.Category) = 1 THEN 'ALL CATEGORIES' ELSE p.Category END AS Category,
    SUM(od.Quantity) AS TotalQuantitySold
FROM dbo.Orders o
JOIN dbo.OrderDetails od ON od.OrderID = o.OrderID
JOIN dbo.Products p      ON p.ProductID = od.ProductID
JOIN dbo.Customers c     ON c.CustomerID = o.CustomerID
GROUP BY ROLLUP (c.Region, p.Category)
ORDER BY Region, Category;
GO
