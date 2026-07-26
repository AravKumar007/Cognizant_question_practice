/* =========================================================================
   Exercise 2: Modify a Stored Procedure
   Goal: Retrieve employee details by department, then modify the procedure
         to also include Salary in the result set.
   ========================================================================= */

USE EmployeeManagementDB;
GO

-- Step 1: Original version - department lookup without Salary
IF OBJECT_ID('dbo.sp_GetEmployeesByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_GetEmployeesByDepartment;
GO

CREATE PROCEDURE dbo.sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, FirstName, LastName, DepartmentID, JoinDate
    FROM dbo.Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- Step 2 & 3: Modify the procedure to add the Salary column to the result
ALTER PROCEDURE dbo.sp_GetEmployeesByDepartment
    @DepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
    FROM dbo.Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- Test
EXEC dbo.sp_GetEmployeesByDepartment @DepartmentID = 3;
GO
