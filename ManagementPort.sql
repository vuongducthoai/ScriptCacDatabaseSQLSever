CREATE TABLE BuuCuc(
	MaBuuCuc nvarchar(10),
	TenBuuCuc nvarchar(50),
	DiaChi   nvarchar(100),
	MaKhuVuc nvarchar(10)
)


CREATE TABLE DichVu(
MaDichVu nvarchar(10),
TenDichVu  nvarchar(50),
MoTaDichVu nvarchar(100)
)


CREATE TABLE DonHang(
	MaDonHang nvarchar(10),
	MaKhachHang nvarchar(10),
	MaGuiHang  nvarchar(10),
	NgayDatHang  date,
	TongTien  decimal(18, 2)
)

CREATE TABLE DonViVanChuyen(
 MaDonViVanChuyen nvarchar(10),
 TenDonVi nvarchar(50),
 SoDienThoai nvarchar(15)
)


CREATE TABLE GuiHang(
	MaGuiHang nvarchar(10),
	MaKhachHang  nvarchar(10),
	MaDonViVanChuyen nvarchar(10),
	NgayGuiHang date,
	MaTrangThai nvarchar(10),
	MaDichVu  nvarchar(10)
)

CREATE TABLE KhachHang (
MaKhachHang nvarchar(10),
HoTen nvarchar(50),
SoDienThoai nvarchar(15),
Email nvarchar(50),
DiaChi nvarchar(100)
)

CREATE TABLE KhuVuc (
	MaKhuVuc nvarchar(10),
	TenKhuVuc nvarchar(50)
)

CREATE TABLE NhanVien(
MaNhanVien nvarchar(10),
HoTen nvarchar(50),
ChucVu nvarchar(50),
SoDienThoai nvarchar(15),
Email nvarchar(50),
MaBuuCuc nvarchar(10)
)


CREATE TABLE PhuongThucThanhToan(
	MaPhuongThucThanhToan nvarchar(10),
	TenPhuongThuc nvarchar(50)
)

CREATE TABLE TrangThaiVanChuyen(
    MaTrangThai nvarchar(10),
	TenTrangThai  nvarchar(50)
)
