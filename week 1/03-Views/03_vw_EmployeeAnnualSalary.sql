/* =========================================================================
   Exercise 3: Add Computed Column - Annual Salary
   Goal: View with a computed AnnualSalary column (Salary * 12).
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.vw_EmployeeAnnualSalary', 'V') IS NOT NULL
    DROP VIEW dbo.vw_EmployeeAnnualSalary;
GO

CREATE VIEW dbo.vw_EmployeeAnnualSalary AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    e.Salary        AS MonthlySalary,
    e.Salary * 12    AS AnnualSalary
FROM dbo.Employees e;
GO

-- Test
SELECT * FROM dbo.vw_EmployeeAnnualSalary ORDER BY EmployeeID;
GO
