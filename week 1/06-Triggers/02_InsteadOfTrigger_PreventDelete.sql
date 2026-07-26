/* =========================================================================
   Exercise 2: Create an INSTEAD OF Trigger
   Goal: Prevent any row from being deleted from Employees.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.trg_PreventEmployeeDelete', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_PreventEmployeeDelete;
GO

CREATE TRIGGER dbo.trg_PreventEmployeeDelete
ON dbo.Employees
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;

    RAISERROR('Deleting employee records is not permitted. Consider a status flag instead.', 16, 1);
END;
GO

-- Test: this DELETE will be blocked by the trigger
DELETE FROM dbo.Employees WHERE EmployeeID = 4;

-- Confirm the row is still there
SELECT * FROM dbo.Employees WHERE EmployeeID = 4;
GO
