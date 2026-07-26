/* =========================================================================
   Exercise 6: Use Output Parameters in a Stored Procedure
   Goal: sp_GetTotalSalaryByDepartment - total salary via an OUTPUT parameter.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_GetTotalSalaryByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_GetTotalSalaryByDepartment;
GO

CREATE PROCEDURE dbo.sp_GetTotalSalaryByDepartment
    @DepartmentID INT,
    @TotalSalary  DECIMAL(12,2) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @TotalSalary = SUM(Salary)
    FROM dbo.Employees
    WHERE DepartmentID = @DepartmentID;

    SET @TotalSalary = ISNULL(@TotalSalary, 0);
END;
GO

-- Test
DECLARE @DeptTotalSalary DECIMAL(12,2);

EXEC dbo.sp_GetTotalSalaryByDepartment
    @DepartmentID = 3,
    @TotalSalary  = @DeptTotalSalary OUTPUT;

SELECT @DeptTotalSalary AS TotalSalaryForIT;
GO
