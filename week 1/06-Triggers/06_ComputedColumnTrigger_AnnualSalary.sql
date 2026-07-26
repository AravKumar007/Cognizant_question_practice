/* =========================================================================
   Exercise 6: Create a Trigger to Update a Computed Column
   Goal: Keep an AnnualSalary column on Employees in sync with Salary
         whenever Salary is updated (Salary * 12).
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF COL_LENGTH('dbo.Employees', 'AnnualSalary') IS NULL
BEGIN
    ALTER TABLE dbo.Employees ADD AnnualSalary DECIMAL(12,2) NULL;
END
GO

-- Backfill existing rows once, then let the trigger keep it in sync
UPDATE dbo.Employees SET AnnualSalary = Salary * 12;
GO

IF OBJECT_ID('dbo.trg_UpdateAnnualSalary', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_UpdateAnnualSalary;
GO

CREATE TRIGGER dbo.trg_UpdateAnnualSalary
ON dbo.Employees
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Guard against re-firing when only AnnualSalary itself is touched
    IF NOT UPDATE(Salary)
        RETURN;

    UPDATE e
    SET e.AnnualSalary = i.Salary * 12
    FROM dbo.Employees e
    JOIN inserted i ON i.EmployeeID = e.EmployeeID;
END;
GO

-- Test
UPDATE dbo.Employees SET Salary = 8000.00 WHERE EmployeeID = 3;

SELECT EmployeeID, Salary, AnnualSalary FROM dbo.Employees ORDER BY EmployeeID;
GO
