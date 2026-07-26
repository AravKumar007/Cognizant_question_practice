# Exercise 1 - Advanced SQL Concepts (Online Retail Store)

Covers window functions, GROUPING SETS/ROLLUP/CUBE, recursive CTEs, MERGE,
PIVOT/UNPIVOT, and simplifying queries with CTEs.

## Run order
1. `00_Schema.sql` - creates `OnlineRetailStoreDB` and seeds Customers, Products,
   Orders, and OrderDetails.
2. `01_RankingWindowFunctions.sql` - ROW_NUMBER / RANK / DENSE_RANK, top 3
   products per category.
3. `02_GroupingSetsCubeRollup.sql` - quantity sold by Region/Category using
   GROUPING SETS, ROLLUP, and CUBE.
4. `03_CTE_and_MERGE.sql` - recursive CTE calendar table + MERGE from a
   staging table.
5. `04_PivotUnpivot.sql` - monthly sales pivoted into columns, then unpivoted
   back to rows.
6. `05_CTE_CustomerOrders.sql` - CTE to find customers with more than 3 orders.

## Notes
- Built and tested against SQL Server (T-SQL) syntax.
- Each script can be re-run safely; staging/extra-row inserts are guarded with
  existence checks so re-running the whole folder top to bottom won't error out.
