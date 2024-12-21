CREATE DATABASE QuanLyCuaHang
USE QuanLyCuaHang

CREATE TABLE NhanVien(
	MSNV CHAR(10) PRIMARY KEY,
	HOTEN NVARCHAR(50) NOT NULL,
	DIACHI NVARCHAR(100) NOT NULL,
	NAMSINH DATE NOT NULL, 
	PHAI CHAR(1) NOT NULL,
	DT NVARCHAR(10) NOT NULL UNIQUE
)

CREATE TABLE CuaHang (
	MSCH CHAR(10) PRIMARY KEY, 
	TENCH NVARCHAR(50) NOT NULL, 
	DIACHI NVARCHAR(100) NOT NULL,
	DT NVARCHAR(10) NOT NULL UNIQUE
)

CREATE TABLE LoaiHang (
	MSLH CHAR(10) PRIMARY KEY,
	TENLOAI NVARCHAR(50) NOT NULL
)

CREATE TABLE MatHang (
	 MSMH CHAR(10) PRIMARY KEY,
	 MSLH CHAR(10) NOT NULL, 
	 TENMH NVARCHAR(50) NOT NULL,
	 FOREIGN KEY (MSLH) REFERENCES LoaiHang(MSLH),
)


CREATE TABLE PhieuGiaoHang (
	SOPG CHAR(10) PRIMARY KEY,
	MSCH CHAR(10) NOT NULL,
	NGAYLAP DATE NOT NULL, 
	MSNV CHAR(10) NOT NULL, 
	FOREIGN KEY (MSCH) REFERENCES CuaHang(MSCH),
	FOREIGN KEY (MSNV) REFERENCES NhanVien(MSNV)
)

CREATE TABLE ChiTietPhieuGiaoHang (
	SOPG CHAR(10) NOT NULL,
	MSMH CHAR(10) NOT NULL, 
	SOLUONGGIAO INT NOT NULL CHECK (SOLUONGGIAO > 0),
	GIA DECIMAL(18,2) NOT NULL CHECK (GIA >= 0),
	PRIMARY KEY(SOPG, MSMH),
	FOREIGN KEY (SOPG) REFERENCES PhieuGiaoHang(SOPG),
	FOREIGN KEY (MSMH) REFERENCES MatHang(MSMH)
)

CREATE TABLE PhieuThanhToan (
	SOPTT CHAR(10) PRIMARY KEY,
	MSCH CHAR(10) NOT NULL, 
	NGAYLAP DATE NOT NULL, 
	MSNV CHAR(10) NOT NULL, 
	FOREIGN KEY (MSCH) REFERENCES CuaHang(MSCH),
	FOREIGN KEY (MSNV) REFERENCES NhanVien(MSNV)
)

CREATE TABLE ChiTietPhieuThanhToan (
	SOPTT CHAR(10) NOT NULL,
	MSMH CHAR(10) NOT NULL,
	SOLUONG INT NOT NULL CHECK(SOLUONG > 0),
	THANHTIEN DECIMAL(18,2) NOT NULL CHECK (THANHTIEN >= 0),
	DONGIA DECIMAL(18,2) NOT NULL CHECK(DONGIA >= 0),
	PRIMARY KEY (SOPTT, MSMH),
	FOREIGN KEY (SOPTT) REFERENCES PhieuThanhToan(SOPTT),
	FOREIGN KEY (MSMH) REFERENCES MatHang(MSMH)
);

CREATE TABLE BanHang(
	MSCH CHAR(10) NOT NULL,
	MSMH CHAR(10) NOT NULL,
	GIABAN DECIMAL(18,2) NOT NULL CHECK(GIABAN >= 0),
	SOLUONGTON INT NOT NULL CHECK(SOLUONGTON >= 0),
	PRIMARY KEY (MSCH, MSMH),
	FOREIGN KEY (MSCH) REFERENCES CuaHang(MSCH),
	FOREIGN KEY(MSMH) REFERENCES MatHang(MSMH)
);



INSERT INTO NhanVien (MSNV, HOTEN, DIACHI, NAMSINH, PHAI, DT) VALUES
('NV001', N'Nguyễn Văn A', N'Hà Nội', '1985-03-10', 'M', '0912345678'),
('NV002', N'Trần Thị B', N'Hồ Chí Minh', '1990-07-20', 'F', '0987654321'),
('NV003', N'Lê Văn C', N'Đà Nẵng', '1987-01-15', 'M', '0901234567'),
('NV004', N'Phạm Thị D', N'Hải Phòng', '1995-09-12', 'F', '0923456789'),
('NV005', N'Hoàng Văn E', N'Cần Thơ', '1980-11-30', 'M', '0934567890'),
('NV006', N'Võ Thị F', N'Quảng Ninh', '1992-05-21', 'F', '0945678901'),
('NV007', N'Bùi Văn G', N'Lâm Đồng', '1983-04-19', 'M', '0956789012'),
('NV008', N'Đỗ Thị H', N'Thái Nguyên', '1989-12-10', 'F', '0967890123'),
('NV009', N'Nguyễn Văn I', N'Bình Dương', '1993-06-08', 'M', '0978901234'),
('NV010', N'Phan Thị K', N'Nghệ An', '1991-08-25', 'F', '0989012345');


INSERT INTO CuaHang (MSCH, TENCH, DIACHI, DT) VALUES
('CH001', N'Cửa Hàng Hà Nội', N'Số 1, Hoàn Kiếm, Hà Nội', '0912345678'),
('CH002', N'Cửa Hàng Hồ Chí Minh', N'Số 2, Quận 1, Hồ Chí Minh', '0987654321'),
('CH003', N'Cửa Hàng Đà Nẵng', N'Số 3, Hải Châu, Đà Nẵng', '0901234567'),
('CH004', N'Cửa Hàng Hải Phòng', N'Số 4, Ngô Quyền, Hải Phòng', '0923456789'),
('CH005', N'Cửa Hàng Cần Thơ', N'Số 5, Ninh Kiều, Cần Thơ', '0934567890'),
('CH006', N'Cửa Hàng Quảng Ninh', N'Số 6, Hạ Long, Quảng Ninh', '0945678901'),
('CH007', N'Cửa Hàng Lâm Đồng', N'Số 7, Đà Lạt, Lâm Đồng', '0956789012'),
('CH008', N'Cửa Hàng Thái Nguyên', N'Số 8, TP Thái Nguyên, Thái Nguyên', '0967890123'),
('CH009', N'Cửa Hàng Bình Dương', N'Số 9, Thủ Dầu Một, Bình Dương', '0978901234'),
('CH010', N'Cửa Hàng Nghệ An', N'Số 10, Vinh, Nghệ An', '0989012345');


INSERT INTO LoaiHang (MSLH, TENLOAI) VALUES
('LH001', N'Điện Thoại'),
('LH002', N'Máy Tính Bảng'),
('LH003', N'Laptop'),
('LH004', N'Thời Trang'),
('LH005', N'Gia Dụng'),
('LH006', N'Thực Phẩm'),
('LH007', N'Đồ Uống'),
('LH008', N'Sách'),
('LH009', N'Văn Phòng Phẩm'),
('LH010', N'Thiết Bị Nhà Bếp');



INSERT INTO MatHang (MSMH, MSLH, TENMH) VALUES
('MH001', 'LH001', N'iPhone 13'),
('MH002', 'LH001', N'Samsung Galaxy S21'),
('MH003', 'LH002', N'iPad Pro 11'),
('MH004', 'LH002', N'Samsung Galaxy Tab S7'),
('MH005', 'LH003', N'MacBook Air M1'),
('MH006', 'LH003', N'Dell XPS 13'),
('MH007', 'LH004', N'Áo Thun Nam'),
('MH008', 'LH004', N'Áo Khoác Nữ'),
('MH009', 'LH005', N'Nồi Cơm Điện'),
('MH010', 'LH006', N'Gạo ST25');



INSERT INTO PhieuGiaoHang (SOPG, MSCH, NGAYLAP, MSNV) VALUES
('PG001', 'CH001', '2023-01-10', 'NV001'),
('PG002', 'CH002', '2023-01-15', 'NV002'),
('PG003', 'CH003', '2023-01-20', 'NV003'),
('PG004', 'CH004', '2023-02-05', 'NV004'),
('PG005', 'CH005', '2023-02-10', 'NV005'),
('PG006', 'CH006', '2023-02-15', 'NV006'),
('PG007', 'CH007', '2023-03-01', 'NV007'),
('PG008', 'CH008', '2023-03-05', 'NV008'),
('PG009', 'CH009', '2023-03-10', 'NV009'),
('PG010', 'CH010', '2023-03-15', 'NV010');


INSERT INTO ChiTietPhieuGiaoHang (SOPG, MSMH, SOLUONGGIAO, GIA) VALUES
('PG001', 'MH001', 10, 15000000),
('PG001', 'MH002', 5, 12000000),
('PG002', 'MH003', 8, 18000000),
('PG002', 'MH004', 4, 16000000),
('PG003', 'MH005', 6, 25000000),
('PG003', 'MH006', 3, 22000000),
('PG004', 'MH007', 20, 200000),
('PG005', 'MH008', 15, 300000),
('PG006', 'MH009', 12, 1000000),
('PG007', 'MH010', 30, 18000);


INSERT INTO PhieuThanhToan (SOPTT, MSCH, NGAYLAP, MSNV) VALUES
('PTT001', 'CH001', '2023-01-12', 'NV001'),
('PTT002', 'CH002', '2023-01-18', 'NV002'),
('PTT003', 'CH003', '2023-01-25','NV003'),
('PTT004', 'CH004', '2023-02-08', 'NV004'),
('PTT005', 'CH005', '2023-02-12', 'NV005'),
('PTT006', 'CH006', '2023-02-18', 'NV006'),
('PTT007', 'CH007', '2023-03-03', 'NV007'),
('PTT008', 'CH008', '2023-03-07', 'NV008'),
('PTT009', 'CH009', '2023-03-12', 'NV009'),
('PTT010', 'CH010', '2023-03-18', 'NV010');


INSERT INTO ChiTietPhieuThanhToan (SOPTT, MSMH, SOLUONG, THANHTIEN, DONGIA) VALUES
('PTT001', 'MH001', 2, 30000000, 15000000),
('PTT001', 'MH002', 1, 12000000, 12000000),
('PTT002', 'MH003', 3, 54000000, 18000000),
('PTT002', 'MH004', 2, 32000000, 16000000),
('PTT003', 'MH005', 1, 25000000, 25000000),
('PTT004', 'MH007', 10, 2000000, 200000),
('PTT005', 'MH008', 5, 1500000, 300000),
('PTT006', 'MH009', 2, 2000000, 1000000),
('PTT007', 'MH010', 25, 450000, 18000),
('PTT008', 'MH006', 1, 22000000, 22000000);



INSERT INTO BanHang (MSCH, MSMH, GIABAN, SOLUONGTON) VALUES
('CH001', 'MH001', 15000000, 20),
('CH001', 'MH002', 12000000, 15),
('CH002', 'MH003', 18000000, 10),
('CH002', 'MH004', 16000000, 8),
('CH003', 'MH005', 25000000, 5),
('CH003', 'MH006', 22000000, 7),
('CH004', 'MH007', 200000, 50),
('CH005', 'MH008', 300000, 40),
('CH006', 'MH009', 1000000, 12),
('CH007', 'MH010', 18000, 100);





--7.1.Xem tổng số lượng tồn kho của từng mặt hàng trên toàn hệ thống
SELECT 
    MH.TENMH AS TenMatHang,
    SUM(BH.SOLUONGTON) AS TongSoLuongTon
FROM 
    MatHang MH
JOIN 
    BanHang BH ON MH.MSMH = BH.MSMH
GROUP BY 
    MH.TENMH
ORDER BY TongSoLuongTon DESC;



--2.Lấy thông tin chi tiết các sản phẩm bán chạy nhấtt trong một khoảng thời gian 
SELECT 
    MH.TENMH AS TenMatHang,
    SUM(CTPTT.SOLUONG) AS TongSoLuongBan,
    SUM(CTPTT.THANHTIEN) AS TongDoanhThu
FROM 
    ChiTietPhieuThanhToan CTPTT
JOIN 
    PhieuThanhToan PTT ON CTPTT.SOPTT = PTT.SOPTT
JOIN 
    MatHang MH ON CTPTT.MSMH = MH.MSMH
WHERE 
    PTT.NGAYLAP BETWEEN '2023-01-01' AND '2023-12-31'
GROUP BY 
    MH.TENMH
ORDER BY 
TongSoLuongBan DESC, TongDoanhThu DESC




--3.Tìm các cửa hàng có tổng doanh thu cao nhất và sản phẩm bán chạy nhất tại mỗi cửa hàng dựa trên doanh thu từ sản phẩm đó.

SELECT 
	CH.TENCH AS TenCuaHang, 
	CH.DIACHI AS DiaChiCuaHang, 
	MH.TENMH AS MatHangBanChayNhat, 
	MAX(CTPTT.THANHTIEN) AS DoanhThuMatHang,
	SUM(CTPTT.THANHTIEN) AS TongDoanhThuCuaHang
FROM 
    PhieuThanhToan PTT
JOIN 
    CuaHang CH ON PTT.MSCH = CH.MSCH
JOIN 
   ChiTietPhieuThanhToan CTPTT ON PTT.SOPTT = CTPTT.SOPTT
JOIN MatHang MH ON CTPTT.MSMH = MH.MSMH
GROUP BY 
   CH.TENCH, CH.DIACHI, MH.TENMH
ORDER BY TongDoanhThuCuaHang DESC, DoanhThuMatHang DESC;


--4.Tìm nhân viên xuất sắc dựa trên doanh thu và số lượng phiếu giao hàng
SELECT NV.HOTEN AS TenNhanVien,
       NV.MSNV AS MaNhanVien,
	   COUNT(PGH.SOPG) AS SoLuongPhieuGiao,
	   SUM(CTPGH.GIA * CTPGH.SOLUONGGIAO) AS TongDoanhThuGiaoHang
FROM NhanVien NV
JOIN PhieuGiaoHang PGH ON NV.MSNV = PGH.MSNV
JOIN ChiTietPhieuGiaoHang CTPGH ON PGH.SOPG = CTPGH.SOPG
GROUP BY NV.MSNV, NV.HOTEN
ORDER BY TongDoanhThuGiaoHang DESC, SoLuongPhieuGiao DESC


--5.Tìm các mặt hàng có số lượng tồn kho bằng 0 (đã hết) hoặc gần hết (dưới một ngưỡng xác định, ví dụ: dưới 5 sản phẩm) để ra quyết định nhập hàng bổ sung.
SELECT CH.TENCH AS TenCuaHang,
       MH.TENMH AS TenMatHang, 
	   BH.SOLUONGTON AS SoLuongTon
FROM 
   BanHang BH 
JOIN 
   CuaHang CH ON BH.MSCH = CH.MSCH
JOIN 
   MatHang MH ON BH. MSMH = MH.MSMH
WHERE 
    BH.SOLUONGTON <= 5 
ORDER BY BH.SOLUONGTON ASC


--6.Tìm các sản phẩm bán ra với giá cao nhất vá số lượng lớn nhất 
SELECT MH.TENMH AS TenMatHang,
       SUM(CTPTT.SOLUONG) AS TongSoLuongBan,
	   MAX(CTPTT.DONGIA) AS GiaBanCaoNhat
FROM 
  ChiTietPhieuThanhToan CTPTT
JOIN 
  MatHang MH ON CTPTT.MSMH = MH.MSMH
GROUP BY 
  MH.TENMH 
ORDER BY 
   GiaBanCaoNhat DESC, TongSoLuongBan DESC 



--7.Tìm các nhân viên có hiệu suất bán hàng cao nhất (dựa trên tổng doanh thu bán hàng)
  SELECT 
    NV.HOTEN AS TenNhanVien,
    NV.MSNV AS MaNhanVien,
    SUM(CTPTT.THANHTIEN) AS TongDoanhThuBanHang
FROM 
    PhieuThanhToan PTT
JOIN 
    ChiTietPhieuThanhToan CTPTT ON PTT.SOPTT = CTPTT.SOPTT
JOIN 
    NhanVien NV ON PTT.MSNV = NV.MSNV
GROUP BY 
    NV.MSNV, NV.HOTEN
ORDER BY 
    TongDoanhThuBanHang DESC


--8.Danh sách mặt hàng và giá bán cao nhất của từng mặt hàng
SELECT 
    CH.TENCH AS TenCuaHang,
    SUM(CTPTT.SOLUONG) AS TongSoLuongBanRa
FROM 
    CuaHang CH
JOIN 
    PhieuThanhToan PTT ON CH.MSCH = PTT.MSCH
JOIN 
    ChiTietPhieuThanhToan CTPTT ON PTT.SOPTT = CTPTT.SOPTT
GROUP BY 
    CH.TENCH
ORDER BY 
    TongSoLuongBanRa DESC;

-- 9.Số lượng mặt hàng đã bán ra tại mỗi cửa hàng
SELECT 
    CH.TENCH AS TenCuaHang,
    SUM(CTPTT.SOLUONG) AS TongSoLuongBanRa
FROM 
    CuaHang CH
JOIN 
    PhieuThanhToan PTT ON CH.MSCH = PTT.MSCH
JOIN 
    ChiTietPhieuThanhToan CTPTT ON PTT.SOPTT = CTPTT.SOPTT
GROUP BY 
    CH.TENCH
ORDER BY 
    TongSoLuongBanRa DESC;

--10. Tổng doanh thu của từng mặt hàng
SELECT 
    MH.TENMH AS TenMatHang,
    SUM(CTPTT.THANHTIEN) AS TongDoanhThu
FROM 
    MatHang MH
JOIN 
    ChiTietPhieuThanhToan CTPTT ON MH.MSMH = CTPTT.MSMH
GROUP BY 
    MH.TENMH
ORDER BY 
    TongDoanhThu DESC;