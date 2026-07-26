/* =========================================================================
   Exercise 4: Add Multiple Computed Columns
   Goal: Full report view - EmployeeID, FullName, DepartmentName,
         AnnualSalary, Bonus (10% of AnnualSalary).
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.vw_EmployeeReport', 'V') IS NOT NULL
    DROP VIEW dbo.vw_EmployeeReport;
GO

CREATE VIEW dbo.vw_EmployeeReport AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    d.DepartmentName,
    (e.Salary * 12)          AS AnnualSalary,
    (e.Salary * 12) * 0.10   AS Bonus
FROM dbo.Employees e
JOIN dbo.Departments d ON d.DepartmentID = e.DepartmentID;
GO

-- Test
SELECT * FROM dbo.vw_EmployeeReport ORDER BY EmployeeID;
GO
