USE AdventureWorks2022;
GO

SELECT *
FROM sys.Tables;


--Tạo View
--1: Lấy thông tin sản phẩm có giá bán lớn hơn 100 từ bảng
--Thông tin gồm ID, tên, số lượng sản phẩm, giá chính thức, số lượng, Thực Giá
CREATE VIEW SANPHAMCOGIALONHON100 AS
SELECT ProductID as MaSP, Name as TenSP, ProductNumber as SoLuongSP, ListPrice as ThucGia
FROM Production.Product
WHERE ListPrice > 100;
go

SELECT * FROM SANPHAMCOGIALONHON100;


--Tìm kiếm sản phẩm nhập vào màu hoặc ID.
--Thông tin gồm id sản phẩm ,tên ,số sản phẩm ,màu sắc, ngày bắt đầu bán,ngày kết thúc bán
CREATE VIEW TIMSANPHAMTHEOMAU as
select ProductID as Masp, Name as Tensp ,ProductNumber as SoLuongSP ,Color as Mausac ,SellStartDate as Ngayban, SellEndDate as Ngayketthuc
from Production.Product
go

select * from TIMSANPHAMTHEOMAU;

select *
from TIMSANPHAMTHEOMAU
where Mausac = '' or MaSP = '707';


--3: Lấy thông tin sản phẩm theo danh mục con hoặc ID và số lượng tồn kho trên 50
CREATE VIEW LAYTHONGTINSANPHAM AS
SELECT p.ProductID as MaSP, p.Name as TenSP, ps.Name AS Danhmuccon, pi.Quantity as SoLuong
FROM Production.Product p
JOIN Production.ProductSubcategory ps ON p.ProductSubcategoryID = ps.ProductSubcategoryID
JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
WHERE pi.Quantity > 50;

SELECT * FROM LAYTHONGTINSANPHAM;

SELECT * 
FROM LAYTHONGTINSANPHAM
WHERE Danhmuccon = '' or MaSP = '808';

--4: Lấy thông tin sản phẩm theo vị trí tồn kho, danh mục và số lượng tồn kho lớn hơn 100
CREATE VIEW ProductLocationInventory AS
SELECT p.ProductID as MaSP, p.Name as TenSP, l.Name AS ViTriTen, pi.Quantity as SoLuong
FROM Production.Product p
JOIN Production.ProductInventory pi ON p.ProductID = pi.ProductID
JOIN Production.Location l ON pi.LocationID = l.LocationID
WHERE pi.Quantity > 100;

select * from ProductLocationInventory;

Select * 
from ProductLocationInventory
where TenSP = 'Adjustable Race';

EXEC sp_help 'ProductLocationInventory';  --Kiểm Tra cột


--5: cập nhật hiển thị thông tin sản phẩm có giá bán lớn hơn 100.
CREATE VIEW UpdateProductInventory AS
SELECT p.ProductID as MaSP, p.Name as TenSP, p.ListPrice as ThucGia, p.StandardCost as ChiPhiChuan, pi.Quantity as SoLuong
FROM Production.Product p
JOIN Production.ProductInventory pi 
ON p.ProductID = pi.ProductID
WHERE p.ListPrice > 100;

UPDATE Production.Product--Thực hiện thao tác trực tiếp trên bảng Product thay vì view.
SET ListPrice = ListPrice * 1.1 -- Tăng giá 10%
WHERE ProductID = 1;

SELECT * 
FROM UpdateProductInventory
where

--Cho xem tất cả sản phảm có màu theo yêu cầu .
--Thông tin gồm id sản phẩm ,tên ,số sản phẩm ,màu sắc, ngày bắt đầu bán,ngày kết thúc bán
create view TimSanPhamTheoMau as
select ProductID as Masp, Name as Tensp ,ProductNumber as Sosp ,Color as mausac ,SellStartDate as Ngaymoban ,
SellEndDate as Ngayketthucban
from Production.Product
where Color = 'red'
go
select *from TimSanPhamTheoMau

--================================================================================================
--Trigger:
--1: tự động ghi lại thông tin khi một sản phẩm mới được thêm vào bảng 
CREATE TRIGGER trg_AfterInsert_Product
ON Production.Product
AFTER INSERT
AS
BEGIN
    INSERT INTO Audit.ProductAudit (ProductID, Action, ActionDate)
    SELECT ProductID, 'INSERT', GETDATE()
    FROM inserted;
END;
GO

SELECT * FROM Production.Product WHERE Name = 'New Product';


--2 Tạo trigger tự động cập nhật giá trị "DiscountPct" (giảm giá) dựa trên điều kiện cụ thể khi có một bảng ghi mới được chèn vào
CREATE TRIGGER trgInsert_SpecialOffer_UpdateDiscount
ON Sales.SpecialOffer
AFTER INSERT
AS
BEGIN
SET NOCOUNT ON;
-- Cập nhật DiscountPct cho các bản ghi mới chèn vào
UPDATE so SET so.DiscountPct = CASE 
WHEN i.Category = 'Reseller' THEN 0.15
WHEN i.Category = 'Customer' THEN 0.1
ELSE so.DiscountPct
END
FROM Sales.SpecialOffer so INNER JOIN inserted i ON so.SpecialOfferID = i.SpecialOfferID;
END;

SELECT * FROM Sales.SpecialOffer 

SELECT * 
FROM Sales.SpecialOffer 
WHERE Category = N'Reseller' OR Category = N'Costumer';



--=================================================================================================

--Transaction
--Tạo transaction xử lý lỗi nếu có, và hiển thị thông báo tương ứng.
BEGIN TRANSACTION;
BEGIN TRY
-- Thêm sản phẩm mới
INSERT INTO Production.Product (Name, ListPrice, StandardCost, FinishedGoodsFlag) VALUES ('New Product', 150.00, 100.00, 1);
-- Cập nhật tồn kho cho sản phẩm vừa thêm
DECLARE @NewProductID INT;
SELECT @NewProductID = SCOPE_IDENTITY(); -- Lấy ID của sản phẩm mới
INSERT INTO Production.ProductInventory (ProductID, LocationID, Quantity) VALUES (@NewProductID, 1, 50); -- Thêm 50 sản phẩm vào vị trí 1
-- Cam kết transaction
COMMIT TRANSACTION;
END TRY
BEGIN CATCH
-- Rollback nếu có lỗi
ROLLBACK TRANSACTION;
-- Hiển thị lỗi
PRINT ERROR_MESSAGE();
END CATCH;




-- Tạo transaction cập nhật gái trị "DiscountPct" - 'Khách hàng' của các bản ghi có "Category" - 'Loại' là "Reseller" - 'Người bán lại' và chèn một bản ghi mới vào bảng "Sales.SpecialOffer" - 'Bán hàng. Uuw đãi đặc biệt'
BEGIN TRANSACTION;
UPDATE Sales.SpecialOffer
SET DiscountPct = 0.2
WHERE Category = 'Reseller';

INSERT INTO Sales.SpecialOffer (Description, DiscountPct, Type, Category, StartDate, EndDate, MinQty, MaxQty)
VALUES ('New Offer', 0.15, 'Discount', 'Customer', '2023-12-03', '2023-12-10', 1, 10);

-- Kiểm tra điều kiện và quyết định có commit hay rollback transaction
IF @@ERROR = 0
BEGIN
    COMMIT;
    PRINT 'Transaction committed successfully.';
END
ELSE
BEGIN
    ROLLBACK;
    PRINT 'Transaction rolled back due to an error.';
END

