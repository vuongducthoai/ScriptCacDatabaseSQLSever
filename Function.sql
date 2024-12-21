---- Ham tinh tong so don hang cua mot khach hang 
CREATE FUNCTION [dbo].GetTotalOrdersByCustomer(
   @MaKhachHang NVARCHAR(10)
) RETURNS INT 
AS
BEGIN 
	DECLARE @TotalOrders INT;
	SELECT @TotalOrders = COUNT(*)
	FROM DonHang 
	WHERE MaKhachHang = @MaKhachHang
	
	RETURN @TotalOrders;
END;
 

 -- Ham lay trang thai van chuyen cua mot don hang
 CREATE FUNCTION [dbo].GetShippingStatus(
    @MaGuiHang NVARCHAR(10)
) RETURNS nvarchar(50)
AS
BEGIN 
   DECLARE @Status nvarchar(50)
   SELECT @Status = T.TenTrangThai
   FROM GuiHang G 
   JOIN TrangThaiVanChuyen T ON G.MaTrangThai = T.MaTrangThai
   WHERE G.MaGuiHang = @MaGuiHang

   RETURN @Status;
END;



 
-- Ham tinh tong tien cua mot don hang dua tren ma khach hang 
CREATE FUNCTION [dbo].GetTotalAmountOrder(
   @MaDonHang NVARCHAR(10)
) RETURNS decimal(10,2)
AS 
BEGIN 
	DECLARE @TotalAmount decimal(18,2);
	SELECT @TotalAmount = TongTien
	FROM DonHang 
	WHERE MaDonHang = @MaDonHang

	RETURN @TotalAmount;
END;





--Function trả về tên dịch vụ dựa trên mã dịch vụ
CREATE FUNCTION [dbo].fn_GetTenDichVu(@MaDichVu NVARCHAR(10))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @TenDichVu NVARCHAR(50)
    SELECT @TenDichVu = TenDichVu
    FROM DichVu
    WHERE MaDichVu = @MaDichVu
    RETURN @TenDichVu
END




-- Function trả về tổng số đơn hàng dua tren trang thai don hang
CREATE FUNCTION GetTongSoDonHangTrong1NamCuaBuuDienGiaLam(
	@TenTrangThai NVARCHAr(50)
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   JOIN TrangThaiVanChuyen as tt ON gh.MaTrangThai = gh.MaTrangThai
   WHERE 
	   tt.TenTrangThai = @TenTrangThai
   RETURN @TongSoDonHang
END



-- Function trả về tổng số đơn hàng cua buu dien gia lam
CREATE FUNCTION [dbo].fn_GetTongSoDonHangByBuuCuc(@MaBuuCuc NVARCHAR(10))
RETURNS INT
AS
BEGIN
    DECLARE @TongSoDonHang INT
    SELECT @TongSoDonHang = COUNT(*)
    FROM DonHang dh
    JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
    RETURN @TongSoDonHang
END



-- Function trả về tổng số đơn hàng cua một bưu cục trong 1 ngay dựa trên mã bưu cục
CREATE FUNCTION GetTongSoDonHangByBuuCucTrongNgay(  
	@MaBuuCuc NVARCHAR(10),
	@Ngay INT,
	@Thang INT,
	@Nam INT
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   JOIN NhanVien nv ON nv.MaBuuCuc = @MaBuuCuc
   WHERE 
       DAY(dh.NgayDatHang) = @Ngay
	   AND MONTH(dh.NgayDatHang) = @Thang
	   AND YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END


        

-- Function trả về tổng số đơn hàng một bưu cục trong 1 thang dựa trên mã bưu cục
CREATE FUNCTION GetTongSoDonHangByBuuCucTrongThang(
	@MaBuuCuc NVARCHAR(10),
	@Thang INT,
	@Nam INT
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   JOIN NhanVien nv ON nv.MaBuuCuc = @MaBuuCuc
   WHERE MONTH(dh.NgayDatHang) = @Thang
   AND YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END

 
-- Function trả về tổng số đơn hàng một bưu cục trong 1 nam dựa trên mã bưu cục
CREATE FUNCTION GetTongSoDonHangByBuuCucTrongMotNam(
	@MaBuuCuc NVARCHAR(10),
	@Nam INT
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   JOIN NhanVien nv ON nv.MaBuuCuc = @MaBuuCuc
   WHERE 
	   YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END




-- Function trả về tổng số đơn hàng cua 1 ngay cua buu dien gia lam
CREATE FUNCTION GetTongSoDonHangTrong1NgayCuaBuuDienGiaLam(
	@Ngay INT,
	@Thang INT,
	@Nam INT
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   WHERE 
       DAY(dh.NgayDatHang) = @Ngay
	   AND MONTH(dh.NgayDatHang) = @Thang
	   AND YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END
         

-- Function trả về tổng số đơn hàng trong 1 thang cua buu dien Gia Lam
CREATE FUNCTION GetTongSoDonHangByBuuCucTrong1ThangCuaBuuDienGiaLam(
	@Thang INT,
	@Nam INT
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   WHERE MONTH(dh.NgayDatHang) = @Thang
   AND YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END


-- Function trả về tổng số đơn hàng trong 1 nam cua buu dien Gia Lam
CREATE FUNCTION GetTongSoDonHangTrong1NamCuaBuuDienGiaLam(
	@Nam INT
) RETURNS INT
AS
BEGIN 
   DECLARE @TongSoDonHang INT
   SELECT @TongSoDonHang = COUNT(*)
   FROM DonHang dh
   JOIN GuiHang gh ON dh.MaGuiHang = gh.MaGuiHang
   WHERE 
	   YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END






