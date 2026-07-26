/* =========================================================================
   Exercise 6: Execute a User-Defined Function
   Goal: Run fn_CalculateAnnualSalary for every employee.
   ========================================================================= */

USE EmployeeManagementDB;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    Salary,
    dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM dbo.Employees
ORDER BY EmployeeID;
GO
