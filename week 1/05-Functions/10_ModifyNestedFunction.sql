/* =========================================================================
   Exercise 10: Modify a Nested User-Defined Function
   Goal: Update fn_CalculateBonus's rate and confirm
         fn_CalculateTotalCompensation picks up the new value automatically
         (since it calls fn_CalculateBonus rather than hardcoding the rate).
   ========================================================================= */

USE EmployeeManagementDB;
GO

-- Bump the bonus rate from 10% to 20%
ALTER FUNCTION dbo.fn_CalculateBonus (@Salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @Salary * 0.20;
END;
GO

-- fn_CalculateTotalCompensation needs no changes - it just calls
-- fn_CalculateBonus, so the new rate flows through automatically.
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateBonus(Salary)             AS BonusAt20Percent,
    dbo.fn_CalculateTotalCompensation(Salary) AS TotalCompensation
FROM dbo.Employees;
GO
