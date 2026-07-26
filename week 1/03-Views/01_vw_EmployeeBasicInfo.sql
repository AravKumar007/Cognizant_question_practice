/* =========================================================================
   Exercise 1: Create a Simple View
   Goal: Show basic employee details joined with department name.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.vw_EmployeeBasicInfo', 'V') IS NOT NULL
    DROP VIEW dbo.vw_EmployeeBasicInfo;
GO

CREATE VIEW dbo.vw_EmployeeBasicInfo AS
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    d.DepartmentName
FROM dbo.Employees e
JOIN dbo.Departments d ON d.DepartmentID = e.DepartmentID;
GO

-- Test
SELECT * FROM dbo.vw_EmployeeBasicInfo ORDER BY EmployeeID;
GO
