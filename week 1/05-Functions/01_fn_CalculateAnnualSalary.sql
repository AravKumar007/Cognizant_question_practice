/* =========================================================================
   Exercise 1: Create a Scalar Function
   Goal: fn_CalculateAnnualSalary(Salary) -> Salary * 12
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.fn_CalculateAnnualSalary', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CalculateAnnualSalary;
GO

CREATE FUNCTION dbo.fn_CalculateAnnualSalary (@Salary DECIMAL(10,2))
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN @Salary * 12;
END;
GO

-- Test
SELECT EmployeeID, FirstName, LastName, Salary,
       dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM dbo.Employees;
GO
