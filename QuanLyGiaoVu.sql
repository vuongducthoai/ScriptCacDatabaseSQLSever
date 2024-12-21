CREATE DATABASE QuanLyGiaoVu_Nhom10
USE QuanLyGiaoVu_Nhom10

--Tạo Bảng KHOA 
CREATE TABLE KHOA ( 
    MAKHOA VARCHAR(4) PRIMARY KEY, 
	TENKHOA VARCHAR(40), 
	NGTLAP SMALLDATETIME, 
	TRGKHOA CHAR(4)
);

--Tạo Bảng MONHOC 
CREATE TABLE MONHOC ( 
	MAMH VARCHAR(10) PRIMARY KEY, 
	TENMH VARCHAR(40), 
	TCHI TINYINT, 
	TCTH TINYINT, 
	MAKHOA VARCHAR(4)  FOREIGN KEY  REFERENCES KHOA(MAKHOA)
);


-- Tạo bảng DIEUKIEN 
CREATE TABLE DIEUKIEN ( 
	MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH),
	MAMH_TRUOC VARCHAR(10) REFERENCES MONHOC(MAMH), 
	PRIMARY KEY (MAMH_TRUOC, MAMH) 
); 



-- Tạo bảng GIAOVIEN 
CREATE TABLE GIAOVIEN ( 
	MAGV CHAR(4) PRIMARY KEY, 
	HOTEN VARCHAR(40), 
	HOCVI VARCHAR(10),
	HOCHAM VARCHAR(10),
	GIOITINH VARCHAR(3), 
	NGAYSINH SMALLDATETIME, 
	NGVL SMALLDATETIME, 
	HESO NUMERIC(4,2),
	MUCLUONG MONEY, 
	MAKHOA VARCHAR(4) FOREIGN KEY REFERENCES KHOA(MAKHOA)
);


-- Tạo bảng LOP 
CREATE TABLE LOP ( 
	MALOP CHAR(3) PRIMARY KEY,
	TENLOP VARCHAR(40), 
	TRGLOP CHAR(5), 
	SISO tinyint,
	MAGVCN CHAR(4) FOREIGN KEY REFERENCES GIAOVIEN(MAGV)
);


-- Tạo bảng HOCVIEN
CREATE TABLE HOCVIEN ( 
	MAHV CHAR(5) PRIMARY KEY,
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGAYSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40), 
	MALOP CHAR(3) FOREIGN KEY REFERENCES LOP(MALOP), 
);

ALTER TABLE LOP 
ADD FOREIGN KEY (TRGLOP) REFERENCES  HOCVIEN(MAHV)


-- Tạo bảng GIANGDAY 
CREATE TABLE GIANGDAY ( 
   MALOP CHAR(3) FOREIGN KEY REFERENCES LOP(MALOP), 
   MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH), 
   MAGV CHAR(4) FOREIGN KEY REFERENCES GIAOVIEN(MAGV),
   HOCKY TINYINT,
   NAMHOC SMALLINT,
   TUNGAY SMALLDATETIME, 
   DENNGAY SMALLDATETIME,
   PRIMARY KEY (MAMH, MALOP)
); 


-- Tạo bảng KETQUATHI
CREATE TABLE KETQUATHI ( 
    MAHV CHAR(5) FOREIGN KEY REFERENCES HOCVIEN(MAHV), 
	MAMH VARCHAR(10) FOREIGN KEY REFERENCES MONHOC(MAMH), 
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4,2), 
	KQUA VARCHAR(10),
	PRIMARY KEY (MAHV, MAMH, LANTHI)
);

ALTER TABLE KHOA 
ADD FOREIGN KEY (TRGKHOA) REFERENCES GIAOVIEN(MAGV)



INSERT INTO KHOA (MAKHOA, TENKHOA, NGTLAP, TRGKHOA)
VALUES 
('KHMT', 'Khoa hoc may tinh', '2005-06-07', 'GV01'),
('HTTT', 'He thong thong tin', '2005-06-07', 'GV02'),
('CNPM', 'Cong nghe phan mem', '2005-06-07', 'GV04'),
('MTT', 'Mang va truyen thong', '2005-10-20', 'GV03'),
('KTMT', 'Ky thuat may tinh', '2005-12-20', NULL);


INSERT INTO GIAOVIEN (MAGV, HOTEN, HOCVI, HOCHAM, GIOITINH, NGAYSINH, NGVL, HESO, MUCLUONG, MAKHOA)
VALUES
('GV01', 'Do Ngo Anh Thu', 'PTS', 'GS', 'Nu', '2000-05-02', '2025-11-11', 5.00, 2250000, 'KHMT'),
('GV02', 'Tran Thi Thu Nhung', 'TS', 'PGS', 'Nu', '2000-12-17', '2025-04-20', 4.50, 2025000, 'HTTT'),
('GV03', 'Nguyen Thanh Nhan', 'TS', 'GS', 'Nam', '2000-08-01', '2025-09-23', 4.00, 1800000, 'CNPM'),
('GV04', 'Tran Nam Son', 'TS', 'PGS', 'Nam', '1961-2-22', '2005-01-12', 4.50, 2025000, 'KTMT'),
('GV05', 'Mai Thanh Danh', 'ThS', 'GV', 'Nam', '1958-03-12', '2005-01-12', 3.00, 1350000, 'HTTT'),
('GV06', 'Tran Doan Hung', 'TS', 'GV', 'Nam', '1953-03-11', '2005-01-12', 4.50, 2025000, 'KHMT'),
('GV07', 'Nguyen Minh Tien', 'ThS', 'GV', 'Nam', '1971-11-23', '2005-03-01', 4.00, 1800000, 'KHMT'),
('GV08', 'Le Thi Tran', 'KS', NULL, 'Nu', '1974-03-26', '2005-03-01', 1.69, 760500, 'KHMT'),
('GV09', 'Nguyen To Lan', 'ThS', 'GV', 'Nu', '1966-12-31', '2005-03-01', 4.00, 1800000, 'HTTT'),
('GV10', 'Le Tran Anh Loan', 'KS', NULL, 'Nu', '1972-07-17', '2005-03-01', 1.86, 837000, 'CNPM'),
('GV11', 'Ho Thanh Tung', 'CN', 'GV', 'Nam', '1980-01-12', '2005-05-15', 2.67, 1201500, 'MTT'),
('GV12', 'Tran Van Anh', 'CN', NULL, 'Nu', '1981-03-29', '2005-05-15', 1.69, 760500, 'CNPM'),
('GV13', 'Nguyen Linh Dan', 'CN', NULL, 'Nu', '1980-05-23', '2005-05-15', 1.69, 760500, 'KHMT'),
('GV14', 'Truong Minh Chau', 'ThS', 'GV', 'Nu', '1975-11-30', '2005-05-15', 3.00, 1350000, 'MTT'),
('GV15', 'Le Ha Thanh', 'Ths', 'GV', 'Nam', '1975-05-04', '2005-05-15', 3.00, 1350000, 'KHMT');

INSERT INTO LOP (MALOP, TENLOP, TRGLOP, SISO, MAGVCN)
VALUES 
('K11', 'Lop 1 khoa 1', 'K1108', 11, 'GV07'),
('K12', 'Lop 2 khoa 1', 'K1205', 12, 'GV09'),
('K13', 'Lop 3 khoa 1', 'K1305', 12, 'GV14');


INSERT INTO MONHOC (MAMH, TENMH, TCHI, TCTH, MAKHOA)
VALUES 
('THDC', 'Tin hoc dai cuong', 4, 1, 'KHMT'),
('CTRR', 'Cau truc roi rac', 5, 0, 'KHMT'),
('CSDL', 'Co so du lieu', 3, 1, 'HTTT'),
('CTDLGT', 'Cau truc du lieu va giai thuat', 3, 1, 'KHMT'),
('PTTKTT', 'Phan tich thiet ke thuat toan', 3, 0, 'KHMT'),
('DHMT', 'Do hoa may tinh', 3, 1, 'KHMT'),
('KTMT', 'Kien truc may tinh', 3, 0, 'KTMT'),
('TKCSDL', 'Thiet ke co so du lieu', 3, 1, 'HTTT'),
('PTTKHTTT', 'Phan tich thiet ke he thong thong tin', 4, 1, 'HTTT'),
('HDH', 'He dieu hanh', 4, 0, 'KTMT'),
('NMCNPM', 'Nhap mon cong nghe phan mem', 3, 0, 'CNPM'),
('LTCFW', 'Lap trinh C for win', 3, 1, 'CNPM'),
('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM');


INSERT INTO GIANGDAY (MALOP, MAMH, MAGV, HOCKY, NAMHOC, TUNGAY, DENNGAY)
VALUES 
('K11', 'THDC', 'GV07', 1, 2006, '2006-02-01', '2006-05-12'),
('K12', 'THDC', 'GV06', 1, 2006, '2006-02-01', '2006-05-12'),
('K13', 'THDC', 'GV15', 1, 2006, '2006-02-01', '2006-05-12'),
('K11', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K12', 'CTRR', 'GV02', 1, 2006, '2006-01-09', '2006-05-17'),
('K13', 'CTRR', 'GV08', 1, 2006, '2006-01-09', '2006-05-17'),
('K11', 'CSDL', 'GV05', 2, 2006, '2006-06-01', '2006-07-15'),
('K12', 'CSDL', 'GV09', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CTDLGT', 'GV15', 2, 2006, '2006-06-01', '2006-07-15'),
('K13', 'CSDL', 'GV05', 3, 2006, '2006-08-01', '2006-12-15'),
('K13', 'DHMT', 'GV07', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K12', 'CTDLGT', 'GV15', 3, 2006, '2006-08-01', '2006-12-15'),
('K11', 'HDH', 'GV04', 1, 2007, '2006-01-02', '2007-02-18'),
('K12', 'HDH', 'GV04', 1, 2007, '2006-01-02', '2007-03-20'),
('K11', 'DHMT', 'GV07', 1, 2007, '2006-02-18', '2007-03-20');



INSERT INTO DIEUKIEN (MAMH, MAMH_TRUOC)
VALUES 
('CSDL', 'CTRR'),
('CSDL', 'CTDLGT'),
('CTDLGT', 'THDC'),
('PTTKTT', 'THDC'),
('PTTKTT', 'CTDLGT'),
('DHMT', 'THDC'),
('LTHDT', 'THDC'),
('PTTKHTTT', 'CSDL');


INSERT INTO HOCVIEN (MAHV, HO, TEN, NGAYSINH, GIOITINH, NOISINH, MALOP) VALUES
('K1101', 'Nguyen Van', 'A', '1986-01-27', 'Nam', 'TpHCM', 'K11'),
('K1102', 'Tran Ngoc', 'Han', '1986-03-14', 'Nu', 'Kien Giang', 'K11'),
('K1103', 'Ha Duy', 'Lap', '1986-04-18', 'Nam', 'Nghe An', 'K11'),
('K1104', 'Tran Ngoc', 'Linh', '1986-03-30', 'Nu', 'Tay Ninh', 'K11'),
('K1105', 'Tran Minh', 'Long', '1986-02-27', 'Nam', 'TpHCM', 'K11'),
('K1106', 'Le Nhat', 'Minh', '1986-02-24', 'Nam', 'TpHCM', 'K11'),
('K1107', 'Nguyen Nhu', 'Nhut', '1986-01-27', 'Nam', 'Ha Noi', 'K11'),
('K1108', 'Nguyen Manh', 'Tam', '1986-02-27', 'Nam', 'Kien Giang', 'K11'),
('K1109', 'Phan Thi Thanh', 'Tam', '1986-01-27', 'Nu', 'Vinh Long', 'K11'),
('K1110', 'Le Hoai', 'Thuong', '1986-02-05', 'Nu', 'Can Tho', 'K11'),
('K1111', 'Le Ha', 'Vinh', '1986-12-25', 'Nam', 'Vinh Long', 'K11'),
('K1201', 'Nguyen Van', 'B', '1986-02-11', 'Nam', 'TpHCM', 'K12'),
('K1202', 'Nguyen Thi Kim', 'Duyen', '1986-01-18', 'Nu', 'TpHCM', 'K12'),
('K1203', 'Tran Thi Kim', 'Duyen', '1986-09-17', 'Nu', 'TpHCM', 'K12'),
('K1204', 'Truong My', 'Hanh', '1986-05-19', 'Nu', 'Dong Nai', 'K12'),
('K1205', 'Nguyen Thanh', 'Nam', '1986-04-17', 'Nam', 'TpHCM', 'K12');



INSERT INTO HOCVIEN (MAHV, HO, TEN, NGAYSINH, GIOITINH, NOISINH, MALOP) VALUES
('K1206', 'Nguyen Thi Truc', 'Thanh', '1986-03-04', 'Nu', 'Kien Giang', 'K12'),
('K1207', 'Tran Thi Bich', 'Thuy', '1986-02-08', 'Nu', 'Nghe An', 'K12'),
('K1208', 'Huynh Thi Kim', 'Trieu', '1986-04-08', 'Nu', 'Tay Ninh', 'K12'),
('K1209', 'Pham Thanh', 'Trieu', '1986-02-23', 'Nam', 'TpHCM', 'K12'),
('K1210', 'Ngo Thanh', 'Tuan', '1986-02-14', 'Nam', 'TpHCM', 'K12'),
('K1211', 'Do Thi', 'Xuan', '1986-03-09', 'Nu', 'Ha Noi', 'K12'),
('K1212', 'Le Thi Phi', 'Yen', '1986-03-12', 'Nu', 'TpHCM', 'K12'),
('K1301', 'Nguyen Thi Kim', 'Cuc', '1986-06-09', 'Nu', 'Kien Giang', 'K13'),
('K1302', 'Truong Thi My', 'Hien', '1986-03-18', 'Nu', 'Nghe An', 'K13'),
('K1303', 'Le Duc', 'Hien', '1986-03-21', 'Nam', 'Tay Ninh', 'K13'),
('K1304', 'Le Quang', 'Hien', '1986-04-18', 'Nam', 'TpHCM', 'K13'),
('K1305', 'Le Thi', 'Huong', '1986-03-27', 'Nu', 'TpHCM', 'K13'),
('K1306', 'Nguyen Thai', 'Huu', '1986-03-30', 'Nam', 'Ha Noi', 'K13'),
('K1307', 'Tran Minh', 'Man', '1986-05-28', 'Nam', 'TpHCM', 'K13'),
('K1308', 'Nguyen Hieu', 'Nghia', '1987-04-08', 'Nam', 'Kien Giang', 'K13'),
('K1309', 'Nguyen Trung', 'Nghia', '1986-01-18', 'Nam', 'Nghe An', 'K13'),
('K1310', 'Tran Thi Hong', 'Tham', '1986-04-22', 'Nu', 'Tay Ninh', 'K13'),
('K1311', 'Tran Minh', 'Thuc', '1986-04-04', 'Nam', 'TpHCM', 'K13'),
('K1312', 'Nguyen Thi Kim', 'Yen', '1986-09-07', 'Nu', 'TpHCM', 'K13');




INSERT INTO KETQUATHI (MAHV, MAMH, LANTHI, NGTHI, DIEM, KQUA) 
VALUES 
('K1101', 'CSDL', 1, '2006-7-20', 10.00, 'Dat'),
('K1101', 'CTDLGT', 1, '2006-12-28', 9.00, 'Dat'),
('K1101', 'THDC', 1, '2006-12-20', 9.00, 'Dat'),
('K1101', 'CTRR', 1, '2006-05-13', 9.50, 'Dat'),
('K1102', 'CSDL', 1, '2006-07-20', 4.00, 'Khong Dat'),
('K1102', 'CSDL', 2, '2006-7-27', 4.25, 'Khong Dat'),
('K1102', 'CSDL', 3, '2006-8-10', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 1, '2006-12-26', 4.50, 'Khong Dat'),
('K1102', 'CTDLGT', 2, '2007-1-5', 4.00, 'Khong Dat'),
('K1102', 'CTDLGT', 3, '2007-01-15', 6.00, 'Dat'),
('K1102', 'THDC', 1, '2006-5-20', 5.00, 'Dat'),
('K1103', 'CSDL', 1, '2006-07-20', 3.50, 'Khong Dat'),
('K1103', 'CSDL', 2, '2006-07-27', 8.25, 'Dat'),
('K1103', 'CTDLGT', 1, '2006-12-28', 7.00, 'Dạt'),
('K1103', 'THDC', 1, '2006-05-20', 6.50, 'Dạt'),
('K1103', 'CTRR', 1, '2006-5-13', 7.00, 'Dat'),
('K1104', 'CSDL', 1, '2006-07-20', 3.75, 'Khong Dạt'),
('K1104', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1104', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 1, '2006-05-13', 4.00, 'Khong Dat'),
('K1104', 'CTRR', 2, '2006-05-20', 3.50, 'Khong Dạt'),
('K1104', 'CTRR', 3, '2006-06-30', 4.00, 'Khong Dat'),
('K1201', 'CSDL', 1, '2006-07-20', 6.00, 'Dạt'),
('K1201', 'CTDLGT', 1, '2006-12-28', 5.00, 'Dạt'),
('K1201', 'THDC', 1, '2006-05-20', 8.50, 'Dạt'),
('K1201', 'CTRR', 1, '2006-05-13', 9.00, 'Dạt'),
('K1202', 'CSDL', 1, '2006-07-20', 8.00, 'Dạt'),
('K1202', 'CTDLGT', 1, '2006-12-28', 4.00, 'Khong Dat'),
('K1202', 'CTDLGT', 2, '2006-01-05', 5.00, 'Dat'),
('K1202', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'THDC', 2, '2006-05-27', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 1, '2006-05-13', 3.00, 'Khong Dạt'),
('K1202', 'CTRR', 2, '2006-05-20', 4.00, 'Khong Dat'),
('K1202', 'CTRR', 3, '2006-06-30', 6.25, 'Dat'),
('K1203', 'CSDL', 1, '2006-07-20', 9.25, 'Dat'),
('K1203', 'CTDLGT', 1, '2006-12-28', 9.50, 'Dat'),
('K1203', 'THDC', 1, '2006-05-20', 10.00, 'Dat'),
('K1203', 'CTRR', 1, '2006-05-13', 10.00, 'Dat'),
('K1204', 'CSDL', 1, '2006-07-20', 8.50, 'Dat'),
('K1204', 'CTDLGT', 1, '2006-12-28', 6.75, 'Dat'),
('K1204', 'THDC', 1, '2006-05-20', 4.00, 'Khong Dat'),
('K1204', 'CTRR', 1, '2006-05-13', 8.00, 'Dạt'),
('K1301', 'CSDL', 1, '2006-12-20', 4.25, 'Khong Dat'),
('K1301', 'CTDLGT', 1, '2006-07-25', 8.00, 'Dat'),
('K1301', 'THDC', 1, '2006-05-20', 7.75, 'Dat'),
('K1301', 'CTRR', 1, '2006-05-13', 8.00, 'Dạt'),
('K1302', 'CSDL', 1, '2006-12-20', 6.75, 'Dat'),
('K1302', 'CTDLGT', 1, '2006-07-25', 5.00, 'Dat'),
('K1302', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1302', 'CTRR', 1, '2006-05-13', 8.50, 'Dat'),
('K1303', 'CSDL', 1, '2006-12-20', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 1, '2006-07-25', 4.50, 'Khong Dat'),
('K1303', 'CTDLGT', 2, '2006-08-07', 4.00, 'Khong Dat'),
('K1303', 'CTDLGT', 3, '2006-08-15', 4.25, 'Khong Dat'),
('K1303', 'THDC', 1, '2006-05-20', 4.50, 'Khong Dat'),
('K1303', 'CTRR', 1, '2006-05-13', 3.25, 'Khong Dat'),
('K1303', 'CTRR', 2, '2006-05-20', 5.00, 'Dat'),
('K1304', 'CSDL', 1, '2006-12-20', 7.75, 'Dat'),
('K1304', 'CTDLGT', 1, '2006-07-25', 9.75, 'Dat'),
('K1304', 'THDC', 1, '2006-05-20', 5.50, 'Dat'),
('K1304', 'CTRR', 1, '2006-05-13', 5.00, 'Dat'),
('K1305', 'CSDL', 1, '2006-12-20', 9.25, 'Dat'),
('K1305', 'CTDLGT', 1, '2006-07-25', 10.00, 'Dat'),
('K1305', 'THDC', 1, '2006-05-20', 8.00, 'Dat'),
('K1305', 'CTRR', 1, '2006-05-13', 10.00, 'Dat');




-- I. Ngon ngu dinh nghia du lieu (Data Defination Language)
--1. 
ALTER TABLE HOCVIEN 
ADD GHICHU NVARCHAR(255)

ALTER TABLE HOCVIEN 
ADD DIEMTB FLOAT

ALTER TABLE HOCVIEN 
ADD XEPLOAI VARCHAR(15)



--II. Ngon ngu thao tac du lieu
--1. Tang he so luong them 0.2 cho nhung giao vien la truong khoa
UPDATE GIAOVIEN 
SET HESO  = HESO + 0.2
WHERE MAGV IN (SELECT TRGKHOA FROM KHOA WHERE TRGKHOA IS NOT NULL)


--2. Cap nhat gia tri diem trung binh tat cac mon hoc (DIEMTB) cua moi hoc vien ...
WITH 
   LastAttemp AS (
	SELECT 
	   MAHV, 
	   MAMH, 
	   DIEM, 
	   ROW_NUMBER() OVER (PARTITION BY MAHV, MAMH ORDER BY LANTHI DESC) AS RowNum
	FROM KETQUATHI
), 
    AverageScore  AS (
	SELECT
		MAHV, 
		AVG(DIEM) AS DIEMTRUNGBINH
    FROM LastAttemp
	WHERE RowNum = 1
	GROUP BY MAHV
)
UPDATE hv
SET hv.DIEMTB = Av.DIEMTRUNGBINH
FROM HOCVIEN hv
INNER JOIN AverageScore Av
    ON hv.MAHV = Av.MAHV;



--3. Cap nhat gia tri cho cot GHI CHU la 'Cam Thi' ...
UPDATE HOCVIEN 
SET GHICHU = 'Cam thi'
WHERE MAHV IN(
SELECT MAHV FROM KETQUATHI
WHERE LANTHI = 3  AND DIEM < 5)



UPDATE HOCVIEN 
SET XEPLOAI =
	CASE 
	   WHEN DIEMTB >= 9 THEN 'XS'
	   WHEN DIEMTB < 9 AND DIEMTB >= 8 THEN 'G'
	   WHEN DIEMTB < 8 AND DIEMTB >= 6.5 THEN 'K'
	   WHEN DIEMTB < 6.5 AND DIEMTB >= 5 THEN 'TB'
	   WHEN DIEMTB < 5  THEN 'Y'
    END




--III. Ngon ngu truy van du lieu 
--1. In ra danh sach (ma hoc vien, ho ten ngay sinh, ma lop) lop truong cua cac lop 
SELECT h.MAHV, h.HO, h.TEN, h.NGAYSINH, L.MALOP FROM 
LOP as l INNER JOIN HOCVIEN as h  
ON l.TRGLOP = h.MAHV


--2. In ra bang diem khi thi (ma hoc vien, ho ten, lan thi, diem so) mon CTRR cua lop "K12" sap xep theo ten, ho hoc vien 
SELECT h.MAHV, h.HO, h.TEN, k.LANTHI, k.DIEM FROM KETQUATHI k 
INNER JOIN HOCVIEN h 
ON K.MAHV = H.MAHV
INNER JOIN LOP l 
ON l.MALOP = h.MALOP
WHERE l.MALOP = 'K12' AND k.MAMH = 'CTRR'


--3. In ra danh sach hoc vien (ma hoc vien, ho ten) va nhung mon hoc ma hoc vien do thi lan thu nhat da dat
SELECT H.MAHV, HO, TEN, K.MAMH FROM 
HOCVIEN h 
INNER JOIN KETQUATHI k
ON h.MAHV = k.MAHV
WHERE k.LANTHI = 1 AND k.DIEM > 5
ORDER BY TEN, HO



--4. In ra danh sach (ma hoc vien, ho ten) cua lop "K11" thi mon CTRR khong dat (o ln thi 1)
SELECT h.MAHV, h.HO, h.TEN FROM KETQUATHI k 
INNER JOIN HOCVIEN h 
ON K.MAHV = H.MAHV
INNER JOIN LOP l 
ON l.MALOP = h.MALOP
WHERE l.MALOP = 'K11' AND k.LANTHI = 1 AND k.MAMH = 'CTRR' AND k.DIEM < 5



--5. Danh sach hoc vien (ma hoc vien, ho ten) cua lop "K" thi mon CTRR khong dat(o tat ca cac lan thi).
SELECT h.MAHV, h.HO, h.TEN FROM KETQUATHI as k  
INNER JOIN HOCVIEN as h 
ON k.MAHV = h.MAHV
WHERE h.MALOP LIKE 'K%'  AND k.MAMH = 'CTRR'  AND k.DIEM < 5 



--6. Tim ten nhung mon hoc ma giao vien co ten "Tran Thi Thu Nhung" day trong hoc ky I nam 2006
SELECT DISTINCT m.TENMH FROM MONHOC m
INNER JOIN GIANGDAY d
ON m.MAMH = d.MAMH
INNER JOIN GIAOVIEN g
ON d.MAGV = g.MAGV
WHERE g.HOTEN = 'Tran Thi Thu Nhung' AND d.HOCKY = 1 AND d.NAMHOC = 2006


--7. Tim nhung mon hoc (ma mon hoc, ten mon hoc) ma giao vien chu nhiem lop "K11" 
--day trong hoc ki 1 nam 2006.

SELECT g.MAMH, m.TENMH FROM 
LOP l 
INNER JOIN GIANGDAY g 
ON l.MAGVCN = g.MAGV
INNER JOIN MONHOC m ON g.MAMH = m.MAMH 
WHERE l.MALOP = 'K11' AND g.HOCKY = 1 AND g.NAMHOC =  2006
 

--8. Tim ho ten lop truong cua cac lop ma giao vien co ten "Nguyen To Lan" day mon "Co So Du Lieu" 
SELECT h.HO, h.TEN  FROM 
LOP l 
INNER JOIN GIANGDAY g 
ON l.MAGVCN = g.MAGV
INNER JOIN MONHOC m ON g.MAMH = m.MAMH 
INNER JOIN GIAOVIEN as gv ON gv.MAGV = g.MAGV
INNER JOIN HOCVIEN h ON h.MAHV = l.TRGLOP
WHERE gv.HOTEN= 'Nguyen To Lan' AND m.TENMH = 'Co So Du Lieu'


--9. In ra danh sach nhung mon hoc (ma mon hoc, ten mon hoc) phai hoc lien truoc mon "Co So Du Lieu"
SELECT 
    MH_TRUOC.MAMH AS MAMH_TRUOC,
    MH_TRUOC.TENMH AS TENMH_TRUOC
FROM 
    DIEUKIEN DK
JOIN 
    MONHOC MH_SAU ON DK.MAMH = MH_SAU.MAMH
JOIN 
    MONHOC MH_TRUOC ON DK.MAMH_TRUOC = MH_TRUOC.MAMH
WHERE 
    MH_SAU.TENMH = 'Co So Du Lieu';


--10. Mon "Cau Truc Roi Rac" la mon bat buoc phai hoc lien truoc nhung mon hoc (ma mon hoc, ten mon hoc) nao.
SELECT MH_SAU.MAMH,
	   MH_SAU.TENMH
FROM 
  DIEUKIEN DK 
JOIN MONHOC MH_SAU ON DK.MAMH = MH_SAU.MAMH 
JOIN MONHOC MH_TRUOC ON DK.MAMH_TRUOC = MH_TRUOC.MAMH
WHERE MH_TRUOC.TENMH = 'Cau Truc Roi Rac'

--11. Tim ho ten giao vien day mon CTRR cho ca hai lop "K11" va "K12" trong cung ky 1 nam 2006
SELECT gv.HOTEN FROM 
GIAOVIEN as gv
INNER JOIN GIANGDAY g 
ON g.MAGV= gv.MAGV
WHERE 
     g.MALOP IN ('K11', 'K12') 
     AND  g.MAMH = 'CTRR'
	 AND g.HOCKY = 1 AND g.NAMHOC =  2006
GROUP BY gv.HOTEN
HAVING COUNT(DISTINCT g.MALOP) = 2;


--12. Tim nhung hoc vien (ma hoc vien, ho ten) thi khong dat mon CSDL o lan thi 1 nhung 
-- chua thi lai mon nay 
SELECT DISTINCT 
    hv.MAHV, 
    CONCAT(hv.HO, ' ', hv.TEN) AS HOTEN
FROM 
    HOCVIEN AS hv
JOIN 
    KETQUATHI AS k1 ON hv.MAHV = k1.MAHV
WHERE 
    k1.MAMH = 'CSDL' 
    AND k1.LANTHI = 1 
    AND k1.DIEM < 5
    AND NOT EXISTS (
        SELECT 1
        FROM KETQUATHI AS k2
        WHERE 
            k2.MAHV = k1.MAHV 
            AND k2.MAMH = k1.MAMH 
            AND k2.LANTHI > 1
  );



  --13. Tim giao vien (ma giao vien, ho ten) khong duoc phan bo giang day bat ky mon hoc nao 
SELECT 
    gv.MAGV, 
    gv.HOTEN 
FROM 
    GIAOVIEN gv
LEFT JOIN 
    GIANGDAY gd 
ON 
    gv.MAGV = gd.MAGV
WHERE 
    gd.MAGV IS NULL;



  --14. Tim giao vien (ma giao vien, ho ten) khong duoc phan cong giang day bat ky mon hoc 
  -- nao thuoc khoa giao vien do phu trach
SELECT 
    gv.MAGV, 
    gv.HOTEN
FROM 
    GIAOVIEN AS gv
WHERE 
    NOT EXISTS (
        SELECT 1
        FROM 
            GIANGDAY AS gd
        INNER JOIN 
            MONHOC AS mh ON gd.MAMH = mh.MAMH
        WHERE 
            gd.MAGV = gv.MAGV
            AND mh.MAKHOA = gv.MAKHOA
);


--15. Tim ho ten các hoc vien lop "K11" thi mot mon bat ky qua 3 lan van "Khong dat"
-- hoac thi lan thu 2 mon CTRR duoc 5 diem 

SELECT hv.HO, hv.TEN FROM HOCVIEN as hv 
INNER JOIN KETQUATHI as kq
ON HV.MAHV = kq.MAHV
WHERE hv.MALOP = 'K11' AND((kq.LANTHI = 3 AND kq.DIEM < 5) OR (kq.MAMH = 'CTRR' AND kq.LANTHI = 2 AND kq.DIEM = 5))




--16. Tim ho ten giao vien day mon CTRR cho it nhat hai lop trong cung mot hoc ky cua mot nam hoc 
SELECT gv.HOTEN, gd.MAGV 
FROM GIANGDAY as gd 
JOIN GIAOVIEN as gv ON gd.MAGV  = gv.MAGV
WHERE gd.MAMH = 'CTRR'
GROUP BY gv.HOTEN, gd.MAGV, gd.HOCKY, gd.NAMHOC
HAVING COUNT(gd.MALOP) >= 2


--17. Danh sach hoc vien va diem thi mon CSDL (chi lay diem cua lan thi sau cung)
WITH LastAttemp AS (	
	SELECT 
	   MAHV, 
	   MAMH, 
	   DIEM, 
	   ROW_NUMBER() OVER (PARTITION BY MAHV, MAMH ORDER BY LANTHI DESC) AS RowNum
	FROM KETQUATHI as kq
	WHERE kq.MAMH = 'CSDL')
SELECT MAHV, MAMH, DIEM 
FROM LastAttemp
WHERE RowNum = 1


--18. Danh sach hoc vien va diem thi mon "Co So Du Lieu" (chi lay diem cao nhat cua cac lan thi)
WITH MaxMark AS (	
	SELECT 
	   MAHV, 
	   MAMH, 
	   DIEM, 
	   ROW_NUMBER() OVER (PARTITION BY MAHV, MAMH ORDER BY DIEM DESC) AS RowNum
	FROM KETQUATHI as kq
	WHERE kq.MAMH = 'CSDL')
SELECT MAHV, MAMH, DIEM 
FROM MaxMark
WHERE RowNum = 1


--19. Khoa nao (ma khoa, ten khoa) duoc thanh lap som nhat
SELECT * FROM KHOA as k
WHERE NGTLAP IN (
	SELECT MIN(k2.NGTLAP)
	FROM KHOA k2
)


--20. Co bao nhieu giao vien co hoc ham la "GS" hoac "PGS"
SELECT COUNT(*) as SoGiaoVien FROM GIAOVIEN as gv
WHERE gv.HOCHAM = 'GS' OR gv.HOCHAM = 'PGS'


--21. Thong ke co bao nhieu giao vien co hoc vi la "CN", "KS", "Ths", "TS", "PTS"  trong moi khoa 
SELECT gv.MAKHOA, 
	SUM(CASE WHEN HOCVI = 'CN' THEN 1 ELSE  0 END) AS CN_COUNT,
	SUM(CASE WHEN HOCVI = 'KS' THEN 1 ELSE  0 END) AS CN_COUNT,
	SUM(CASE WHEN HOCVI = 'Ths' THEN 1 ELSE  0 END) AS CN_COUNT,
	SUM(CASE WHEN HOCVI = 'TS' THEN 1 ELSE  0 END) AS CN_COUNT,
	SUM(CASE WHEN HOCVI = 'PTS' THEN 1 ELSE  0 END) AS CN_COUNT
FROM GIAOVIEN as gv
GROUP BY gv.MAKHOA


--22. Moi mon hoc thong ke so luong hoc vien theo ket qua (dat va khong dat)
SELECT kq.MAMH,
	SUM(CASE WHEN KQUA = 'Dat' THEN 1 ELSE 0 END) AS DAT_COUNT,
	SUM (CASE WHEN KQUA = 'Khong Dat' THEN 1 ELSE 0 END) KHONG_DAT_COUNT
FROM KETQUATHI as kq
GROUP BY kq.MAMH





--23. Tim giao vien (ma giao vien, ho ten) la giao vien chu nhiem cua mot lop thoi day
--cho lop do it nhat mot mon hoc 
SELECT gv.MAGV, gv.HOTEN
FROM GIAOVIEN as gv 
INNER JOIN GIANGDAY as gd  ON gv.MAGV = gd.MAGV
INNER JOIN LOP as l ON l.MAGVCN = gv.MAGV
GROUP BY gv.MAGV, gv.HOTEN,  l.MALOP
HAVING COUNT(gd.MAMH) > 1


--24. Tim ho ten lop truong cua lop co si so cao nhat 
SELECT 
   hv.HO, 
   hv.TEN
FROM Lop l
JOIN HOCVIEN hv ON l.TRGLOP = hv.MAHV
WHERE l.SISO = (SELECT MAX(SISO) FROM LOP)



--25 Tim Ho Ten nhung LOPTRG thi khong dat quá 3 mon (moi mon deu thi khong dat ở tất 
--ca cac lan thi
--)
SELECT 
    hv.HO, 
    hv.TEN
FROM 
    HOCVIEN hv
JOIN 
    LOP l ON hv.MALOP = l.MALOP
JOIN 
    KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE 
    l.TRGLOP = hv.MAHV 
GROUP BY 
    hv.MAHV, hv.HO, hv.TEN
HAVING 
    COUNT(DISTINCT CASE WHEN kq.DIEM < 5 THEN kq.MAMH ELSE NULL END) > 3
    AND 
    COUNT(DISTINCT CASE WHEN kq.DIEM < 5 THEN kq.LANTHI ELSE NULL END) = COUNT(DISTINCT kq.LANTHI);


--26.Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9.10 nhiều nhất 
SELECT TOP(1)
	hv.MAHV,
	hv.HO,
	hv.TEN,
	COUNT(MAMH) as SoMonDat9_10
FROM HOCVIEN as hv
INNER JOIN KETQUATHI as kq ON hv.MAHV = kq.MAHV
WHERE DIEM = 9.10
GROUP BY hv.MAHV, hv.HO, hv.TEN
ORDER BY SoMonDat9_10 DESC





--27. Trong tung lop, tim hoc vien (ma hoc vien, ho ten) co so mon dat diem 9.10 nhieu nhat 
SELECT 
    hv.MAHV, 
    hv.HO, 
    hv.TEN, 
    hv.MALOP, 
    COUNT(kq.MAMH) AS SoMonDat9_10
FROM 
    HOCVIEN hv
JOIN 
    KETQUATHI kq ON hv.MAHV = kq.MAHV
WHERE 
    kq.DIEM = 9.10
GROUP BY 
    hv.MAHV, hv.HO, hv.TEN, hv.MALOP
HAVING 
    COUNT(kq.MAMH) = (
        SELECT MAX(SoMonDat9_10)
        FROM (
            SELECT 
                COUNT(kq2.MAMH) AS SoMonDat9_10
            FROM 
                HOCVIEN hv2
            JOIN 
                KETQUATHI kq2 ON hv2.MAHV = kq2.MAHV
            WHERE 
                kq2.DIEM = 9.10 AND hv2.MALOP = hv.MALOP
            GROUP BY 
                hv2.MAHV
        ) AS Subquery
    )
ORDER BY 
    hv.MALOP, SoMonDat9_10 DESC;


--28. Trong tung hoc ky cua tung nam, moi giao vien phan cong day bao nhieu mon hoc, bao nhieu lop
SELECT 
	gv.MAGV, 
	gv.HOTEN,
	gd.NAMHOC,
	gd.HOCKY,
	COUNT(gd.MAMH) as SoMonHoc, 
	COUNT(gd.MALOP) as SoLop
FROM GIANGDAY as gd
INNER JOIN GIAOVIEN as gv 
ON gd.MAGV = gv.MAGV
GROUP BY gv.MAGV, gv.HOTEN, gd.HOCKY, gd.NAMHOC
ORDER BY gv.MAGV, gd.NAMHOC, gd.HOCKY




--29. Trong tung hoc ky cua tung nam, tìm giao vien (ma giao vien, ho ten) giang day nhieu nhat 
WITH TeacherSubjectCount AS (
    SELECT 
        gv.MAGV, 
        gv.HOTEN, 
        g.HOCKY, 
        g.NAMHOC, 
        COUNT(DISTINCT g.MAMH) AS SoMonHoc
    FROM 
        GIAOVIEN gv
    JOIN 
        GIANGDAY g ON gv.MAGV = g.MAGV
    GROUP BY 
        gv.MAGV, gv.HOTEN, g.HOCKY, g.NAMHOC
)
SELECT 
    tsc.MAGV, 
    tsc.HOTEN, 
    tsc.HOCKY, 
    tsc.NAMHOC, 
    tsc.SoMonHoc
FROM 
    TeacherSubjectCount tsc
JOIN (
    SELECT 
        HOCKY, 
        NAMHOC, 
        MAX(SoMonHoc) AS MaxMonHoc
    FROM 
        TeacherSubjectCount
    GROUP BY 
        HOCKY, NAMHOC
) maxSubjects ON tsc.HOCKY = maxSubjects.HOCKY
               AND tsc.NAMHOC = maxSubjects.NAMHOC
               AND tsc.SoMonHoc = maxSubjects.MaxMonHoc
ORDER BY 
    tsc.NAMHOC, tsc.HOCKY, tsc.SoMonHoc DESC;



--30. Tim mon hoc (ma mon hoc, ten mon hoc) co nhieu hoc vien thi khong dat (o lan thu 1)
SELECT MAMH, TENMH
FROM MONHOC
WHERE MAMH NOT IN (
    SELECT DISTINCT MAMH
    FROM KETQUATHI
    WHERE DIEM >= 5 AND LANTHI = 1
)
ORDER BY COUNT(MAHV) DESC;


--31. 
SELECT DISTINCT kq.MAHV, hv.HO, hv.TEN
FROM KETQUATHI kq
JOIN HOCVIEN hv ON kq.MAHV = hv.MAHV
WHERE kq.DIEM >= 5 AND kq.LANTHI = 1;


--32
SELECT DISTINCT kq.MAHV, hv.HO, hv.TEN
FROM KETQUATHI kq
JOIN HOCVIEN hv ON kq.MAHV = hv.MAHV
WHERE kq.DIEM >= 5 AND kq.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI
    WHERE MAHV = kq.MAHV AND MAMH = kq.MAMH
);


--33. 
SELECT DISTINCT kq.MAHV, hv.HO, hv.TEN
FROM KETQUATHI kq
JOIN HOCVIEN hv ON kq.MAHV = hv.MAHV
WHERE kq.LANTHI = 1
GROUP BY kq.MAHV, hv.HO, hv.TEN
HAVING COUNT(DISTINCT kq.MAMH) = (SELECT COUNT(DISTINCT MAMH) FROM MONHOC);


--34. 
SELECT DISTINCT kq.MAHV, hv.HO, hv.TEN
FROM KETQUATHI kq
JOIN HOCVIEN hv ON kq.MAHV = hv.MAHV
WHERE kq.DIEM >= 5
AND kq.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI
    WHERE MAHV = kq.MAHV AND MAMH = kq.MAMH
)
GROUP BY kq.MAHV, hv.HO, hv.TEN
HAVING COUNT(DISTINCT kq.MAMH) = (SELECT COUNT(DISTINCT MAMH) FROM MONHOC);




--35
SELECT kq.MAHV, hv.HO, hv.TEN, kq.MAMH, MAX(kq.DIEM) AS MAX_DIEM
FROM KETQUATHI kq
JOIN HOCVIEN hv ON kq.MAHV = hv.MAHV
WHERE kq.LANTHI = (
    SELECT MAX(LANTHI)
    FROM KETQUATHI
    WHERE MAHV = kq.MAHV AND MAMH = kq.MAMH
)
GROUP BY kq.MAHV, hv.HO, hv.TEN, kq.MAMH;
