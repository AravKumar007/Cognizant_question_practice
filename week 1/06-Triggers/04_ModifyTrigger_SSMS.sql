/* =========================================================================
   Exercise 4: Modify a Trigger using SSMS
   Goal: Walk through editing an existing trigger's logic in SSMS.

   This exercise is a UI workflow rather than a new script, but the SQL
   below is exactly what you'd type into the "Modify" editor SSMS opens.
   ========================================================================= */

/*
   SSMS steps:
   1. Object Explorer -> Databases -> EmployeeManagementDB -> Tables ->
      dbo.Employees -> Triggers -> trg_LogSalaryChange -> right-click -> Modify.
   2. SSMS opens the trigger's ALTER TRIGGER script in a new query tab.
   3. Edit the body, then execute (F5) to save the change.
*/

USE EmployeeManagementDB;
GO

-- Example modification: also capture WHO made the change using SYSTEM_USER,
-- and widen the log to flag suspiciously large single-update jumps.
ALTER TABLE dbo.EmployeeChanges
    ADD ChangedBy VARCHAR(100) NULL;
GO

ALTER TRIGGER dbo.trg_LogSalaryChange
ON dbo.Employees
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.EmployeeChanges (EmployeeID, OldSalary, NewSalary, ChangedBy)
    SELECT
        i.EmployeeID,
        d.Salary,
        i.Salary,
        SYSTEM_USER
    FROM inserted i
    JOIN deleted d ON d.EmployeeID = i.EmployeeID
    WHERE i.Salary <> d.Salary;
END;
GO

-- Test
UPDATE dbo.Employees SET Salary = Salary + 100 WHERE EmployeeID = 2;
SELECT * FROM dbo.EmployeeChanges;
GO
