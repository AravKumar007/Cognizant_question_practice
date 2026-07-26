/* =========================================================================
   Exercise 7: Return Data from a Scalar Function
   Goal: Annual salary for EmployeeID = 1.
   ========================================================================= */

USE EmployeeManagementDB;
GO

SELECT
    EmployeeID,
    FirstName,
    LastName,
    dbo.fn_CalculateAnnualSalary(Salary) AS AnnualSalary
FROM dbo.Employees
WHERE EmployeeID = 1;
GO
