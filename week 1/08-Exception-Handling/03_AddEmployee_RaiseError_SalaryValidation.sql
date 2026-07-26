/* =========================================================================
   Question 3: Custom Error with RAISERROR
   Goal: Reject salaries that are zero or negative with a clear custom
         message, before attempting the insert at all.
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
        IF @Salary <= 0
        BEGIN
            RAISERROR('Salary must be greater than zero.', 16, 1);
            RETURN;
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

-- Test: invalid salary is rejected before any INSERT is attempted
BEGIN TRY
    EXEC dbo.AddEmployee 9, 'Deepak', 'Nair', 'deepak.nair@example.com', 0.00, 1;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

SELECT * FROM dbo.AuditLog;
GO
