CREATE DATABASE QLGV

USE QLGV

CREATE TABLE COSO (
	maCS INT PRIMARY KEY IDENTITY,
	tenCoSo NVARCHAR(100),
)

CREATE TABLE DONVI (
	maDonVi INT PRIMARY KEY IDENTITY,
	tenDonVi NVARCHAR(100),
	maCS INT FOREIGN KEY REFERENCES COSO(maCS)
)

CREATE TABLE GV (
	maGV INT PRIMARY KEY IDENTITY,
	hoTen NVARCHAR(100),
	sdt NVARCHAR(10),
	ghiChu NVARCHAR(255) NULL,
	maDonVi INT FOREIGN KEY references DONVI(maDonVi)
)


INSERT INTO COSO (tenCoSo)
VALUES 
('Cơ sở 1'),
('Cơ sở 2');

INSERT INTO DONVI (tenDonVi, maCS)
VALUES 
('Đơn vị 1', 1),
('Đơn vị 2 ', 1),
('Đơn vị 3', 2),
('Đơn vị 4', 2);

INSERT INTO GV (hoTen, sdt, ghiChu, maDonVi)
VALUES 
('Giáo viên A', '0123456789', NULL, 1),
('Giáo viên B', '0123456790', NULL, 1),
('Giáo viên C', '0123456791', NULL, 2),
('Giáo viên D', '0123456792', NULL, 2),
('Giáo viên E', '0123456793', NULL, 3),
('Giáo viên F', '0123456794', NULL, 3),
('Giáo viên G', '0123456795', NULL, 4),
('Giáo viên H', '0123456796', NULL, 4);



