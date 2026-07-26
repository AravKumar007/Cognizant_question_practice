/* =========================================================================
   Exercise 5: Using a CTE to Simplify a Query
   Goal: Find all customers who have placed more than 3 orders.
   ========================================================================= */

USE OnlineRetailStoreDB;
GO

-- A couple of extra orders so at least one customer crosses the 3-order mark
IF NOT EXISTS (SELECT 1 FROM dbo.Orders WHERE OrderID = 15)
BEGIN
    INSERT INTO dbo.Orders (OrderID, CustomerID, OrderDate) VALUES
    (15, 1, '2025-02-20'),
    (16, 1, '2025-03-01');
END
GO

-- Step 1: CTE counting orders per customer
WITH CustomerOrderCounts AS (
    SELECT
        o.CustomerID,
        COUNT(o.OrderID) AS OrderCount
    FROM dbo.Orders o
    GROUP BY o.CustomerID
)
-- Step 2: Filter to customers with more than 3 orders
SELECT
    c.CustomerID,
    c.Name,
    coc.OrderCount
FROM CustomerOrderCounts coc
JOIN dbo.Customers c ON c.CustomerID = coc.CustomerID
WHERE coc.OrderCount > 3
ORDER BY coc.OrderCount DESC;
GO
