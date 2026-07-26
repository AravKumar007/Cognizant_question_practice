/* =========================================================================
   Exercise 11: Handle Errors in a Stored Procedure
   Goal: sp_UpdateEmployeeSalary_Safe - update salary with TRY...CATCH
         and a custom error message on failure.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_UpdateEmployeeSalary_Safe', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_UpdateEmployeeSalary_Safe;
GO

CREATE PROCEDURE dbo.sp_UpdateEmployeeSalary_Safe
    @EmployeeID INT,
    @NewSalary  DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        IF @NewSalary <= 0
            THROW 51000, 'Salary must be a positive value.', 1;

        UPDATE dbo.Employees
        SET Salary = @NewSalary
        WHERE EmployeeID = @EmployeeID;

        IF @@ROWCOUNT = 0
            THROW 51001, 'No employee found with the given EmployeeID.', 1;

        PRINT 'Salary updated successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Update failed: ' + ERROR_MESSAGE();
    END CATCH
END;
GO

-- Test: valid update
EXEC dbo.sp_UpdateEmployeeSalary_Safe @EmployeeID = 3, @NewSalary = 7200.00;

-- Test: invalid salary
EXEC dbo.sp_UpdateEmployeeSalary_Safe @EmployeeID = 3, @NewSalary = -100.00;

-- Test: non-existent employee
EXEC dbo.sp_UpdateEmployeeSalary_Safe @EmployeeID = 999, @NewSalary = 5000.00;
GO
