/* =========================================================================
   Exercise 8: Return Data from a Table-Valued Function
   Goal: Employees in the Finance department (DepartmentID = 2).
   ========================================================================= */

USE EmployeeManagementDB;
GO

-- Finance = DepartmentID 3 in this exercise's schema
SELECT * FROM dbo.fn_GetEmployeesByDepartment(3);
GO
