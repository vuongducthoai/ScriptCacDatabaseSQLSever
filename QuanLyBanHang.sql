CREATE DATABASE QuanLyBanHang
USE QuanLyBanHang

CREATE TABLE Employee (
    ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255),
    Salary DECIMAL(10, 2),
    HireDate DATE
);

CREATE TABLE Client (
    ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(20),
    Address VARCHAR(255)
);


CREATE TABLE Product (
    ID VARCHAR(10) PRIMARY KEY,
    Name VARCHAR(100),
    Description TEXT,
    Price DECIMAL(10, 2),
    Quantity INT
);



CREATE TABLE "Order" (
    ID VARCHAR(10) PRIMARY KEY,
    ClientID VARCHAR(10),
    EmployeeID VARCHAR(10),
    OrderDate DATE,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (ClientID) REFERENCES Client(ID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(ID)
);

CREATE TABLE OrderItem (
    ID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10),
    ProductID VARCHAR(10),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES "Order"(ID),
    FOREIGN KEY (ProductID) REFERENCES Product(ID)
);

CREATE TABLE Bill (
    ID VARCHAR(10) PRIMARY KEY,
    OrderID VARCHAR(10),
    ClientID VARCHAR(10),
    EmployeeID VARCHAR(10),
    BillDate DATE,
    TotalPrice DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES "Order"(ID),
    FOREIGN KEY (ClientID) REFERENCES Client(ID),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(ID)
);

CREATE TABLE Users (
    ID VARCHAR(10) PRIMARY KEY,   
    EmployeeID VARCHAR(10),
    Username VARCHAR(50) NOT NULL UNIQUE,   
    PasswordHash VARCHAR(255) NOT NULL,                              
    Role VARCHAR(50),
    FOREIGN KEY (EmployeeID) REFERENCES Employee(ID)
)




-- Thêm dữ liệu cho bảng Employee
INSERT INTO Employee (ID, Name, Email, Phone, Address, Salary, HireDate) VALUES
('E001', 'Nguyen Van A', 'a.nguyen@example.com', '0912345678', '123 Main St, Hanoi', 5000.00, '2021-01-01'),
('E002', 'Le Thi B', 'b.le@example.com', '0987654321', '456 Maple Rd, HCMC', 4500.00, '2022-03-15'),
('E003', 'Tran Van C', 'c.tran@example.com', '0932456789', '789 Elm St, Da Nang', 4800.00, '2023-06-10'),
('E004', 'Hoang D', 'd.hoang@example.com', '0921345678', '101 Pine Ave, Hue', 4700.00, '2021-09-01'),
('E005', 'Pham E', 'e.pham@example.com', '0912567890', '202 Willow St, Nha Trang', 5200.00, '2020-12-01');

-- Thêm dữ liệu cho bảng Client
INSERT INTO Client (ID, Name, Email, Phone, Address) VALUES
('C001', 'Nguyen K', 'k.nguyen@example.com', '0911111111', '321 Oak St, Hanoi'),
('C002', 'Le L', 'l.le@example.com', '0922222222', '654 Cedar Rd, HCMC'),
('C003', 'Tran M', 'm.tran@example.com', '0933333333', '987 Birch St, Da Nang'),
('C004', 'Hoang N', 'n.hoang@example.com', '0944444444', '121 Aspen Ave, Hue'),
('C005', 'Pham O', 'o.pham@example.com', '0955555555', '543 Palm St, Nha Trang');

-- Thêm dữ liệu cho bảng Product
INSERT INTO Product (ID, Name, Description, Price, Quantity) VALUES
('P001', 'Laptop', 'High performance laptop', 1500.00, 10),
('P002', 'Smartphone', 'Latest model smartphone', 800.00, 50),
('P003', 'Tablet', '10-inch display tablet', 300.00, 30),
('P004', 'Monitor', '24-inch HD monitor', 200.00, 20),
('P005', 'Keyboard', 'Mechanical keyboard', 50.00, 100);

-- Thêm dữ liệu cho bảng Users
INSERT INTO Users (ID, EmployeeID, Username, PasswordHash, Role) VALUES
('U001', 'E001', 'Admin', 'admin123', 'Admin'),
('U002', 'E002', 'john_doe', 'password1', 'Admin'),
('U003', 'E003', 'jane_smith', 'password2', 'Employee'),
('U004', 'E004', 'bob_brown', 'password3', 'Employee'),
('U005', 'E005', 'alice_green', 'password4', 'Employee');

-- Thêm dữ liệu cho bảng Order
INSERT INTO "Order" (ID, ClientID, EmployeeID, OrderDate, TotalPrice) VALUES
('O001', 'C001', 'E001', '2024-01-10', 3000.00),
('O002', 'C002', 'E002', '2024-02-20', 1500.00),
('O003', 'C003', 'E003', '2024-03-15', 800.00),
('O004', 'C004', 'E004', '2024-04-05', 1200.00),
('O005', 'C005', 'E005', '2024-05-10', 2000.00);

-- Thêm dữ liệu cho bảng OrderItem
INSERT INTO OrderItem (ID, OrderID, ProductID, Quantity) VALUES
('OI001', 'O001', 'P001', 1),
('OI002', 'O002', 'P002', 2),
('OI003', 'O003', 'P003', 1),
('OI004', 'O004', 'P004', 2),
('OI005', 'O005', 'P005', 4);

-- Thêm dữ liệu cho bảng Bill
INSERT INTO Bill (ID, OrderID, ClientID, EmployeeID, BillDate, TotalPrice) VALUES
('B001', 'O001', 'C001', 'E001', '2024-01-11', 3000.00),
('B002', 'O002', 'C002', 'E002', '2024-02-21', 1500.00),
('B003', 'O003', 'C003', 'E003', '2024-03-16', 800.00),
('B004', 'O004', 'C004', 'E004', '2024-04-06', 1200.00),
('B005', 'O005', 'C005', 'E005', '2024-05-11', 2000.00);
