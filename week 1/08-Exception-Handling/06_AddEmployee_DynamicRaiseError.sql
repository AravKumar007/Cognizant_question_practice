/* =========================================================================
   Question 6: Dynamic RAISERROR with Severity and State
   Goal: Raise a warning (severity 10) for a suspiciously low salary, and a
         hard error (severity 16) for a negative salary.
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
        IF @Salary < 0
        BEGIN
            -- Severity 16: genuine error, batch stops, caught by CATCH
            RAISERROR('Salary cannot be negative (received %d).', 16, 1, @Salary);
            RETURN;
        END
        ELSE IF @Salary < 1000
        BEGIN
            -- Severity 10: informational warning only, execution continues
            RAISERROR('Warning: salary %d is unusually low for this role.', 10, 1, @Salary);
        END

        INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, Email, Salary, DepartmentID, JoinDate)
        VALUES (@EmployeeID, @FirstName, @LastName, @Email, @Salary, @DepartmentID, GETDATE());

        PRINT 'Employee added successfully.';
    END TRY
    BEGIN CATCH
        INSERT INTO dbo.AuditLog (Action, ErrorMessage)
        VALUES ('AddEmployee', ERROR_MESSAGE());

        THROW;
    END CATCH
END;
GO

-- Test: low salary - warning is raised, but the insert still goes through
EXEC dbo.AddEmployee 14, 'Farah', 'Ali', 'farah.ali@example.com', 800.00, 2;

-- Test: negative salary - hard error, insert is blocked and logged
BEGIN TRY
    EXEC dbo.AddEmployee 15, 'Tariq', 'Ahmed', 'tariq.ahmed@example.com', -500.00, 2;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

SELECT * FROM dbo.Employees WHERE EmployeeID IN (14, 15);
SELECT * FROM dbo.AuditLog;
GO
