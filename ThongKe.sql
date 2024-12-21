SELECT TOP (1000) [Date]
      ,[Item_Code]
      ,[Wholesale_Price_RMB_kg]
  FROM [QLBH].[dbo].[Price]


ALTER TABLE [dbo].[Price]
ADD CONSTRAINT FK__Price__Item_Code FOREIGN KEY (Item_Code) REFERENCES Item(Item_Code);

ALTER TABLE [dbo].[Price]
ADD CONSTRAINT PK_Transaction_Date PRIMARY KEY (Date, Item_Code);


-- Lệnh 1: Lấy danh sách các giao dịch có giá trị lớn hơn 500 RMB
SELECT * 
FROM [dbo].[Transaction]
WHERE Unit_Selling_Price_RMB_kg > 7;


SELECT * FROM Price

SELECT i.Item_Name, p.Wholesale_Price_RMB_kg
FROM Item as i
JOIN Price as p ON i.Item_Code = p.Item_Code
WHERE p.Date = '2020-07-01';


SELECT Item_Code, SUM(Quantity_Sold_kilo) AS Total_Quantity_Sold
FROM [dbo].[Transaction]
WHERE Quantity_Sold_kilo > 0
GROUP BY Item_Code;




SELECT Item.Category_Name, SUM(t.Quantity_Sold_kilo * t.Unit_Selling_Price_RMB_kg) AS Total_Revenue
FROM [dbo].[Transaction] as t
JOIN Item ON t.Item_Code = Item.Item_Code
WHERE t.Quantity_Sold_kilo > 0
GROUP BY Item.Category_Name;


-- Lấy danh sách các mặt hàng có tổng số lượng bán ra lớn hơn 50 kg
SELECT Item_Code, SUM(Quantity_Sold_kilo) AS Total_Quantity_Sold
FROM [dbo].[Transaction] as t
WHERE Quantity_Sold_kilo > 0
GROUP BY Item_Code
HAVING SUM(Quantity_Sold_kilo) > 50;



SELECT i.Category_Name, SUM(t.Quantity_Sold_kilo * t.Unit_Selling_Price_RMB_kg) AS Total_Revenue
FROM [dbo].[Transaction] as t
JOIN Item as i ON t.Item_Code = t.Item_Code
WHERE t.Quantity_Sold_kilo > 0
GROUP BY i.Category_Name
HAVING SUM(t.Quantity_Sold_kilo * t.Unit_Selling_Price_RMB_kg) > 5000
ORDER BY Total_Revenue DESC;


SELECT Item_Code, SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) AS Total_Revenue
FROM [dbo].[Transaction] as t
WHERE Quantity_Sold_kilo > 0
GROUP BY Item_Code
HAVING SUM(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) > 
       (SELECT AVG(Quantity_Sold_kilo * Unit_Selling_Price_RMB_kg) FROM [dbo].[Transaction]);


	   SELECT * FROM Price


	   INSERT INTO Item (Item_Code, Item_Name, Category_Code, Category_Name)
SELECT 'ITM100', 'New Product', 'CAT05', 'Electronics'
WHERE NOT EXISTS (SELECT * FROM Item WHERE Item_Code = '102900005115199');



SELECT * FROM Price
UPDATE Price
SET [Wholesale_Price_RMB_kg] = 10
WHERE Item_Code = '102900005115762' AND [Wholesale_Price_RMB_kg] < 5;

SELECT* FROM Item

INSERT INTO Item (Item_Code, Item_Name, Category_Code, Category_Name)
SELECT 106973990980124, 'New Product', 1011010101, 'Electronics'
WHERE NOT EXISTS (SELECT 1 FROM Item WHERE Item_Code = 106973990980124);



-- Câu lệnh này tính tổng doanh thu theo loại sản phẩm và theo thời gian (năm, tháng).
--Bạn có thể lọc theo Category_Name hoặc khoảng thời gian tùy ý để hiển thị tổng doanh thu cho từng loại sản phẩm.
SELECT Item.Category_Name, 
       DATEPART(YEAR, t.Date) AS Year, 
       DATEPART(MONTH, t.Date) AS Month,
       SUM(t.Quantity_Sold_kilo * t.Unit_Selling_Price_RMB_kg) AS Total_Revenue
FROM [dbo].[Transaction] as t
JOIN Item ON t.Item_Code = Item.Item_Code
WHERE t.Sale_Or_Return = 'Sale' -- Chỉ tính các giao dịch bán
GROUP BY Item.Category_Name, DATEPART(YEAR, t.Date), DATEPART(MONTH, t.Date)
ORDER BY Year, Month;


--Page 1: Doanh thu và Lợi nhuận
--Tổng doanh thu theo loại sản phẩm và thời gian
--Giải thích: Câu lệnh này tính lợi nhuận gộp cho từng loại sản phẩm theo thời gian (năm, tháng).
--Lợi nhuận gộp được tính bằng cách lấy chênh lệch giữa giá bán lẻ và giá vốn (giá bán buôn) cho từng sản phẩm bán ra.

SELECT Item.Category_Name, 
       DATEPART(YEAR, t.Date) AS Year, 
       DATEPART(MONTH, t.Date) AS Month,
       SUM(t.Quantity_Sold_kilo * t.Unit_Selling_Price_RMB_kg) AS Total_Revenue
FROM [dbo].[Transaction] as t
JOIN Item ON t.Item_Code = Item.Item_Code
WHERE t.Sale_Or_Return = 'Sale' -- Chỉ tính các giao dịch bán
GROUP BY Item.Category_Name, DATEPART(YEAR, t.Date), DATEPART(MONTH, t.Date)
ORDER BY Year, Month;


-- Lợi nhuận gộp theo loại sản phẩm và thời gian
--Giải thích: Câu lệnh này tính lợi nhuận gộp cho từng loại 
--sản phẩm theo thời gian (năm, tháng). Lợi nhuận gộp được tính
--bằng cách lấy chênh lệch giữa giá bán lẻ và giá vốn (giá bán buôn) 
--cho từng sản phẩm bán ra.

SELECT Item.Category_Name, 
       DATEPART(YEAR, t.Date) AS Year, 
       DATEPART(MONTH, t.Date) AS Month,
       SUM(t.Quantity_Sold_kilo * (t.Unit_Selling_Price_RMB_kg - Price.[Wholesale_Price_RMB_kg])) AS Gross_Profit
FROM [dbo].[Transaction] as t
JOIN Item ON t.Item_Code = Item.Item_Code
JOIN Price ON t.Item_Code = Price.Item_Code AND t.Date = Price.Date
WHERE t.Sale_Or_Return = 'Sale' -- Chỉ tính các giao dịch bán
GROUP BY Item.Category_Name, DATEPART(YEAR, t.Date), DATEPART(MONTH, t.Date)
ORDER BY Year, Month;


SELECT * FROM [dbo].[Transaction]

--3. Tổng doanh thu và số lượng bán ra của các sản phẩm được giảm giá
--Giải thích: Câu lệnh này tính tổng doanh thu và số lượng bán ra cho các sản phẩm có áp dụng giảm giá, 
--sắp xếp theo doanh thu giảm dần.
SELECT i.Item_Name, 
       SUM(t.Quantity_Sold_kilo) AS Total_Quantity_Sold, 
       SUM(t.Quantity_Sold_kilo * t.Unit_Selling_Price_RMB_kg) AS Total_Revenue
FROM [dbo].[Transaction] as t
JOIN Item  as i ON t.Item_Code = i.Item_Code
WHERE t.Discount_Yes_No = 'YES'-- Chỉ tính các giao dịch có giảm giá
GROUP BY i.Item_Name
ORDER BY Total_Revenue DESC;








--Page 2: Phân tích giá vốn hàng bán và Tỷ lệ hao hụt
--1. Giá vốn hàng bán (COGS) theo loại sản phẩm và thời gian
--Giải thích: Câu lệnh này tính giá vốn hàng bán (COGS) cho từng loại sản phẩm theo thời gian (năm, tháng), 
--cho phép doanh nghiệp theo dõi chi phí vốn cho từng loại sản phẩm.
SELECT Item.Category_Name, 
       DATEPART(YEAR, t.Date) AS Year, 
       DATEPART(MONTH, t.Date) AS Month,
       SUM(t.Quantity_Sold_kilo * Price.Wholesale_Price_RMB_kg) AS COGS
FROM [dbo].[Transaction] as t
JOIN Item ON t.Item_Code = Item.Item_Code
JOIN Price ON t.Item_Code = Price.Item_Code AND t.Date = Price.Date
WHERE t.Sale_Or_Return = 'Sale' -- Chỉ tính các giao dịch bán
GROUP BY Item.Category_Name, DATEPART(YEAR, t.Date), DATEPART(MONTH, t.Date)
ORDER BY Year, Month;



--.2 Phân tích tỷ lệ hao hụt của các sản phẩm
--Giải thích: Câu lệnh này tính tỷ lệ hao hụt trung bình cho từng loại sản phẩm,
-- giúp doanh nghiệp xác định các loại hàng hóa có
-- tỷ lệ hao hụt cao nhất và có thể cần được quản lý chặt chẽ hơn.
SELECT Item.Category_Name, 
       AVG(LossRate.Loss_Rate) AS Average_Loss_Rate
FROM Item
JOIN LossRate ON Item.Item_Code = LossRate.Item_Code
GROUP BY Item.Category_Name
ORDER BY Average_Loss_Rate DESC;


--3. Sản phẩm có lợi nhuận gộp cao nhất với điều kiện giảm giá
-- Giải thích: Câu lệnh này tính lợi nhuận gộp cho các sản phẩm có giảm giá,
-- sắp xếp theo lợi nhuận giảm dần. Điều này giúp xác định sản phẩm nào vẫn có lợi nhuận tốt mặc dù đã áp dụng giảm giá.
SELECT Item.Item_Name, t.Discount_Yes_No,
       SUM(t.Quantity_Sold_kilo * (t.Unit_Selling_Price_RMB_kg - Price.Wholesale_Price_RMB_kg)) AS Gross_Profit
FROM [dbo].[Transaction] as t
JOIN Item ON t.Item_Code = Item.Item_Code
JOIN Price ON t.Item_Code = Price.Item_Code AND t.Date = Price.Date
--WHERE t.Discount_Yes_No = 'YES' -- Chỉ tính các giao dịch có giảm giá
GROUP BY Item.Item_Name, t.Discount_Yes_No
HAVING SUM(t.Quantity_Sold_kilo * (t.Unit_Selling_Price_RMB_kg - Price.Wholesale_Price_RMB_kg)) > 0
ORDER BY Gross_Profit DESC;
