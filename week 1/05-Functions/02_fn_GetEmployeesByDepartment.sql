/* =========================================================================
   Exercise 2: Create a Table-Valued Function
   Goal: fn_GetEmployeesByDepartment(DepartmentID) -> table of employees
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.fn_GetEmployeesByDepartment', 'IF') IS NOT NULL
    DROP FUNCTION dbo.fn_GetEmployeesByDepartment;
GO

CREATE FUNCTION dbo.fn_GetEmployeesByDepartment (@DepartmentID INT)
RETURNS TABLE
AS
RETURN (
    SELECT EmployeeID, FirstName, LastName, Salary, JoinDate
    FROM dbo.Employees
    WHERE DepartmentID = @DepartmentID
);
GO

-- Test: employees in the IT department (DepartmentID = 2 in this schema)
SELECT * FROM dbo.fn_GetEmployeesByDepartment(2);
GO
