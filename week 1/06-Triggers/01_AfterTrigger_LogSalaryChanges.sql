/* =========================================================================
   Exercise 1: Create an AFTER Trigger
   Goal: Log every salary update on Employees into EmployeeChanges.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.EmployeeChanges', 'U') IS NOT NULL DROP TABLE dbo.EmployeeChanges;
GO

CREATE TABLE dbo.EmployeeChanges (
    ChangeID    INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID  INT NOT NULL,
    OldSalary   DECIMAL(10,2) NOT NULL,
    NewSalary   DECIMAL(10,2) NOT NULL,
    ChangedAt   DATETIME NOT NULL DEFAULT GETDATE()
);
GO

IF OBJECT_ID('dbo.trg_LogSalaryChange', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_LogSalaryChange;
GO

CREATE TRIGGER dbo.trg_LogSalaryChange
ON dbo.Employees
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Only log rows where Salary actually changed
    INSERT INTO dbo.EmployeeChanges (EmployeeID, OldSalary, NewSalary)
    SELECT
        i.EmployeeID,
        d.Salary AS OldSalary,
        i.Salary AS NewSalary
    FROM inserted i
    JOIN deleted d ON d.EmployeeID = i.EmployeeID
    WHERE i.Salary <> d.Salary;
END;
GO

-- Test
UPDATE dbo.Employees SET Salary = Salary + 200 WHERE EmployeeID = 1;

SELECT * FROM dbo.EmployeeChanges;
GO
