CREATE DATABASE WebPrograming
USE WebPrograming

CREATE TABLE Users (
    User_ID INT PRIMARY KEY IDENTITY(1,1),
    User_name NVARCHAR(50) NOT NULL UNIQUE,
    Password NVARCHAR(255) NOT NULL,
    Full_Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    DOB DATE,
    Phone NVARCHAR(15),
    Role NVARCHAR(20) DEFAULT 'Customer', 
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Products (
    Product_ID INT PRIMARY KEY IDENTITY(1,1),
    Product_Name NVARCHAR(100) NOT NULL,
    Category_Name NVARCHAR(100) NOT NULL,
    Price DECIMAL(10,2) NOT NULL,
    Stock_Quantity INT NOT NULL,
	Description NVARCHAR(255) NOT NULL,
	Image NVARCHAR(255),
    Created_At DATETIME DEFAULT GETDATE()
);

CREATE TABLE ProductReviews (
    Review_ID INT PRIMARY KEY IDENTITY(1,1),
    Product_ID INT NOT NULL,
    User_ID INT, -- nếu bạn có bảng người dùng, đây sẽ là khóa ngoại liên kết
    Rate DECIMAL(3,1) NOT NULL,  -- ví dụ: 4.5
    Comment NVARCHAR(255),
    Created_At DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (Product_ID) REFERENCES Products(Product_ID)
);


CREATE TABLE Orders (
    Order_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL FOREIGN KEY REFERENCES Users(User_ID),
    Order_Date DATETIME DEFAULT GETDATE(),
    Total_Amount DECIMAL(10,2) NOT NULL,
    Order_Status NVARCHAR(50) DEFAULT 'Pending', -- 'Pending', 'Shipped', 'Delivered', 'Cancelled'
	Payment_Status NVARCHAR(50) DEFAULT 'Unpaid', --'Paid', 'Unpaid'
    Address NVARCHAR(255) NOT NULL,  
);

-- Bảng giỏ hàng
CREATE TABLE Shopping_Cart (
    Cart_ID INT PRIMARY KEY IDENTITY(1,1),
    User_ID INT NOT NULL FOREIGN KEY REFERENCES Users(User_ID),
    Total_Amount DECIMAL(10,2) NOT NULL 
);

-- Bảng chi tiết giỏ hàng
CREATE TABLE Shopping_Cart_Details (
    Cart_Details_ID INT PRIMARY KEY IDENTITY(1,1),
    Cart_ID INT NOT NULL FOREIGN KEY REFERENCES Shopping_Cart(Cart_ID),
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Products(Product_ID),
    Quantity INT NOT NULL ,
    Price DECIMAL(10,2) NOT NULL ,
    Total_Amount DECIMAL(10,2) NOT NULL 
);

-- Bảng chi tiết đơn hàng
CREATE TABLE OrderDetails (
    Order_Detail_ID INT PRIMARY KEY IDENTITY(1,1),
    Order_ID INT FOREIGN KEY REFERENCES Orders(Order_ID),
    Cart_ID INT FOREIGN KEY (Cart_ID) REFERENCES Shopping_Cart(Cart_ID),
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Products(Product_ID),
    Quantity INT NOT NULL ,
    Unit_Price DECIMAL(10,2) NOT NULL 
);

-- Bảng nhà cung cấp
CREATE TABLE Suppliers (
    Supplier_ID INT PRIMARY KEY IDENTITY(1,1),
    Supplier_Name NVARCHAR(100) NOT NULL UNIQUE, -- Tên công ty cung cấp
    Contact_Name NVARCHAR(100), -- Tên người đại diện
    Phone NVARCHAR(20),
    Email NVARCHAR(100) UNIQUE,
    Address NVARCHAR(255)
);

CREATE TABLE Purchases (
    Purchase_ID INT PRIMARY KEY IDENTITY(1,1),
    Supplier_ID INT NOT NULL FOREIGN KEY REFERENCES Suppliers(Supplier_ID),
    User_ID INT NOT NULL FOREIGN KEY REFERENCES Users(User_ID), -- Người nhập hàng
    Purchase_Date DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) DEFAULT 'Pending' --'Pending', 'Completed', 'Cancelled'
);

CREATE TABLE PurchaseDetails (
    Purchase_Detail_ID INT PRIMARY KEY IDENTITY(1,1),
    Purchase_ID INT NOT NULL FOREIGN KEY REFERENCES Purchases(Purchase_ID),
    Product_ID INT NOT NULL FOREIGN KEY REFERENCES Products(Product_ID),
	CategoryName NVARCHAR(100) NOT NULL,
	Quantity INT NOT NULL ,
    Unit_Price DECIMAL(10,2) NOT NULL ,
    Total_Price DECIMAL(10,2) NOT NULL 
);