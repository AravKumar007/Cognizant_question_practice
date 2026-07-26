/* =========================================================================
   Exercise 5: Delete a User-Defined Function
   Goal: Drop fn_CalculateBonus and confirm it's gone.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.fn_CalculateBonus', 'FN') IS NOT NULL
    DROP FUNCTION dbo.fn_CalculateBonus;
GO

-- Verify: should return no rows
SELECT name FROM sys.objects WHERE name = 'fn_CalculateBonus' AND type = 'FN';
GO

-- NOTE: fn_CalculateBonus is intentionally recreated in
-- 09_fn_CalculateTotalCompensation.sql, since the nested-function exercise
-- depends on it existing again.
