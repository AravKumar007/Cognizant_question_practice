/* =========================================================================
   Question 4: Nested TRY...CATCH with RAISERROR
   Goal: TransferEmployee updates an employee's department; if the target
         department doesn't exist, raise a custom error, catch it in a
         nested block, log it, then re-raise it to the caller.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.TransferEmployee', 'P') IS NOT NULL
    DROP PROCEDURE dbo.TransferEmployee;
GO

CREATE PROCEDURE dbo.TransferEmployee
    @EmployeeID      INT,
    @NewDepartmentID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRY
            IF NOT EXISTS (SELECT 1 FROM dbo.Departments WHERE DepartmentID = @NewDepartmentID)
            BEGIN
                RAISERROR('Department %d does not exist.', 16, 1, @NewDepartmentID);
            END

            UPDATE dbo.Employees
            SET DepartmentID = @NewDepartmentID
            WHERE EmployeeID = @EmployeeID;

            IF @@ROWCOUNT = 0
                RAISERROR('Employee %d was not found.', 16, 1, @EmployeeID);

        END TRY
        BEGIN CATCH
            -- Inner catch: log the failure, then re-raise to the outer block
            INSERT INTO dbo.AuditLog (Action, ErrorMessage)
            VALUES ('TransferEmployee', ERROR_MESSAGE());

            THROW;
        END CATCH
    END TRY
    BEGIN CATCH
        -- Outer catch: final safety net, surfaces the error to the caller
        PRINT 'Transfer failed: ' + ERROR_MESSAGE();
        THROW;
    END CATCH
END;
GO

-- Test: valid transfer
EXEC dbo.TransferEmployee @EmployeeID = 1, @NewDepartmentID = 3;
SELECT * FROM dbo.Employees WHERE EmployeeID = 1;

-- Test: non-existent department - caught, logged, and re-raised
BEGIN TRY
    EXEC dbo.TransferEmployee @EmployeeID = 1, @NewDepartmentID = 99;
END TRY
BEGIN CATCH
    PRINT 'Caller received: ' + ERROR_MESSAGE();
END CATCH
GO

SELECT * FROM dbo.AuditLog;
GO
