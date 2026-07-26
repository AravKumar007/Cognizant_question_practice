/* =========================================================================
   Exercise 3: Delete a Stored Procedure
   Goal: Delete the sp_InsertEmployee procedure created in Exercise 1.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_InsertEmployee;
GO

-- Verify it no longer exists (returns no rows if successfully dropped)
SELECT name FROM sys.procedures WHERE name = 'sp_InsertEmployee';
GO
