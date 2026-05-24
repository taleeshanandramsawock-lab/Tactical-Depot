-- =============================================
-- TACTICAL DEPOT DATABASE
-- SQL Scripts for Table Creation
-- Student: Ramsawock and Hurdoyal
-- Module: Server-side Programming BCNS2103C
-- =============================================

-- Create Database
CREATE DATABASE IF NOT EXISTS tactical_depot;
USE tactical_depot;

-- =============================================
-- TABLE 1: Customers
-- Purpose: Store customer information
-- =============================================
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Address VARCHAR(255),
    DateRegistered DATE DEFAULT CURRENT_DATE
);

-- Insert sample customer data
INSERT INTO Customers (FirstName, LastName, Email, Phone, Address) VALUES
('John', 'Doe', 'john.doe@email.com', '57001234', 'Port Louis, Mauritius'),
('Jane', 'Smith', 'jane.smith@email.com', '57005678', 'Curepipe, Mauritius'),
('Mike', 'Johnson', 'mike.j@email.com', '57009012', 'Quatre Bornes, Mauritius'),
('Sarah', 'Williams', 'sarah.w@email.com', '57003456', 'Rose Hill, Mauritius');


-- =============================================
-- TABLE 2: Products
-- Purpose: Store tactical gear product catalog
-- =============================================
CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL,
    StockQuantity INT DEFAULT 0,
    Description TEXT,
    ProductImage VARCHAR(255)
);

-- Insert sample product data
INSERT INTO Products (ProductName, Category, Price, StockQuantity, Description, ProductImage) VALUES
('AK-47', 'Rifles', 15000.00, 10, 'Reliable and rugged. Ideal for any mission.', 'ak47.jpg'),
('Sniper Rifle', 'Rifles', 25000.00, 5, 'Precision long-range weapon for professionals.', 'sniper.jpg'),
('Tactical Pistol', 'Pistols', 8000.00, 20, 'Compact. Silent. Effective at close range.', 'pistol.jpg'),
('M-4 Carbine', 'Rifles', 18000.00, 8, 'Lightweight and versatile combat rifle.', 'm4carbine.jpg'),
('Ammo Box', 'Ammunition', 500.00, 50, 'High quality 5.56mm rounds.', 'ammo.jpg');


-- =============================================
-- TABLE 3: Orders
-- Purpose: Store customer orders
-- =============================================
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    TotalAmount DECIMAL(10, 2),
    OrderStatus VARCHAR(50) DEFAULT 'Pending',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Insert sample order data
INSERT INTO Orders (CustomerID, TotalAmount, OrderStatus) VALUES
(1, 15000.00, 'Completed'),
(2, 8000.00, 'Pending'),
(3, 25000.00, 'Shipped');


-- =============================================
-- TABLE 4: OrderDetails
-- Purpose: Store individual items in each order
-- =============================================
CREATE TABLE OrderDetails (
    OrderDetailID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT NOT NULL,
    ProductID INT NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Insert sample order details
INSERT INTO OrderDetails (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 1, 15000.00),
(2, 3, 1, 8000.00),
(3, 2, 1, 25000.00);


-- =============================================
-- TABLE 5: Employees
-- Purpose: Store employee/admin information
-- =============================================
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Email VARCHAR(100) NOT NULL UNIQUE,
    Password VARCHAR(255) NOT NULL,
    HireDate DATE DEFAULT CURRENT_DATE
);

-- Insert sample employee data
INSERT INTO Employees (FullName, Position, Email, Password) VALUES
('Admin User', 'Manager', 'admin@tacticaldepot.mu', 'admin123'),
('Staff Member', 'Sales', 'staff@tacticaldepot.mu', 'staff123');


