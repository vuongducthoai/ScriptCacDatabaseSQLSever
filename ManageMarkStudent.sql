CREATE DATABASE QLDSV
GO
USE QLDSV
GO

--Tao bang Mon Hoc
CREATE TABLE MonHoc
(
	MaMH NVARCHAR(10) PRIMARY KEY,
	TenMH NVARCHAR(30) NOT NULL,
	SoTinChi INT NOT NULL CHECK((SoTinChi > 0) AND (SoTinChi < 4))
)


-- Tao Bang He Dao Tao
CREATE TABLE HeDT(
	MaHeDT NVARCHAR(10) PRIMARY KEY,
	TenHeDT NVARCHAR(50) NOT NULL,
)


-- Tao Bang Khoa Hoc 
CREATE TABLE KhoaHoc(
	MaKhoaHoc NVARCHAR(5) PRIMARY KEY,
	TenKhoaHoc NVARCHAR(20) NOT NULL
)


-- Tao Bang Khoa 
CREATE TABLE Khoa 
(
	MaKhoa NVARCHAR(10) PRIMARY KEY,
	TenKhoa NVARCHAR(50) NOT NULL,
	DiaChi NVARCHAR(100) NOT NULL,
	DienThoai NVARCHAR(10) NOT NULL
)


--Tao Bang Lop
CREATE TABLE Lop (
	Malop NVARCHAR(10) PRIMARY KEY,
	TenLop NVARCHAR(30) NOT NULL,
	MaKhoa NVARCHAR(10) FOREIGN KEY REFERENCES Khoa(Makhoa),
	MaHeDT NVARCHAR(10) FOREIGN KEY REFERENCES HeDT(MaHeDT),
	MaKhoaHoc NVARCHAR(5) FOREIGN KEY REFERENCES KhoaHoc(MaKhoaHoc)
)


-- Tao Bang Sinh Vien
CREATE TABLE SinhVien (
	MaSV NVARCHAR(15) PRIMARY KEY,
	TenSV NVARCHAR(20),
	GioiTinh bit,
	NgaySinh DATETIME, 
	QueQuan NVARCHAR(50),
	MaLop NVARCHAR(10) FOREIGN KEY REFERENCES Lop(MaLop)
)



-- Tao Bang Diem
CREATE TABLE Diem(
	MaSV NVARCHAR(15) FOREIGN KEY REFERENCES SinhVien(MaSV),
	MaMH nvarchar(10) FOREIGN KEY REFERENCES MonHoc(MaMH),
	HocKy INT CHECK(HocKy > 0) NOT NULL,
	DiemLan1 INT,
	DiemLan2 INT,
	PRIMARY KEY(MaSV, MaMH),
)


---Nhap Du Lieu Cho Bang He Dao Tao --
INSERT INTO HeDT (MaHeDT, TenHeDT) VALUES 
('HDT001', 'Cu nhan Cong nghe Thong tin'),
('HDT002', 'Cu nhan Kinh te Quoc te'),
('HDT003', 'Cu nhan Quan tri Kinh doanh'),
('HDT004', 'Cu nhan Tai chinh Ngan hang'),
('HDT005', 'Cu nhan Ngon ngu Anh'),
('HDT006', 'Cu nhan Ke toan'),
('HDT007', 'Cu nhan Marketing'),
('HDT008', 'Cu nhan Quan ly Nha nuoc'),
('HDT009', 'Cu nhan Luat'),
('HDT010', 'Cu nhan Truyen thong Da phuong tien');


INSERT INTO KhoaHoc (MaKhoaHoc, TenKhoaHoc) VALUES
('KH001', 'Toan cao cap'),
('KH002', 'Vat ly dai cuong'),
('KH003', 'Haa hoc huu co'),
('KH004', 'Lap trinh Python'),
('KH005', 'Kinh te vi mo'),
('KH006', 'Quan tri du an'),
('KH007', 'Tai chinh'),
('KH008', 'Nguyen ly ke toan'),
('KH009', 'Luat dan su'),
('KH010', 'Truyen thong');



INSERT INTO Khoa (MaKhoa, TenKhoa, DiaChi, DienThoai) VALUES
('KH001', 'Khoa Cong nghe Thong tin', '123 Đuong ABC, Quan 1, TP.HCM', '0901234567'),
('KH002', 'Khoa Kinh te', '456 Đuong XYZ, Quan 2, TP.HCM', '0902345678'),
('KH003', 'Khoa Quan tri Kinh doanh', '789 Đuong DEF, Quan 3, TP.HCM', '0903456789'),
('KH004', 'Khoa Tai chinh - Ngan hang', '101 Đuong GHI, Quan 4, TP.HCM', '0904567890'),
('KH005', 'Khoa Ngon ngu Anh', '102 Đuong JKL, Quan 5, TP.HCM', '0905678901'),
('KH006', 'Khoa Ke toan', '103 Đuong MNO, Quan 6, TP.HCM', '0906789012'),
('KH007', 'Khoa Marketing', '104 Đuong PQR, Quan 7, TP.HCM', '0907890123'),
('KH008', 'Khoa Quan ly Nha nuoc', '105 Đuong STU, Quan 8, TP.HCM', '0908901234'),
('KH009', 'Khoa Luat', '106 Đuong VWX, Quan 9, TP.HCM', '0909012345'),
('KH010', 'Khoa Truyen thong', '107 Đuong YZ, Quan 10, TP.HCM', '0900123456');



INSERT INTO Lop (MaLop, TenLop, MaKhoa, MaHeDT, MaKhoaHoc) VALUES
('L001', 'Lop Cong nghe 1', 'KH001', 'HDT001', 'KH001'),
('L002', 'Lop Kinh te 1', 'KH002', 'HDT002', 'KH002'),
('L003', 'Lop QTKD 1', 'KH003', 'HDT003', 'KH003'),
('L004', 'Lop TCNH 1', 'KH004', 'HDT004', 'KH004'),
('L005', 'Lop Ngon ngu Anh 1', 'KH005', 'HDT005', 'KH005'),
('L006', 'Lop Ke toan 1', 'KH006', 'HDT006', 'KH006'),
('L007', 'Lop Marketing 1', 'KH007', 'HDT007', 'KH007'),
('L008', 'Lop QLNN 1', 'KH008', 'HDT008', 'KH008'),
('L009', 'Lop Luat 1', 'KH009', 'HDT009', 'KH009'),
('L010', 'Lop TTĐPT 1', 'KH010', 'HDT010', 'KH010');





INSERT INTO SinhVien (MaSV, TenSV, GioiTinh, NgaySinh, QueQuan, MaLop) VALUES
('SV001', 'Nguyen Van A', 1, '2000-05-15', 'Ha Noi', 'L001'),
('SV002', 'Tran Thi B', 0, '2001-07-20', 'TP. Ho Chi Minh', 'L002'),
('SV003', 'Le Van C', 1, '1999-09-12', 'Đa Nang', 'L003'),
('SV004', 'Pham Thi D', 0, '2002-03-25', 'Can Tho', 'L004'),
('SV005', 'Nguyen Van E', 1, '2001-10-10', 'Hai Phong', 'L005'),
('SV006', 'Tran Thi F', 0, '2000-11-30', 'Hue', 'L006'),
('SV007', 'Le Van G', 1, '1998-08-18', 'Quang Ninh', 'L007'),
('SV008', 'Pham Thi H', 0, '2001-04-01', 'Nha Trang', 'L008'),
('SV009', 'Nguyen Van I', 1, '2002-02-14', 'Bac Ninh', 'L009'),
('SV010', 'Tran Thi K', 0, '1999-12-22', 'Đong Nai', 'L010');



INSERT INTO MonHoc (MaMH, TenMH, SoTinChi) VALUES
('MH001', 'Toan cao cap', 1),
('MH002', 'Vat ly dai cuong', 3),
('MH003', 'Hoa hoc huu co', 3),
('MH004', 'Lap trinh C++', 3),
('MH005', 'Kinh te vi mo', 2),
('MH006', 'Nguyen ly ke toan', 3),
('MH007', 'Quan tri doanh nghiep', 3),
('MH008', 'Marketing can ban', 3),
('MH009', 'Lich su Đang', 3),
('MH010', 'Phap luat dai cuong', 3);






INSERT INTO Diem (MaSV, MaMH, HocKy, DiemLan1, DiemLan2) VALUES
('SV001', 'MH001', 1, 8, 9),
('SV002', 'MH002', 1, 7, NULL),
('SV003', 'MH003', 1, 5, 6),
('SV004', 'MH004', 1, 9, NULL),
('SV005', 'MH005', 1, 6, 7),
('SV006', 'MH006', 2, 8, 9),
('SV007', 'MH007', 2, 7, 8),
('SV008', 'MH008', 2, 6, NULL),
('SV009', 'MH009', 2, 9, 10),
('SV010', 'MH010', 2, 8, NULL);


CREATE PROC show_sv 
as
	SELECT MaSV, TenSV, NgaySinh, GioiTinh, TenLop
	FROM SinhVien as s, Lop as l
	WHERE s.MaLop = l.Malop

EXEC show_sv 


CREATE PROC show_top3sv @TenLop NVARCHAR(100), @TenMon NVARCHAR(100), @diem INT
AS
BEGIN
    SELECT TOP 3 TenSV, TenLop, DiemLan1, TenMH
    FROM Lop AS l
    INNER JOIN SinhVien AS s ON l.MaLop = s.MaLop
    INNER JOIN Diem AS d ON s.MaSV = d.MaSV
    INNER JOIN MonHoc AS m ON d.MaMH = m.MaMH
    WHERE TenLop =@TenLop AND m.TenMH =@TenMon AND d.DiemLan1 >= @diem
END;

EXECUTE show_top3sv 'Lop Cong nghe 2', 'Toan cao cap', 7


CREATE PROC show_svA19 @TenSV NVARCHAR(50), @Tuoi INT
AS 
   SELECT MaSV, TenSV, NgaySinh, QueQuan
   FROM SinhVien
   WHERE (TenSV LIKE 'Nguyen Van A') AND (YEAR(GETDATE()) - YEAR(NgaySinh) > @Tuoi)

EXEC show_svA19 'Nguyen Van A', 19



CREATE PROC show_svcntt @TenKhoa NVARCHAR(50)
AS 
BEGIN 
    SELECT TenSV, TenLop, NgaySinh, QueQuan, NgaySinh
	FROM SinhVien as s 
	INNER JOIN Lop as l ON s.MaLop = l.Malop
	INNER JOIN Khoa as k ON l.MaKhoa = k.MaKhoa
	WHERE k.TenKhoa = @TenKhoa
END

EXEC show_svcntt 'Khoa Cong nghe Thong tin'


CREATE PROC show_diemSV @diem INT
AS 
BEGIN 
   SELECT s.MaSV, TenSV, TenMH, DiemLan1, DiemLan2
   FROM SinhVien as s 
   INNER JOIN Diem as d  ON s.MaSV = d.MaSV
   INNER JOIN MonHoc as m ON d.MaMH = d.MaMH
   WHERE (d.DiemLan2 < @diem OR d.DiemLan1 < @diem)
END;
DROP PROC show_diemSV

EXEC show_diemSV 5


CREATE PROC Dem_SLSV
AS 
BEGIN 
    SELECT TenKhoa,COUNT(*) as 'SLSV'
	FROM SinhVien as s 
	INNER JOIN Lop as l ON s.MaLop = l.Malop 
	INNER JOIN Khoa as k ON l.MaKhoa = k.MaKhoa
	GROUP BY k.TenKhoa
	ORDER BY TenKhoa DESC
END 

EXEC Dem_SLSV 



CREATE PROC show_MinDiem 
AS 
BEGIN 
	SELECT m.TenMH, Min(d.DiemLan1) as MinDiem
	FROM Diem as d 
	INNER JOIN MonHoc as m ON d.MaMH = m.MaMH
	GROUP BY M.TenMH
END  

EXEC show_MinDiem


CREATE PROC sp_insSinhVien
(
	@MaSV nvarchar(15),
	@TenSV NVARCHAR(50),
	@GioiTinh bit,
	@NgaySinh DATE,
	@QueQuan NVARCHAR(50),
	@MaLop NVARCHAR(10)
)
AS
BEGIN 
	INSERT INTO SinhVien(MaSV, TenSV, GioiTinh, NgaySinh, QueQuan, MaLop)
	VALUES (@Masv, @TenSV, @GioiTinh, @NgaySinh, @QueQuan, @MaLop)
END;

--Thuc Thi
EXEC sp_insSinhVien 'SV011', 'Le Van C', 1, '2022-01-01', 'Vung Tau', 'L010'




CREATE PROC update_Lop(
	@MaLop NVARCHAR(10),
	@TenLop NVARCHAR(30),
	@MaKhoa NVARCHAR(10),
	@MaHeDT NVARCHAR(20),
	@MaKhoaHoc NVARCHAR(10)
)
AS 
BEGIN 
  UPDATE Lop 
  SET TenLop = @TenLop,
      MaKhoa = @MaKhoa,
	  MaHeDT = @MaHeDT, 
	  MaKhoaHoc = @MaKhoaHoc
	  WHERE Malop = @MaLop
END;

--Thuc Thi
EXEC update_Lop 'L001', 'Lop Cong nghe 2', 'KH001', 'HDT001', 'KH001'

CREATE PROC del_SV
(
  @MaSV NVARCHAR(20)
)
AS 
BEGIN 
    DELETE FROM SinhVien 
	WHERE MaSV = @MaSV
END;

EXEC del_SV 'SV011'



CREATE PROC show_khoa
AS
BEGIN 
   SELECT * FROM Khoa 
END




CREATE TRIGGER trg_PreventDeleteMonHoc
ON MonHoc 
INSTEAD OF DELETE 
AS 
BEGIN 
	PRINT 'Không thể xóa môn học. Hành động này bị ngăn chặn.';
	--Hủy bỏ việc xóa môn học
	ROLLBACK TRANSACTION
END;


-- Tao Trigger insert Bảng Điểm 
CREATE TRIGGER triginsert_Diem
ON Diem 
FOR INSERT, UPDATE
AS 
BEGIN
    DECLARE @DiemLan1 INT, @DiemLan2 INT;
    
    -- Kiểm tra tất cả các bản ghi trong bảng inserted
    IF EXISTS (
        SELECT 1
        FROM inserted
        WHERE DiemLan1 < 0 OR DiemLan1 > 10 OR DiemLan2 < 0 OR DiemLan2 > 10
    )
    BEGIN
        PRINT 'Sai giá trị điểm';
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        PRINT 'Succesfully';
    END
END;



 -- Tao trigger de tat cac truong trong bang sv phai nhap

  Create Trigger trginsert_Sinhvien
  on Sinhvien
  for insert
  as
  begin
  
  Declare @tensv nvarchar(20)
  Declare @quequan nvarchar(50)
  Declare @gioitinh bit
  Declare @ngaysinh datetime

  select @tensv=inserted.tensv,
         @quequan=inserted.quequan,
         @gioitinh=inserted.gioitinh,
         @ngaysinh=inserted.ngaysinh
  From Inserted
  if((@tensv is null) or (@quequan is null)
    or (@gioitinh is null) or (@ngaysinh is null))
    begin
    print'Ban phai nhap day du cac thong tin'
    print'qua trinh them data khong thanh cong'
    rollback tran
    end
  else
    begin
    print'Successfully'
    end
end



SELECT SV.MaSV, SV.TenSV, L.TenLop, K.TenKhoa
FROM SinhVien SV
JOIN Lop L ON SV.MaLop = L.MaLop
JOIN Khoa K ON L.MaKhoa = K.MaKhoa;


SELECT D.MaSV, SV.TenSV, D.HocKy, AVG((D.DiemLan1 + D.DiemLan2) / 2) AS DiemTrungBinh
FROM Diem D
JOIN SinhVien SV ON D.MaSV = SV.MaSV
GROUP BY D.MaSV, SV.TenSV, D.HocKy
ORDER BY DiemTrungBinh DESC;


SELECT MH.TenMH, COUNT(D.MaSV) AS SoLuongSinhVien
FROM MonHoc MH
LEFT JOIN Diem D ON MH.MaMH = D.MaMH
GROUP BY MH.TenMH;


SELECT SV.MaSV, SV.TenSV, MH.TenMH
FROM Diem D
JOIN SinhVien SV ON D.MaSV = SV.MaSV
JOIN MonHoc MH ON D.MaMH = MH.MaMH
WHERE D.DiemLan1 IS NULL OR D.DiemLan2 IS NULL;


SELECT SV.TenSV, SV.GioiTinh, SV.NgaySinh, L.TenLop, K.TenKhoa, H.TenHeDT
FROM SinhVien SV
JOIN Lop L ON SV.MaLop = L.MaLop
JOIN Khoa K ON L.MaKhoa = K.MaKhoa
JOIN HeDT H ON L.MaHeDT = H.MaHeDT
WHERE H.TenHeDT = N'Hệ chính quy';
