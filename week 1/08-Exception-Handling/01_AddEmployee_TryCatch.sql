/* =========================================================================
   Question 1: Basic TRY...CATCH for Error Logging
   Goal: AddEmployee inserts a new employee; if the insert fails (e.g. a
         duplicate Email), catch the error and log it into AuditLog.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.AddEmployee', 'P') IS NOT NULL
    DROP PROCEDURE dbo.AddEmployee;
GO

CREATE PROCEDURE dbo.AddEmployee
    @EmployeeID   INT,
    @FirstName    VARCHAR(50),
    @LastName     VARCHAR(50),
    @Email        VARCHAR(100),
    @Salary       DECIMAL(10,2),
    @DepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID, JoinDate)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID, GETDATE());

        PRINT 'Employee added successfully.';
    END TRY
    BEGIN CATCH
        INSERT INTO dbo.AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());

        PRINT 'Failed to add employee - error has been logged.';
    END CATCH
END;
GO

-- Test: first insert succeeds
EXEC dbo.AddEmployee 5, 'Anita', 'Rao', 'anita.rao@example.com', 6100.00, 1;

-- Test: second insert with the same email violates the UNIQUE constraint,
-- gets caught, and logged instead of crashing the batch
EXEC dbo.AddEmployee 6, 'Sanjay', 'Gupta', 'anita.rao@example.com', 5800.00, 2;

SELECT * FROM dbo.AuditLog;
GO
