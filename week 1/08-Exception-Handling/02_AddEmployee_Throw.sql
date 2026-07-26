/* =========================================================================
   Question 2: Using THROW to Re-raise Errors
   Goal: Log the error in AuditLog, then re-raise it with THROW so the
         calling application still finds out something went wrong.
   ========================================================================= */

USE EmployeeManagementDB;
GO

ALTER PROCEDURE dbo.AddEmployee
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

        THROW;  -- re-raises the original error to the caller after logging it
    END CATCH
END;
GO

-- Test: this will insert fine
EXEC dbo.AddEmployee 7, 'Meera', 'Pillai', 'meera.pillai@example.com', 5900.00, 3;

-- Test: duplicate email - caller will see the error bubble up, not just silence
BEGIN TRY
    EXEC dbo.AddEmployee 8, 'Vikram', 'Rao', 'meera.pillai@example.com', 6000.00, 3;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

SELECT * FROM dbo.AuditLog;
GO
