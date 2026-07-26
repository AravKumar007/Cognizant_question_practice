/* =========================================================================
   Exercise 5: Return Data from a Stored Procedure
   Goal: sp_GetEmployeeCountByDepartment - total employees in a department.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_GetEmployeeCountByDepartment', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_GetEmployeeCountByDepartment;
GO

CREATE PROCEDURE dbo.sp_GetEmployeeCountByDepartment
    @DepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;

    SELECT COUNT(*) AS EmployeeCount
    FROM dbo.Employees
    WHERE DepartmentID = @DepartmentID;
END;
GO

-- Test
EXEC dbo.sp_GetEmployeeCountByDepartment @DepartmentID = 3;
GO
