/* =========================================================================
   Online Retail Store - Schema & Sample Data
   Used by Exercise 1: Ranking, Aggregation, CTE/MERGE, PIVOT/UNPIVOT
   ========================================================================= */

IF DB_ID('OnlineRetailStoreDB') IS NULL
BEGIN
    CREATE DATABASE OnlineRetailStoreDB;
END
GO

USE OnlineRetailStoreDB;
GO

-- Drop in dependency order if re-running this script
IF OBJECT_ID('dbo.OrderDetails', 'U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID('dbo.Orders', 'U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.Products', 'U') IS NOT NULL DROP TABLE dbo.Products;
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers (
    CustomerID INT PRIMARY KEY,
    Name       VARCHAR(100) NOT NULL,
    Region     VARCHAR(50)  NOT NULL
);

CREATE TABLE dbo.Products (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100) NOT NULL,
    Category    VARCHAR(50)  NOT NULL,
    Price       DECIMAL(10,2) NOT NULL
);

CREATE TABLE dbo.Orders (
    OrderID    INT PRIMARY KEY,
    CustomerID INT NOT NULL FOREIGN KEY REFERENCES dbo.Customers(CustomerID),
    OrderDate  DATE NOT NULL
);

CREATE TABLE dbo.OrderDetails (
    OrderDetailID INT PRIMARY KEY,
    OrderID       INT NOT NULL FOREIGN KEY REFERENCES dbo.Orders(OrderID),
    ProductID     INT NOT NULL FOREIGN KEY REFERENCES dbo.Products(ProductID),
    Quantity      INT NOT NULL
);
GO

-- ---------- Sample data ----------

INSERT INTO dbo.Customers (CustomerID, Name, Region) VALUES
(1, 'Aditi Sharma',  'North'),
(2, 'Rohan Mehta',   'South'),
(3, 'Priya Nair',    'West'),
(4, 'Karan Verma',   'East'),
(5, 'Sneha Iyer',    'North'),
(6, 'Farhan Khan',   'South');

INSERT INTO dbo.Products (ProductID, ProductName, Category, Price) VALUES
(1, 'Wireless Mouse',      'Electronics', 799.00),
(2, 'Mechanical Keyboard', 'Electronics', 3499.00),
(3, '27-inch Monitor',     'Electronics', 12999.00),
(4, 'Noise Cancelling Headphones', 'Electronics', 5999.00),
(5, 'Office Chair',        'Furniture',   7499.00),
(6, 'Standing Desk',       'Furniture',   15999.00),
(7, 'Bookshelf',           'Furniture',   4499.00),
(8, 'Notebook Pack',       'Stationery',  199.00),
(9, 'Gel Pen Set',         'Stationery',  99.00),
(10, 'Sticky Notes Combo', 'Stationery',  149.00);

INSERT INTO dbo.Orders (OrderID, CustomerID, OrderDate) VALUES
(1, 1, '2025-01-03'),
(2, 2, '2025-01-05'),
(3, 1, '2025-01-10'),
(4, 3, '2025-01-12'),
(5, 4, '2025-01-15'),
(6, 5, '2025-01-18'),
(7, 1, '2025-01-20'),
(8, 6, '2025-01-22'),
(9, 2, '2025-01-25'),
(10, 3, '2025-01-28');

INSERT INTO dbo.OrderDetails (OrderDetailID, OrderID, ProductID, Quantity) VALUES
(1,  1, 1, 2),
(2,  1, 8, 5),
(3,  2, 5, 1),
(4,  3, 2, 1),
(5,  3, 9, 3),
(6,  4, 6, 1),
(7,  5, 3, 1),
(8,  6, 4, 2),
(9,  7, 7, 1),
(10, 8, 10, 4),
(11, 9, 1, 1),
(12, 9, 8, 2),
(13, 10, 2, 1),
(14, 10, 3, 1);
GO
