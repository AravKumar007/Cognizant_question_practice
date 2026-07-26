/* =========================================================================
   Exercise 2: Add Computed Column - Full Name
   Goal: View with a computed FullName column.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.vw_EmployeeFullName', 'V') IS NOT NULL
    DROP VIEW dbo.vw_EmployeeFullName;
GO

CREATE VIEW dbo.vw_EmployeeFullName AS
SELECT
    e.EmployeeID,
    e.FirstName + ' ' + e.LastName AS FullName,
    d.DepartmentName
FROM dbo.Employees e
JOIN dbo.Departments d ON d.DepartmentID = e.DepartmentID;
GO

-- Test
SELECT * FROM dbo.vw_EmployeeFullName ORDER BY EmployeeID;
GO
