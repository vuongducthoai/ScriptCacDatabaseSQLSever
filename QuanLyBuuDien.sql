--1Function đọc giá trị ten buc cuc dua vao ma buu cuc
CREATE FUNCTION GetTenBuuCuc(
    @MaBuuCuc NVARCHAR(10)
) 
RETURNS NVARCHAR(50)
AS
BEGIN 
    DECLARE @TenBuuCuc NVARCHAR(50);
    
    SELECT @TenBuuCuc = b.TenBuuCuc 
    FROM BuuCuc AS b
    WHERE b.MaBuuCuc = @MaBuuCuc;

    RETURN @TenBuuCuc;
END

--2.Function trả về tên dịch vụ dựa trên mã dịch vụ
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

 -- 3.Ham lay trang thai van chuyen cua mot don hang
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


--4.Function trả về tên phương thức thanh toán dựa trên mã phương thức thanh toán
CREATE FUNCTION [dbo].fn_GetTenPhuongThucThanhToan(@MaPhuongThucThanhToan NVARCHAR(10))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @TenPhuongThuc NVARCHAR(50)
    SELECT @TenPhuongThuc = TenPhuongThuc
    FROM PhuongThucThanhToan
    WHERE MaPhuongThucThanhToan = @MaPhuongThucThanhToan
    RETURN @TenPhuongThuc
END

--5. Function trả về tên của khu vực dựa trên mã bưu cục
CREATE FUNCTION [dbo].fn_GetTenKhuVuc(@MaBuuCuc NVARCHAR(10))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @TenKhuVuc NVARCHAR(50)
    SELECT @TenKhuVuc = kv.TenKhuVuc
    FROM BuuCuc bc
    JOIN KhuVuc kv ON bc.MaKhuVuc = kv.MaKhuVuc
    WHERE bc.MaBuuCuc = @MaBuuCuc
    RETURN @TenKhuVuc
END


-- Function trả về table thong tin của đơn hàng có tham số đầu vào là trang thái đơn hàng 
CREATE FUNCTION GetDonHang(
	@TrangThaiDonhang NVARCHAR(50)
)
RETURNS TABLE 
AS
RETURN(
	SELECT d.MaDonHang, g.MaKhachHang, g.NgayGuiHang, dvvc.TenDonVi, dvvc.SoDienThoai 
	FROM DonHang as d INNER JOIN GuiHang as g 
	ON d.MaGuiHang = g.MaGuiHang
	INNER JOIN DonViVanChuyen as dvvc 
	ON dvvc.MaDonViVanChuyen = g.MaDonViVanChuyen
	INNER JOIN TrangThaiVanChuyen as tt 
	ON tt.MaTrangThai = g.MaTrangThai
	WHERE tt.MaTrangThai = @TrangThaiDonhang
)


-- Function trả về table những khách hàng sử dụng dịch vụ được truyền vào tham số
CREATE FUNCTION GetKhachHangByDichVu
(
    @TenDichVu nvarchar(10)
)
RETURNS TABLE
AS
RETURN
(
    SELECT DISTINCT KH.MaKhachHang, KH.HoTen, KH.SoDienThoai, KH.Email, KH.DiaChi
    FROM KhachHang KH
    JOIN GuiHang GH ON KH.MaKhachHang = GH.MaKhachHang
	JOIN DichVu as dv ON dv.MaDichVu = gh.MaDichVu
    WHERE dv.TenDichVu = @TenDichVu
)


-- Function tra ve bảng danh sach cac khach hang da dat hang có tham so truyen vào la thang
CREATE FUNCTION GetKhachHangByMonth
(
   @Month INT
)
RETURNS TABLE
AS
RETURN (
    SELECT DISTINCT KH.MaKhachHang, KH.HoTen, KH.SoDienThoai, KH.Email, KH.DiaChi
    FROM KhachHang KH
    JOIN DonHang DH ON KH.MaKhachHang = DH.MaKhachHang
    WHERE MONTH(DH.NgayDatHang) = @Month
)


-- Function tra ve bang danh sach cac don hang duoc gui có tham so truyen vào la thang
CREATE FUNCTION GetDonhangDuocGuiInMonth(
   @Month INT
)
RETURNS TABLE
AS
RETURN (
    SELECT DISTINCT dh.MaDonHang, dh.NgayDatHang, dh.TongTien, gh.NgayGuiHang
    FROM GuiHang as gh
    JOIN DonHang DH ON gh.MaGuiHang = dh.MaGuiHang
    WHERE MONTH(DH.NgayDatHang) = @Month
)



--Function trả ve table  thông tin  tất cả nhân vien thuoc và tên bưu cụccó them số truyền vào là mã bưu cục
CREATE FUNCTION GetNhanVienThuocBuuCuc(
	@MaBuuCuc NVARCHAR(10)
)
RETURNS TABLE 
AS 
RETURN(
	SELECT n.MaNhanVien, n.HoTen, n.ChucVu, n.SoDienThoai, n.Email 
	FROM NhanVien as n
	INNER JOIN BuuCuc as b ON n.MaBuuCuc = b.MaBuuCuc
	WHERE n.MaBuuCuc = @MaBuuCuc
)


-- Function trả về table thông tin cua khach hang dựa vào tổng tiền cua đon hàng nam trong khoang min đến max
CREATE FUNCTION GetThonTinKhachHangBaseMoneyOfOrder(
	@MinTien decimal(18,2),
	@MaxTien decimal(18,2)
) RETURNS TABLE
AS 
RETURN (
	SELECT DISTINCT KH.MaKhachHang, KH.HoTen, KH.SoDienThoai, KH.Email, KH.DiaChi
    FROM KhachHang KH
	INNER JOIN DonHang as dh 
	ON KH.MaKhachHang = DH.MaKhachHang
	WHERE dh.TongTien >= @MinTien AND dh.TongTien <= @MaxTien
)





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



-- Function trả về tổng số đơn hàng cua một bưu cục trong 1 ngay dựa trên mã bưu cục
CREATE FUNCTION GetTongSoDonHangByBuuCucTronMotgNgay(  
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
   JOIN BuuCuc bc ON bc.MaBuuCuc = @MaBuuCuc
   WHERE 
       DAY(dh.NgayDatHang) = @Ngay
	   AND MONTH(dh.NgayDatHang) = @Thang
	   AND YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END




-- Function trả về tổng số đơn hàng một bưu cục trong 1 thang dựa trên mã bưu cục
CREATE FUNCTION GetTongSoDonHangByBuuCucTrongMotThang(
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
   JOIN BuuCuc bc ON bc.MaBuuCuc = @MaBuuCuc
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
   JOIN BuuCuc bc ON bc.MaBuuCuc = @MaBuuCuc
   WHERE 
	   YEAR(dh.NgayDatHang) = @Nam
   RETURN @TongSoDonHang
END



--Fuction trả về tổng số lượng đơn hàng được gửi của toàn bưu cục
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


--Function trả về tên phương thức thanh toán dựa trên mã phương thức thanh toán
CREATE FUNCTION [dbo].fn_GetTenPhuongThucThanhToan(@MaPhuongThucThanhToan NVARCHAR(10))
RETURNS NVARCHAR(50)
AS
BEGIN
    DECLARE @TenPhuongThuc NVARCHAR(50)
    SELECT @TenPhuongThuc = TenPhuongThuc
    FROM PhuongThucThanhToan
    WHERE MaPhuongThucThanhToan = @MaPhuongThucThanhToan
    RETURN @TenPhuongThuc
END