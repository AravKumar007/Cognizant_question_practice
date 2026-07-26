/* =========================================================================
   Exercise 7: Create a Stored Procedure with Multiple Parameters
   Goal: sp_UpdateEmployeeSalary - update an employee's salary.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_UpdateEmployeeSalary', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_UpdateEmployeeSalary;
GO

CREATE PROCEDURE dbo.sp_UpdateEmployeeSalary
    @EmployeeID INT,
    @NewSalary  DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE dbo.Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;
END;
GO

-- Test
EXEC dbo.sp_UpdateEmployeeSalary 1, 5500.00;

SELECT * FROM dbo.Employees WHERE EmployeeID = 1;
GO
