# Week 1 - Advanced SQL Server Exercises

Original T-SQL solutions for the Week 1 Advanced SQL Server exercise sheets,
organized one folder per exercise set.

## Folder structure
```
week 1/
├── README.md
├── 01-Advanced-Concepts/       # Window functions, GROUPING SETS/ROLLUP/CUBE,
│                                # recursive CTE + MERGE, PIVOT/UNPIVOT, CTEs
│                                # (Online Retail Store scenario)
├── 03-Views/                   # Views with joins and computed columns
│                                # (Employee Management System)
├── 04-Stored-Procedures/       # 11 stored procedure exercises
├── 05-Functions/               # Scalar, table-valued, and nested functions
├── 06-Triggers/                # AFTER, INSTEAD OF, LOGON triggers
└── 08-Exception-Handling/      # TRY...CATCH, THROW, RAISERROR, transactions
```

Folders are numbered to match the original exercise sheet numbering
(Exercises 2 and 7 weren't part of the provided sheets).

## How to run
Each folder is self-contained:
1. Open the folder's `00_Schema.sql` first - it creates the database and
   seed data used by every script in that folder.
2. Run the numbered `.sql` files in order in SSMS or Azure Data Studio.
3. Each folder has its own `README.md` with the exact run order and any
   folder-specific notes (e.g. differing DepartmentID numbering, or the
   server-scoped LOGON trigger warning in `06-Triggers`).

## Tech
- SQL Server / T-SQL syntax throughout (tested for SSMS / Azure Data Studio).
- Two scenarios are used across the exercises, matching the original sheets:
  - **Online Retail Store** (Customers, Products, Orders, OrderDetails) -
    used only in `01-Advanced-Concepts`.
  - **Employee Management System** (Departments, Employees) - used in
    `03-Views` through `08-Exception-Handling`.
