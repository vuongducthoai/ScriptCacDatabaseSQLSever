
CREATE VIEW [dbo].[view_HighPriceProducts1]
AS
SELECT ProductID, Name, ListPrice
FROM Production.Product
WHERE ListPrice > 3000
GO

SELECT * FROM view_HighPriceProducts

Lấy các đơn hàng có OrderQty lớn hơn 5.

CREATE VIEW [dbo].[view_LargeOrders]
AS
SELECT SalesOrderID, ProductID, OrderQty, UnitPrice
FROM Sales.SalesOrderDetail
WHERE OrderQty > 5
GO



--Tao View
CREATE VIEW [dbo].[view_ProductCartItem]
AS
SELECT Production.Product.ProductID,
Sales.ShoppingCartItem.ShoppingCartItemID, Production.Product.Name,
Production.Product.ListPrice, Sales.ShoppingCartItem.Quantity
FROM Production.Product INNER JOIN
Sales.ShoppingCartItem ON Production.Product.ProductID =
Sales.ShoppingCartItem.ProductID

--Thuc thi View
SELECT * FROM view_ProductCartItem

-- Ket Qua




-- Tạo View
CREATE VIEW [dbo].[view_TotalSalesWithPromotion]
AS
SELECT Sales.SalesOrderDetail.SalesOrderID,
Sales.SpecialOfferProduct.ProductID,
CASE WHEN Sales.SpecialOffer.SpecialOfferID = '1' THEN
Sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.UnitPrice ELSE
Sales.SalesOrderDetail.OrderQty * Sales.SalesOrderDetail.UnitPrice * (1 -
Sales.SpecialOffer.DiscountPct)
END AS 'Amount', Sales.SpecialOffer.Description
FROM Sales.SpecialOffer 
INNER JOIN Sales.SpecialOfferProduct ON Sales.SpecialOffer.SpecialOfferID =
Sales.SpecialOfferProduct.SpecialOfferID 
INNER JOIN Sales.SalesOrderDetail ON Sales.SpecialOfferProduct.SpecialOfferID =
Sales.SalesOrderDetail.SpecialOfferID AND
Sales.SpecialOfferProduct.ProductID = Sales.SalesOrderDetail.ProductID
GO

--Thuc thi
SELECT * FROM view_TotalSalesWithPromotion

-- Ket Qua




CREATE VIEW [dbo].[view_DetailedOrdersWithPromotion]
AS
SELECT 
    SOH.SalesOrderID, 
    SOH.OrderDate, 
    C.CustomerID, 
    C.FirstName + ' ' + C.LastName AS CustomerName, 
    P.ProductID, 
    P.Name AS ProductName, 
    SOD.OrderQty, 
    SOD.UnitPrice, 
    SOF.DiscountPct, 
    (SOD.OrderQty * SOD.UnitPrice * (1 - ISNULL(SOF.DiscountPct, 0))) AS TotalWithDiscount,
    SUM(SOD.OrderQty * SOD.UnitPrice * (1 - ISNULL(SOF.DiscountPct, 0))) OVER(PARTITION BY SOH.SalesOrderID) AS TotalOrderValue
FROM 
    Sales.SalesOrderHeader SOH
JOIN 
    Sales.SalesOrderDetail SOD ON SOH.SalesOrderID = SOD.SalesOrderID
JOIN 
    Production.Product P ON SOD.ProductID = P.ProductID
JOIN 
    Sales.Customer C ON SOH.CustomerID = C.CustomerID
LEFT JOIN 
    Sales.SpecialOfferProduct SOP ON P.ProductID = SOP.ProductID
LEFT JOIN 
    Sales.SpecialOffer SOF ON SOP.SpecialOfferID = SOF.SpecialOfferID
WHERE 
    SUM(SOD.OrderQty * SOD.UnitPrice * (1 - ISNULL(SOF.DiscountPct, 0))) 
    OVER(PARTITION BY SOH.SalesOrderID) > 1000 
GO


--Tao View
CREATE VIEW [dbo].[RecentProductPromotions]
AS
SELECT Production.Product.ProductID, Production.Product.Name,
Production.Product.Color, Production.Product.ProductLine,
Sales.SpecialOfferProduct.SpecialOfferID,
Sales.SpecialOfferProduct.ModifiedDate
FROM Production.Product INNER JOIN
Sales.SpecialOfferProduct ON Production.Product.ProductID =
Sales.SpecialOfferProduct.ProductID
WHERE (Production.Product.Color IS NOT NULL) AND
(YEAR(Sales.SpecialOfferProduct.ModifiedDate) > '2012') AND
(Production.Product.ProductLine = 'S')
GO

-- Thuc thi
SELECT * FROM RecentProductPromotions

-- Ket Qua


CREATE VIEW [dbo].[bt5]
AS
SELECT SpecialOfferID, Description, DiscountPct, Type, Category, StartDate,
EndDate, MinQty, MaxQty, rowguid, ModifiedDate
FROM Sales.SpecialOffer
WHERE (SpecialOfferID = '5')
GO

UPDATE [dbo].[bt5]
SET
[DiscountPct] = '0.03'
GO


--Tao View
CREATE VIEW ComplexSalesView AS
SELECT
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    p.ListPrice,
    p.StandardCost,
    sod.SalesOrderDetailID,
    sod.SalesOrderID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.LineTotal,
    soh.OrderDate,
    soh.ShipDate,
    soh.SalesOrderNumber
FROM
    Production.Product p
    INNER JOIN Sales.SalesOrderDetail sod ON p.ProductID = sod.ProductID
    INNER JOIN Sales.SalesOrderHeader soh ON sod.SalesOrderID = soh.SalesOrderID;

--Ket qua
SELECT * FROM ComplexSalesView


-- Cap nhat View
UPDATE ComplexSalesView
SET ListPrice = 5000
WHERE ProductID = 776;


--Ket Qua

--Tạo thủ tục
CREATE PROCEDURE GetAllProducts
AS
BEGIN
    SELECT ProductID, Name, ProductNumber, ListPrice
    FROM Production.Product;
END;

--Thực thi
EXEC GetAllProducts

--Kết quả


--Tạo thủ tục
CREATE PROCEDURE showDiscountCustomer @a nvarchar(50) = N'Customer'
AS
BEGIN
	SELECT SpecialOfferID, Description, DiscountPct, Type, Category, StartDate,
	EndDate, MinQty, MaxQty, rowguid, ModifiedDate
	FROM Sales.SpecialOffer
	WHERE (Category = @a)
END

--Kết quả
EXEC showDiscountCustomer

--Thực thi


--Tạo Proceduce
CREATE PROCEDURE [show_soLuongSanPhamChuaDatHang] (@EId int output)
AS
BEGIN
	SET NOCOUNT ON
	SELECT @EId= (SELECT count (ShoppingCartItemID) 
	FROM Sales.ShoppingCartItem)
END
GO

--Thuc thi
declare @a INT
EXEC show_soLuongSanPhamChuaDatHang @a OUTPUT
SELECT @a as N'Số Lượng'

--Ket qua



--Tạo proceduce
CREATE PROC [show_producewithMaSP] @productID int
AS
BEGIN
	SELECT*
	FROM[Production].[Product]
	WHERE(ProductID = @productID)
END
GO

--Thuc thi
EXEC show_producewithMaSP  @productID='316'

--Ket qua


--Tạo proceduce
CREATE PROCEDURE [count_SanPhamByWeight](
	@weight decimal(8,2)
)
AS
BEGIN
	SELECT count( ProductID) as N'Số Lượng'
	FROM Production.Product
	WHERE(Weight = @weight)
END
GO

--Thực thi
exec count_SanPhamByWeight @weight= 2.22

--Kết quả

--Tạo Function
CREATE FUNCTION dbo.fn_GetTotalProductQuantityInCart (@ProductID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalQuantity INT;
    
    SELECT @TotalQuantity = SUM(Quantity)
    FROM Sales.ShoppingCartItem
    WHERE ProductID = @ProductID;
    
    RETURN ISNULL(@TotalQuantity, 0);
END;
GO

--Thuc thi 
SELECT dbo.fn_GetTotalProductQuantityInCart(862);

--Ket qua



--Tạo function
CREATE FUNCTION [dbo].[calculateTotalPrice] 
  (@salesOrderId int
 )
RETURNS numeric(38,6)
AS
BEGIN
	RETURN (select SUM (LineTotal) FROM Sales.SalesOrderDetail 
	WHERE (SalesOrderID = @salesOrderId))
END
GO

SELECT * FROM Sales.SalesOrderDetail

--Thực thi
SELECT [dbo].calculateTotalPrice(43664)

--Ket qua


--Tạo function
CREATE FUNCTION dbo.fn_GetProductSalesDetails (@ProductID INT)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        P.ProductID,
        P.Name AS ProductName,
        SOD.SalesOrderID,
        SOD.OrderQty,
        SOD.UnitPrice,
        SOD.UnitPriceDiscount,
        (SOD.UnitPrice * SOD.OrderQty) AS TotalPrice,
        (SOD.UnitPriceDiscount * SOD.OrderQty) AS TotalDiscount,
        SO.SpecialOfferID,
        SO.Description AS SpecialOfferDescription,
        SOH.OrderDate,
        SOH.DueDate,
        SOH.ShipDate,
        SOH.SubTotal
    FROM 
        Production.Product P
    INNER JOIN 
        Sales.SalesOrderDetail SOD ON P.ProductID = SOD.ProductID
    INNER JOIN 
        Sales.SalesOrderHeader SOH ON SOD.SalesOrderID = SOH.SalesOrderID
    LEFT JOIN 
        Sales.SpecialOfferProduct SOP ON SOD.ProductID = SOP.ProductID
    LEFT JOIN 
        Sales.SpecialOffer SO ON SOP.SpecialOfferID = SO.SpecialOfferID
    WHERE 
        P.ProductID = @ProductID
);
GO

--Thực thi 
SELECT * FROM dbo.fn_GetProductSalesDetails(751)

--Kết quả



CREATE FUNCTION dbo.fn_GetProductsWithActiveSpecialOffers (
	@StartDay DATE,
	@EndDay DATE
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        P.ProductID,
        P.Name AS ProductName,
        P.ProductLine,
        P.Color,
        SO.SpecialOfferID,
        SO.Description AS SpecialOfferDescription,
        SO.DiscountPct,
        SO.StartDate,
        SO.EndDate,
        SOP.ModifiedDate
    FROM 
        Production.Product P
    INNER JOIN 
        Sales.SpecialOfferProduct SOP ON P.ProductID = SOP.ProductID
    INNER JOIN 
        Sales.SpecialOffer SO ON SOP.SpecialOfferID = SO.SpecialOfferID
    WHERE
        @CurrentDay BETWEEN SO.StartDate AND SO.EndDate
);
GO


SELECT * FROM dbo.fn_GetProductsWithActiveSpecialOffers()


CREATE FUNCTION dbo.fn_GetProductsWithActiveSpecialOffer (
    @StartDay DATETIME,
    @EndDay DATETIME
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        P.ProductID,
        P.Name AS ProductName,
        P.ProductLine,
        P.Color,
        SO.SpecialOfferID,
        SO.Description AS SpecialOfferDescription,
        SO.DiscountPct,
        SO.StartDate,
        SO.EndDate,
        SOP.ModifiedDate
    FROM 
        Production.Product P
    INNER JOIN 
        Sales.SpecialOfferProduct SOP ON P.ProductID = SOP.ProductID
    INNER JOIN 
        Sales.SpecialOffer SO ON SOP.SpecialOfferID = SO.SpecialOfferID
    WHERE 
        SO.StartDate >= @StartDay AND SO.EndDate <= @EndDay
);
GO


-- Example to retrieve products with special offers between two specific dates
SELECT * 
FROM dbo.fn_GetProductsWithActiveSpecialOffers('2011-05-01', '2014-11-30');



--Tạo Function
CREATE FUNCTION show_productByStyle (@Style char )
RETURNS @bangtam TABLE (ProductID int,Name nvarchar(50))
AS
BEGIN
	if (@Style = 'M')
		INSERT INTO @bangtam(ProductID,Name)
		SELECT ProductID, Name 
		FROM Production.Product
		WHERE Style = 'M'
	if (@Style = 'W')
		INSERT INTO @bangtam(ProductID,Name)
		SELECT ProductID, Name 
		From Production.Product
		WHERE Style = 'W'
	if (@Style = 'U')
		INSERT INTO @bangtam(ProductID,Name)
		SELECT ProductID, Name
		FROM Production.Product
		WHERE Style = 'U'
	RETURN
END
GO

--Thực thi
SELECT * FROM [show_productByStyle] ('M')

--Kết quả


--Code function
CREATE FUNCTION show_ProductByProductId (@productId int)
RETURNS TABLE
AS
RETURN
(SELECT *FROM Production.Product WHERE (ProductID = @productId))
GO

--Thực thi
select * from [show_ProductByProductId] ('317')

--Kết 


--Code trigger
CREATE TRIGGER tg1
ON Sales.SpecialOffer
FOR INSERT
AS
BEGIN
	IF (( SELECT MinQty FROM INSERTED ) > ( SELECT MaxQty FROM
	INSERTED ))
	Begin
		Print N'Chiết khấu tổi thiểu phải nhỏ hơn chiết khấu tối đa'
		rollback transaction
END
END
GO

--Thực thi trigger
INSERT INTO Sales.SpecialOffer
VALUES(
	N'abc',
	DEFAULT,
	N'',
	N'',
	GETDATE(),
	GETDATE(),
	100,
	10,
	DEFAULT,
	DEFAULT
)

--Kết quả


CREATE TRIGGER tg2
 ON Sales.ShoppingCartItem
 FOR Update
AS
 BEGIN
	IF (( SELECT Quantity FROM INSERTED ) <= 0)
	  Begin
		Print N'Số hàng phải lớn hơn 0'	
		rollback transaction
	  end
 END



CREATE TRIGGER tg3
ON Sales.SpecialOffer
FOR Delete
AS
BEGIN
    IF (( SELECT SpecialOfferID FROM deleted ) like (SELECT 
   SpecialOfferID FROM Sales.SpecialOfferProduct))
   Begin
	 Print N'Không xóa được'  
	 rollback transaction 
   end
END


--Code transaction
CREATE TRIGGER [tran1] 
ON Sales.SpecialOffer 
FOR INSERT 
AS 
BEGIN 
	IF (( SELECT EndDate FROM INSERTED ) < GETDATE()) 
	  Begin 
		 Print N'ngày kết thúc không được trước ngày hiện tại' 
		 rollback transaction 
      END 
END 

--Thực thi transaction
INSERT INTO Sales.SpecialOffer
VALUES(
	N'abc',
	DEFAULT,
	N'',
	N'',
	GETDATE(),
	GETDATE(),
	0,
	NULL,
	DEFAULT,
	DEFAULT
)

--Kết quả







CREATE LOGIN [BCD] WITH
PASSWORD=N' tsëAÝ °=ùöæ¬ÕyÈ\ ã´^__¢ù Súç'     ,
DEFAULT_DATABASE=[AdventureWorks2022],
DEFAULT_LANGUAGE=[British], CHECK_EXPIRATION=ON,
CHECK_POLICY=ON
GO
Create user AnhViet for login MainForm