/* =========================================================================
   Exercise 1: Create a Stored Procedure
   Goal: sp_InsertEmployee - inserts a new employee row.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_InsertEmployee', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_InsertEmployee;
GO

CREATE PROCEDURE dbo.sp_InsertEmployee
    @FirstName    VARCHAR(50),
    @LastName     VARCHAR(50),
    @DepartmentID INT,
    @Salary       DECIMAL(10,2),
    @JoinDate     DATE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate)
    VALUES (
        (SELECT ISNULL(MAX(EmployeeID), 0) + 1 FROM dbo.Employees),
        @FirstName, @LastName, @DepartmentID, @Salary, @JoinDate
    );
END;
GO

-- Test
EXEC dbo.sp_InsertEmployee
    @FirstName = 'Ravi',
    @LastName = 'Kumar',
    @DepartmentID = 3,
    @Salary = 6200.00,
    @JoinDate = '2024-06-01';

SELECT * FROM dbo.Employees ORDER BY EmployeeID;
GO
