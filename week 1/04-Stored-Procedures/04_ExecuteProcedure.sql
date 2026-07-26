/* =========================================================================
   Exercise 4: Execute a Stored Procedure
   Goal: Execute sp_GetEmployeesByDepartment for a specific DepartmentID.
   ========================================================================= */

USE EmployeeManagementDB;
GO

-- IT department
EXEC dbo.sp_GetEmployeesByDepartment @DepartmentID = 3;
GO

-- HR department
EXEC dbo.sp_GetEmployeesByDepartment @DepartmentID = 1;
GO
