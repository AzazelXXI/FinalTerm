DROP DATABASE WebPrograming
CREATE DATABASE WebPrograming
USE WebPrograming

SELECT * FROM Users;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderDetails;
SELECT * FROM Shopping_Cart;
SELECT * FROM Shopping_Cart_Details;
SELECT * FROM Suppliers;
SELECT * FROM Purchases;
SELECT * FROM PurchaseDetails;

-- Bảng Users phân Role
CREATE TABLE Users (
    User_ID INT PRIMARY KEY IDENTITY(1,1),
    User_Name NVARCHAR(50) NOT NULL UNIQUE,
    User_Password NVARCHAR(255) NOT NULL,
    User_FullName NVARCHAR(100) NOT NULL,
    User_Email NVARCHAR(100) NOT NULL UNIQUE,
    User_DOB DATE,
    User_Phone NVARCHAR(15),
    User_Role NVARCHAR(20) DEFAULT 'Customer', 
    User_CreatedAt DATETIME DEFAULT GETDATE()
);

-- Bảng sản phẩm
CREATE TABLE Products (
    Product_ID INT PRIMARY KEY IDENTITY(1,1),
    Product_Name NVARCHAR(100) NOT NULL,
    Product_CategoryName NVARCHAR(100) NOT NULL,
    Product_Price DECIMAL(10,2) NOT NULL,
    Product_StockQuantity INT NOT NULL,
	Product_Discount DECIMAL(5,2) DEFAULT 0,
	Product_Desc VARCHAR(MAX),
	Product_Image VARCHAR(100),
    Product_Created_At DATETIME DEFAULT GETDATE()
);

-- Bảng đơn đặt của khách
CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL FOREIGN KEY REFERENCES Users(User_ID),
    Order_Date DATETIME DEFAULT GETDATE(),
    Order_TotalAmount DECIMAL(10,2) NOT NULL,
    Order_Status NVARCHAR(50) DEFAULT 'Pending', -- 'Pending', 'Shipped', 'Delivered', 'Cancelled'
	Order_PaymentStatus NVARCHAR(50) DEFAULT 'Unpaid', --'Paid', 'Unpaid'
    Order_Address NVARCHAR(255) NOT NULL,  
);

-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetails (
    OrderDetail_ID INT PRIMARY KEY IDENTITY(1,1),
    Order_ID INT FOREIGN KEY REFERENCES Orders(Order_ID),
    Cart_ID INT FOREIGN KEY (Cart_ID) REFERENCES Shopping_Cart(Cart_ID),
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Products(Product_ID),
    OrderDetail_Quantity INT NOT NULL ,
    OrderDetail_Unit_Price DECIMAL(10,2) NOT NULL 
);

-- Bảng giỏ hàng
CREATE TABLE Shopping_Cart (
    Cart_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL FOREIGN KEY REFERENCES Users(User_ID),
    Cart_TotalAmount DECIMAL(10,2) NOT NULL 
);

-- Bảng chi tiết giỏ hàng
CREATE TABLE Shopping_Cart_Details (
    CartDetails_ID INT PRIMARY KEY IDENTITY(1,1),
    Cart_ID INT NOT NULL FOREIGN KEY REFERENCES Shopping_Cart(Cart_ID),
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Products(Product_ID),
    CartDetails_Quantity INT NOT NULL ,
    CartDetails_Price DECIMAL(10,2) NOT NULL ,
    CartDetails_TotalAmount DECIMAL(10,2) NOT NULL 
);

-- Bảng nhà cung cấp
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY IDENTITY(1,1),
    Supplier_CompanyName NVARCHAR(100) NOT NULL UNIQUE, -- Tên công ty cung cấp
    Supplier_CongtactName NVARCHAR(100), -- Tên người đại diện
    Supplier_Phone NVARCHAR(20),
    Supplier_Email NVARCHAR(100) UNIQUE,
    Supplier_Address NVARCHAR(255)
);

-- Bảng nhập hàng
CREATE TABLE Purchases (
    Purchase_ID INT PRIMARY KEY IDENTITY(1,1),
    Supplier_ID INT NOT NULL FOREIGN KEY REFERENCES Suppliers(Supplier_ID),
    User_ID INT NOT NULL FOREIGN KEY REFERENCES Users(User_ID), -- Người nhập hàng
    Purchase_Date DATETIME DEFAULT GETDATE(),
    Purchase_Status NVARCHAR(50) DEFAULT 'Pending' --'Pending', 'Completed', 'Cancelled'
);

-- Bảng chi tiết đơn hàng đã nhập
CREATE TABLE PurchaseDetails (
    PurchaseDetail_ID INT PRIMARY KEY IDENTITY(1,1),
    Purchase_ID INT NOT NULL FOREIGN KEY REFERENCES Purchases(Purchase_ID),
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Products(Product_ID),
	PurchaseDetail_CategoryName NVARCHAR(100) NOT NULL,
	PurchaseDetail_Quantity INT NOT NULL ,
    PurchaseDetail_Unit_Price DECIMAL(10,2) NOT NULL ,
    PurchaseDetail_Total_Price DECIMAL(10,2) NOT NULL 
);

-- Bảng tin tức
CREATE TABLE News (
	News_Content VARCHAR(MAX),
	News_CreatedAt DATETIME DEFAULT GETDATE()
);