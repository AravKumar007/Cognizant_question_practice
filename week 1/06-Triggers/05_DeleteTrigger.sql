/* =========================================================================
   Exercise 5: Delete a Trigger
   Goal: Remove the INSTEAD OF DELETE trigger from Employees.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.trg_PreventEmployeeDelete', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_PreventEmployeeDelete;
GO

-- Verify it's gone (returns no rows)
SELECT name FROM sys.triggers WHERE name = 'trg_PreventEmployeeDelete';
GO
