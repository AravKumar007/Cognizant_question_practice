/* =========================================================================
   Question 5: Logging All Errors in a Transaction
   Goal: BatchInsertEmployees inserts several employees as one atomic unit -
         if any insert fails, roll back everything and log the error.
   ========================================================================= */

USE EmployeeManagementDB;
GO

-- A simple table type to pass in a batch of employees to insert
IF TYPE_ID('dbo.EmployeeBatchType') IS NOT NULL
    DROP TYPE dbo.EmployeeBatchType;
GO

CREATE TYPE dbo.EmployeeBatchType AS TABLE (
    EmployeeID   INT,
    FirstName    VARCHAR(50),
    LastName     VARCHAR(50),
    Email        VARCHAR(100),
    Salary       DECIMAL(10,2),
    DepartmentID INT
);
GO

IF OBJECT_ID('dbo.BatchInsertEmployees', 'P') IS NOT NULL
    DROP PROCEDURE dbo.BatchInsertEmployees;
GO

CREATE PROCEDURE dbo.BatchInsertEmployees
    @Employees dbo.EmployeeBatchType READONLY
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID, JoinDate)
        SELECT EmployeeID, FirstName, LastName, Email, Salary, DepartmentID, GETDATE()
        FROM @Employees;

        COMMIT TRANSACTION;
        PRINT 'Batch insert succeeded - all employees added.';
    END TRY
    BEGIN CATCH
        IF XACT_STATE() <> 0
            ROLLBACK TRANSACTION;

        INSERT INTO dbo.AuditLog (Action, ErrorMessage)
        VALUES ('BatchInsertEmployees', ERROR_MESSAGE());

        PRINT 'Batch insert rolled back - error has been logged.';
        THROW;
    END CATCH
END;
GO

-- Test: all rows succeed together
DECLARE @GoodBatch dbo.EmployeeBatchType;
INSERT INTO @GoodBatch VALUES
    (10, 'Neha',  'Kapoor', 'neha.kapoor@example.com', 5200.00, 1),
    (11, 'Arjun', 'Menon',  'arjun.menon@example.com', 6400.00, 2);

EXEC dbo.BatchInsertEmployees @Employees = @GoodBatch;

-- Test: one row has a duplicate email - the WHOLE batch rolls back, not just that row
BEGIN TRY
    DECLARE @BadBatch dbo.EmployeeBatchType;
    INSERT INTO @BadBatch VALUES
        (12, 'Kabir', 'Singh', 'kabir.singh@example.com', 5300.00, 3),
        (13, 'Rina',  'Shah',  'neha.kapoor@example.com', 5400.00, 1);  -- duplicate email

    EXEC dbo.BatchInsertEmployees @Employees = @BadBatch;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

-- EmployeeID 12 should NOT be present - the whole batch rolled back
SELECT * FROM dbo.Employees WHERE EmployeeID IN (10, 11, 12, 13);
SELECT * FROM dbo.AuditLog;
GO
