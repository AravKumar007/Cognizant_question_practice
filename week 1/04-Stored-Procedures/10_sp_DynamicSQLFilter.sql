/* =========================================================================
   Exercise 10: Use Dynamic SQL in a Stored Procedure
   Goal: sp_GetEmployeesByFilter - retrieve employees filtered by any
         column/value pair chosen at call time.
   ========================================================================= */

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.sp_GetEmployeesByFilter', 'P') IS NOT NULL
    DROP PROCEDURE dbo.sp_GetEmployeesByFilter;
GO

CREATE PROCEDURE dbo.sp_GetEmployeesByFilter
    @FilterColumn VARCHAR(50),
    @FilterValue  VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    -- Whitelist the columns that are allowed to be filtered on, to avoid
    -- SQL injection through @FilterColumn.
    DECLARE @AllowedColumns TABLE (ColumnName VARCHAR(50));
    INSERT INTO @AllowedColumns VALUES
        ('FirstName'), ('LastName'), ('DepartmentID'), ('Salary');

    IF NOT EXISTS (SELECT 1 FROM @AllowedColumns WHERE ColumnName = @FilterColumn)
    BEGIN
        RAISERROR('Filtering by column "%s" is not allowed.', 16, 1, @FilterColumn);
        RETURN;
    END

    DECLARE @Sql NVARCHAR(MAX);
    SET @Sql = N'SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate
                  FROM dbo.Employees
                  WHERE ' + QUOTENAME(@FilterColumn) + N' = @FilterValueParam';

    EXEC sp_executesql
        @Sql,
        N'@FilterValueParam VARCHAR(100)',
        @FilterValueParam = @FilterValue;
END;
GO

-- Test
EXEC dbo.sp_GetEmployeesByFilter @FilterColumn = 'DepartmentID', @FilterValue = '3';
EXEC dbo.sp_GetEmployeesByFilter @FilterColumn = 'LastName', @FilterValue = 'Smith';
GO
