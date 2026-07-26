/* =========================================================================
   Exercise 1: Ranking and Window Functions
   Goal: ROW_NUMBER(), RANK(), DENSE_RANK(), OVER(), PARTITION BY
   Scenario: Top 3 most expensive products in each category.
   ========================================================================= */

USE OnlineRetailStoreDB;
GO

-- Step 1 & 3: ROW_NUMBER() gives a strictly unique rank per category,
-- even when two products share the same price.
SELECT
    ProductID,
    ProductName,
    Category,
    Price,
    ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RowNum
FROM dbo.Products
ORDER BY Category, RowNum;
GO

-- Step 2: RANK() vs DENSE_RANK() - see how each handles tied prices.
-- RANK() leaves gaps after a tie (1,1,3,...), DENSE_RANK() does not (1,1,2,...).
SELECT
    ProductID,
    ProductName,
    Category,
    Price,
    RANK()       OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceRank,
    DENSE_RANK() OVER (PARTITION BY Category ORDER BY Price DESC) AS PriceDenseRank
FROM dbo.Products
ORDER BY Category, PriceRank;
GO

-- Final: Top 3 most expensive products per category using ROW_NUMBER()
WITH RankedProducts AS (
    SELECT
        ProductID,
        ProductName,
        Category,
        Price,
        ROW_NUMBER() OVER (PARTITION BY Category ORDER BY Price DESC) AS RankInCategory
    FROM dbo.Products
)
SELECT ProductID, ProductName, Category, Price, RankInCategory
FROM RankedProducts
WHERE RankInCategory <= 3
ORDER BY Category, RankInCategory;
GO
