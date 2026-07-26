/* =========================================================================
   Exercise 9: Create a Nested User-Defined Function
   Goal: fn_CalculateTotalCompensation - combines fn_CalculateAnnualSalary
         and fn_CalculateBonus to compute total compensation.
   ========================================================================= */

USE EmployeeManagementDB;
GO

-- fn_CalculateBonus was dropped in Exercise 5 - recreate it here (10% rate)
-- so this nested function has something to call.
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

IF OBJECT_ID('dbo.fn_CalculateTotalCompensation', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CalculateTotalCompensation;
GO

CREATE FUNCTION dbo.fn_CalculateTotalCompensation (@Salary DECIMAL(10,2))
RETURNS DECIMAL(12,2)
AS
BEGIN
    RETURN dbo.fn_CalculateAnnualSalary(@Salary) + dbo.fn_CalculateBonus(@Salary);
END;
GO

-- Test
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateAnnualSalary(Salary)     AS AnnualSalary,
    dbo.fn_CalculateBonus(Salary)            AS Bonus,
    dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM dbo.Employees;
GO
