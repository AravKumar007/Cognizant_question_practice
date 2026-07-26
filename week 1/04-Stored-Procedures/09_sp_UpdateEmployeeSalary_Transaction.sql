/* =========================================================================
   Exercise 9: Use Transactions in a Stored Procedure
   Goal: sp_UpdateEmployeeSalary_Txn - update salary safely inside a
         transaction so a failure leaves no partial change.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_UpdateEmployeeSalary_Txn', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_UpdateEmployeeSalary_Txn;
GO

CREATE PROCEDURE dbo.sp_UpdateEmployeeSalary_Txn
    @EmployeeID INT,
    @NewSalary  DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;
    SET XACT_ABORT ON;  -- automatically rolls back on any runtime error

    BEGIN TRANSACTION;

    UPDATE dbo.Employees
    SET Salary = @NewSalary
    WHERE EmployeeID = @EmployeeID;

    IF @@ROWCOUNT = 0
    BEGIN
        ROLLBACK TRANSACTION;
        RAISERROR('No employee found with EmployeeID %d.', 16, 1, @EmployeeID);
        RETURN;
    END

    COMMIT TRANSACTION;
END;
GO

-- Test: successful update
EXEC dbo.sp_UpdateEmployeeSalary_Txn @EmployeeID = 2, @NewSalary = 6300.00;
SELECT * FROM dbo.Employees WHERE EmployeeID = 2;

-- Test: no matching employee - transaction rolls back cleanly
EXEC dbo.sp_UpdateEmployeeSalary_Txn @EmployeeID = 999, @NewSalary = 9999.00;
GO
