/* =========================================================================
   Exercise 8: Create a Stored Procedure with Conditional Logic
   Goal: sp_GiveBonus - give a bonus to every employee in a department.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_GiveBonus', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_GiveBonus;
GO

CREATE PROCEDURE dbo.sp_GiveBonus
    @DepartmentID INT,
    @BonusAmount  DECIMAL(10,2)
AS
BEGIN
    SET NOCOUNT ON;

    -- Only apply the bonus if the department actually has employees
    IF EXISTS (SELECT 1 FROM dbo.Employees WHERE DepartmentID = @DepartmentID)
    BEGIN
        UPDATE dbo.Employees
        SET Salary = Salary + @BonusAmount
        WHERE DepartmentID = @DepartmentID;

        PRINT 'Bonus applied to department ' + CAST(@DepartmentID AS VARCHAR(10));
    END
    ELSE
    BEGIN
        PRINT 'No employees found in department ' + CAST(@DepartmentID AS VARCHAR(10));
    END
END;
GO

-- Test
EXEC dbo.sp_GiveBonus 1, 500.00;

SELECT * FROM dbo.Employees WHERE DepartmentID = 1;
GO
