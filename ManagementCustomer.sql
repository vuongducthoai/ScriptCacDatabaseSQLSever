CREATE DATABASE ManagementCustomer
USE ManagementCustomer


CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY IDENTITY(1,1), 
    Name NVARCHAR(100) NOT NULL,              
    Address NVARCHAR(255),                   
    Phone NVARCHAR(15),                        
    Email NVARCHAR(100)                        
);


CREATE TABLE [Order] (
    OrderID INT PRIMARY KEY IDENTITY(1,1),    
    OrderDate DATE NOT NULL,                  
    OrderMethod NVARCHAR(50),                  
    BuyerUnit NVARCHAR(100),                   
    Representative NVARCHAR(100),             
    CustomerAddress NVARCHAR(255),             
    Phone NVARCHAR(15),                        
    Email NVARCHAR(100),                      
    CustomerID INT,                            
    CONSTRAINT FK_Customer_Order FOREIGN KEY (CustomerID) 
        REFERENCES Customer(CustomerID)       
);



INSERT INTO Customer (Name, Address, Phone, Email) VALUES
('Nguyễn Văn A', '123 Đường 1, Quận 1, TP.HCM', '0901234567', 'nguyenvana@example.com'),
('Trần Thị B', '456 Đường 2, Quận 2, TP.HCM', '0912345678', 'tranthib@example.com'),
('Lê Văn C', '789 Đường 3, Quận 3, TP.HCM', '0923456789', 'levanc@example.com'),
('Phạm Thị D', '321 Đường 4, Quận 4, TP.HCM', '0934567890', 'phamthid@example.com'),
('Hoàng Văn E', '654 Đường 5, Quận 5, TP.HCM', '0945678901', 'hoangvane@example.com'),
('Nguyễn Thị F', '987 Đường 6, Quận 6, TP.HCM', '0956789012', 'nguyenthf@example.com'),
('Đỗ Văn G', '159 Đường 7, Quận 7, TP.HCM', '0967890123', 'dovang@example.com'),
('Vũ Thị H', '753 Đường 8, Quận 8, TP.HCM', '0978901234', 'vuthih@example.com'),
('Ngô Văn I', '951 Đường 9, Quận 9, TP.HCM', '0989012345', 'ngovanI@example.com'),
('Trương Thị J', '159 Đường 10, Quận 10, TP.HCM', '0990123456', 'truongthij@example.com');



INSERT INTO [Order] (OrderDate, OrderMethod, BuyerUnit, Representative, CustomerAddress, Phone, Email, CustomerID) VALUES
('2024-10-01', 'Gọi điện', 'Công ty A', 'Nguyễn Văn A', '123 Đường 1, Quận 1, TP.HCM', '0901234567', 'nguyenvana@example.com', 1),
('2024-10-02', 'Email', 'Công ty B', 'Trần Thị B', '456 Đường 2, Quận 2, TP.HCM', '0912345678', 'tranthib@example.com', 2),
('2024-10-03', 'Trực tiếp', 'Công ty C', 'Lê Văn C', '789 Đường 3, Quận 3, TP.HCM', '0923456789', 'levanc@example.com', 3),
('2024-10-04', 'Gọi điện', 'Công ty D', 'Phạm Thị D', '321 Đường 4, Quận 4, TP.HCM', '0934567890', 'phamthid@example.com', 4),
('2024-10-05', 'Email', 'Công ty E', 'Hoàng Văn E', '654 Đường 5, Quận 5, TP.HCM', '0945678901', 'hoangvane@example.com', 5),
('2024-10-06', 'Trực tiếp', 'Công ty F', 'Nguyễn Thị F', '987 Đường 6, Quận 6, TP.HCM', '0956789012', 'nguyenthf@example.com', 6),
('2024-10-07', 'Gọi điện', 'Công ty G', 'Đỗ Văn G', '159 Đường 7, Quận 7, TP.HCM', '0967890123', 'dovang@example.com', 7),
('2024-10-08', 'Email', 'Công ty H', 'Vũ Thị H', '753 Đường 8, Quận 8, TP.HCM', '0978901234', 'vuthih@example.com', 8),
('2024-10-09', 'Trực tiếp', 'Công ty I', 'Ngô Văn I', '951 Đường 9, Quận 9, TP.HCM', '0989012345', 'ngovanI@example.com', 9),
('2024-10-10', 'Gọi điện', 'Công ty J', 'Trương Thị J', '159 Đường 10, Quận 10, TP.HCM', '0990123456', 'truongthij@example.com', 10);
