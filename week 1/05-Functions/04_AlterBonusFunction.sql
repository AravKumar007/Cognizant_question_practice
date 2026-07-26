/* =========================================================================
   Exercise 4: Modify a User-Defined Function
   Goal: Alter fn_CalculateBonus to return Salary * 0.15 instead of 0.10.
   ========================================================================= */

USE EmployeeManagementDB;
GO

ALTER FUNCTION dbo.fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.15;
END;
GO

-- Test
SELECT EmployeeID, FirstName, LastName, Salary,
       dbo.fn_CalculateBonus(Salary) AS Bonus
FROM dbo.Employees;
GO
