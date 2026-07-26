/* =========================================================================
   Exercise 3: Create a User-Defined Function
   Goal: fn_CalculateBonus(Salary) -> Salary * 0.10
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.fn_CalculateBonus', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CalculateBonus;
GO

CREATE FUNCTION dbo.fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.10;
END;
GO

-- Test
SELECT EmployeeID, FirstName, LastName, Salary,
       dbo.fn_CalculateBonus(Salary) AS Bonus
FROM dbo.Employees;
GO
