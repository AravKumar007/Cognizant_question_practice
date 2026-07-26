/* =========================================================================
   Employee Management System - Schema & Sample Data
   Used by Exercise 5 (Functions)
   NOTE: this exercise sheet numbers departments differently from the other
   folders (HR=1, IT=2, Finance=3), so it gets its own schema file.
   ========================================================================= */

IF DB_ID('EmployeeManagementDB') IS NULL
BEGIN
    CREATE DATABASE EmployeeManagementDB;
END
GO

USE EmployeeManagementDB;
GO

IF OBJECT_ID('dbo.Employees', 'U') IS NOT NULL DROP TABLE dbo.Employees;
IF OBJECT_ID('dbo.Departments', 'U') IS NOT NULL DROP TABLE dbo.Departments;
GO

CREATE TABLE dbo.Departments (
    DepartmentID   INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Employees (
    EmployeeID   INT PRIMARY KEY,
    FirstName    VARCHAR(50) NOT NULL,
    LastName     VARCHAR(50) NOT NULL,
    DepartmentID INT NOT NULL FOREIGN KEY REFERENCES dbo.Departments(DepartmentID),
    Salary       DECIMAL(10, 2) NOT NULL,
    JoinDate     DATE NOT NULL
);
GO

INSERT INTO dbo.Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');

INSERT INTO dbo.Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe',     1, 5000.00, '2020-01-15'),
(2, 'Jane', 'Smith',   2, 6000.00, '2019-03-22'),
(3, 'Bob',  'Johnson', 3, 5500.00, '2021-07-01');
