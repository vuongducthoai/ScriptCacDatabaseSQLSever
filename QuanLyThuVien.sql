CREATE DATABASE QuanLyThuVien1
USE QuanLyThuVien1

CREATE TABLE DocGia (
    maDocGia INT PRIMARY KEY,
    ho NVARCHAR(50) NOT NULL,
    tenLot NVARCHAR(50),
    Ten NVARCHAR(50) NOT NULL,
    ngaySinh DATE NOT NULL
);

CREATE TABLE NguoiLon (
    maNguoiLon INT PRIMARY KEY,
    soNha NVARCHAR(20),
    Duong NVARCHAR(100),
    Quan NVARCHAR(100),
    dienThoai NVARCHAR(15) NOT NULL UNIQUE,
    hanSuDung DATE NOT NULL,
    CONSTRAINT FK_NguoiLon_DocGia FOREIGN KEY (maNguoiLon) REFERENCES DocGia(maDocGia)
);



CREATE TABLE TreEm (
    maTreEm INT PRIMARY KEY,
    maNguoiLon INT NOT NULL,
    CONSTRAINT FK_TreEm_DocGia FOREIGN KEY (maTreEm) REFERENCES DocGia(maDocGia),
    CONSTRAINT FK_TreEm_NguoiLon FOREIGN KEY (maNguoiLon) REFERENCES NguoiLon(maNguoiLon)
);



CREATE TABLE TuaSach (
    maTuaSach INT PRIMARY KEY,
    tenTuaSach NVARCHAR(100) NOT NULL,
    tacGia NVARCHAR(100) NOT NULL,
    tomTat NVARCHAR(MAX)
);


CREATE TABLE DauSach (
    isbn NVARCHAR(13) PRIMARY KEY,
    maTuaSach INT NOT NULL,
    ngonNgu NVARCHAR(50) NOT NULL,
    Bia NVARCHAR(50) NOT NULL,
    TrangThai NVARCHAR(20) CHECK (TrangThai IN (N'Còn hàng', N'Hết hàng')),
    CONSTRAINT FK_DauSach_TuaSach FOREIGN KEY (maTuaSach) REFERENCES TuaSach(maTuaSach)
);





CREATE TABLE CuonSach (
    maCuonSach INT PRIMARY KEY,
    isbn NVARCHAR(13) NOT NULL,
    tinhTrang NVARCHAR(20) CHECK (tinhTrang IN (N'Mới', N'Cũ', N'Đang mượn')),
    CONSTRAINT FK_CuonSach_DauSach FOREIGN KEY (isbn) REFERENCES DauSach(isbn)
);



CREATE TABLE DangKy (
    isbn NVARCHAR(13) NOT NULL,
    maDocGia INT NOT NULL,
    ngayDangKy DATE NOT NULL,
    ghiChu NVARCHAR(255),
    CONSTRAINT FK_DangKy_DocGia FOREIGN KEY (maDocGia) REFERENCES DocGia(maDocGia),
    CONSTRAINT FK_DangKy_DauSach FOREIGN KEY (isbn) REFERENCES DauSach(isbn)
);


CREATE TABLE Muon (
    isbn NVARCHAR(13) NOT NULL,
    maCuonSach INT NOT NULL,
    maDocGia INT NOT NULL,
    ngayMuon DATE NOT NULL,
    ngayHetHan DATE NOT NULL,
    CONSTRAINT FK_Muon_DocGia FOREIGN KEY (maDocGia) REFERENCES DocGia(maDocGia),
    CONSTRAINT FK_Muon_DauSach FOREIGN KEY (isbn) REFERENCES DauSach(isbn),
    CONSTRAINT FK_Muon_CuonSach FOREIGN KEY (maCuonSach) REFERENCES CuonSach(maCuonSach)
);



CREATE TABLE QuaTrinhMuon (
    isbn NVARCHAR(13) NOT NULL,
    maCuonSach INT NOT NULL,
    ngayMuon DATE NOT NULL,
    maDocGia INT NOT NULL,
    ngayHetHan DATE NOT NULL,
    ngayTra DATE,
    tienMuon DECIMAL(10, 2) NOT NULL CHECK (tienMuon >= 0),
    tienDaTra DECIMAL(10, 2) DEFAULT 0 CHECK (tienDaTra >= 0),
    tienDaCoc DECIMAL(10, 2) DEFAULT 0 CHECK (tienDaCoc >= 0),
    ghiChu NVARCHAR(255),
    CONSTRAINT PK_QuaTrinhMuon PRIMARY KEY (isbn, maCuonSach, ngayMuon),
    CONSTRAINT FK_QuaTrinhMuon_DocGia FOREIGN KEY (maDocGia) REFERENCES DocGia(maDocGia),
    CONSTRAINT FK_QuaTrinhMuon_DauSach FOREIGN KEY (isbn) REFERENCES DauSach(isbn),
    CONSTRAINT FK_QuaTrinhMuon_CuonSach FOREIGN KEY (maCuonSach) REFERENCES CuonSach(maCuonSach)
);




-- Chèn lại dữ liệu cho bảng DocGia
INSERT INTO DocGia (maDocGia, ho, tenLot, Ten, ngaySinh) VALUES 
-- Dữ liệu cho độc giả là người lớn
(1, N'Nguyen', N'Van', N'A', '1980-01-01'),
(2, N'Tran', N'Thi', N'B', '1975-02-02'),
(3, N'Le', N'Hoang', N'C', '1983-03-03'),
(4, N'Pham', NULL, N'D', '1986-04-04'),
(5, N'Hoang', N'Tran', N'E', '1978-05-05'),
(6, N'Do', N'Van', N'F', '1982-06-06'),
(7, N'Bui', N'Thi', N'G', '1985-07-07'),
(8, N'Nguyen', N'Thanh', N'H', '1984-08-08'),
(9, N'Phan', NULL, N'I', '1981-09-09'),
(10, N'Vu', N'Van', N'K', '1987-10-10'),

-- Dữ liệu cho độc giả là trẻ em
(11, N'Nguyen', N'Van', N'L', '2010-01-01'),
(12, N'Tran', N'Thi', N'M', '2011-02-02'),
(13, N'Le', N'Hoang', N'N', '2012-03-03'),
(14, N'Pham', NULL, N'O', '2013-04-04'),
(15, N'Hoang', N'Tran', N'P', '2014-05-05'),
(16, N'Do', N'Van', N'Q', '2015-06-06'),
(17, N'Bui', N'Thi', N'R', '2016-07-07'),
(18, N'Nguyen', N'Thanh', N'S', '2017-08-08'),
(19, N'Phan', NULL, N'T', '2018-09-09'),
(20, N'Vu', N'Van', N'U', '2019-10-10');



INSERT INTO NguoiLon (maNguoiLon, soNha, Duong, Quan, dienThoai, hanSuDung) VALUES 
(1, N'123', N'Le Loi', N'Quan 1', N'0901234567', '2025-01-01'),
(2, N'45', N'Tran Hung Dao', N'Quan 3', N'0902234567', '2024-12-31'),
(3, N'78B', N'Nguyen Thi Minh Khai', N'Quan 5', N'0903234567', '2025-06-15'),
(4, N'9', N'Pham Ngu Lao', N'Quan 1', N'0904234567', '2025-07-01'),
(5, N'56A', N'Cach Mang Thang 8', N'Quan 10', N'0905234567', '2025-09-10'),
(6, N'88', N'Dien Bien Phu', N'Quan Binh Thanh', N'0906234567', '2025-03-20'),
(7, N'35C', N'Vo Van Tan', N'Quan 3', N'0907234567', '2025-11-11'),
(8, N'12', N'Nguyen Van Linh', N'Quan 7', N'0908234567', '2025-08-08'),
(9, N'109', N'Ba Thang Hai', N'Quan 10', N'0909234567', '2025-05-05'),
(10, N'45A', N'Hoang Sa', N'Quan Phu Nhuan', N'0910234567', '2025-02-02');

	

INSERT INTO TreEm (maTreEm, maNguoiLon) VALUES 
(11, 1),
(12, 2),
(13, 3),
(14, 4),
(15, 5),
(16, 6),
(17, 7),
(18, 8),
(19, 9),
(20, 10);




INSERT INTO TuaSach (maTuaSach, tenTuaSach, tacGia, tomTat) VALUES 
(1, N'Harry Potter và Hòn Đá Phù Thủy', N'J.K. Rowling', N'Truyện về cậu bé phù thủy Harry Potter và cuộc phiêu lưu của cậu tại trường Hogwarts.'),
(2, N'Chiến Tranh và Hòa Bình', N'Leo Tolstoy', N'Truyện kể về sự xung đột và hòa bình trong thời kỳ chiến tranh Napoleon.'),
(3, N'Thuật Sống Giản Dị', N'Dominique Loreau', N'Cuốn sách về cách sống giản dị và tận hưởng cuộc sống.'),
(4, N'Sherlock Holmes', N'Arthur Conan Doyle', N'Truyện về thám tử nổi tiếng Sherlock Holmes và những vụ án ly kỳ.'),
(5, N'Lược Sử Thời Gian', N'Stephen Hawking', N'Cuốn sách giải thích các khái niệm vật lý vũ trụ học cho độc giả phổ thông.'),
(6, N'Một Thoáng Ta Rực Rỡ Ở Nhân Gian', N'Ocean Vuong', N'Câu chuyện xúc động về tình yêu và sự mất mát.'),
(7, N'Những Người Khốn Khổ', N'Victor Hugo', N'Truyện về cuộc sống của những con người nghèo khổ trong xã hội Pháp.'),
(8, N'To Kill a Mockingbird', N'Harper Lee', N'Câu chuyện về phân biệt chủng tộc và công lý ở miền Nam nước Mỹ.'),
(9, N'Bố Già', N'Mario Puzo', N'Truyện về cuộc đời của ông trùm mafia Vito Corleone và gia đình ông.'),
(10, N'Đắc Nhân Tâm', N'Dale Carnegie', N'Sách về nghệ thuật giao tiếp và gây ảnh hưởng đến người khác.');



INSERT INTO DauSach (isbn, maTuaSach, ngonNgu, Bia, TrangThai) VALUES 
(N'9780747532743', 1, N'Tiếng Việt', N'Bìa cứng', N'Còn hàng'),
(N'9780345803481', 2, N'Tiếng Việt', N'Bìa mềm', N'Còn hàng'),
(N'9782226317760', 3, N'Tiếng Việt', N'Bìa cứng', N'Hết hàng'),
(N'9781853260339', 4, N'Tiếng Anh', N'Bìa mềm', N'Còn hàng'),
(N'9780553380163', 5, N'Tiếng Việt', N'Bìa cứng', N'Còn hàng'),
(N'9781984823419', 6, N'Tiếng Việt', N'Bìa mềm', N'Hết hàng'),
(N'9782070368228', 7, N'Tiếng Việt', N'Bìa cứng', N'Còn hàng'),
(N'9780060935467', 8, N'Tiếng Anh', N'Bìa mềm', N'Hết hàng'),
(N'9780099411071', 9, N'Tiếng Việt', N'Bìa cứng', N'Còn hàng'),
(N'9780749302067', 10, N'Tiếng Việt', N'Bìa mềm', N'Còn hàng');






-- Chèn dữ liệu vào bảng CuonSach
INSERT INTO CuonSach (maCuonSach, isbn, tinhTrang) VALUES 
(1, N'9780747532743', N'Mới'),
(2, N'9780345803481', N'Cũ'),
(3, N'9782226317760', N'Đang mượn'),
(4, N'9781853260339', N'Mới'),
(5, N'9780553380163', N'Cũ'),
(6, N'9781984823419', N'Đang mượn'),
(7, N'9782070368228', N'Mới'),
(8, N'9780060935467', N'Cũ'),
(9, N'9780099411071', N'Đang mượn'),
(10, N'9780749302067', N'Mới');


-- Chèn dữ liệu vào bảng DangKy
INSERT INTO DangKy (isbn, maDocGia, ngayDangKy, ghiChu) VALUES 
(N'9780747532743', 1, '2024-01-01', N'Đăng ký mượn lần đầu'),
(N'9780345803481', 3, '2024-01-05', N'Tài liệu cần cho bài luận'),
(N'9782226317760', 5, '2024-02-10', N'Dăng ký mượn để nghiên cứu'),
(N'9781853260339', 7, '2024-03-15', N'Mượn sách đọc thêm'),
(N'9780553380163', 9, '2024-04-20', N'Dùng cho kỳ thi sắp tới'),
(N'9781984823419', 11, '2024-05-25', N'Giới thiệu của bạn bè'),
(N'9782070368228', 13, '2024-06-30', N'Đăng ký mượn do yêu thích tác giả'),
(N'9780060935467', 15, '2024-07-05', N'Tài liệu cần cho môn học mới'),
(N'9780099411071', 17, '2024-08-10', N'Người dùng đăng ký mượn lâu dài'),
(N'9780749302067', 19, '2024-09-15', N'Dăng ký mượn tham khảo chuyên đề');



-- Chèn dữ liệu vào bảng Muon
INSERT INTO Muon (isbn, maCuonSach, maDocGia, ngayMuon, ngayHetHan) VALUES 
(N'9780747532743', 1, 1, '2024-01-10', '2024-01-20'),
(N'9780345803481', 2, 2, '2024-01-15', '2024-01-25'),
(N'9782226317760', 3, 3, '2024-02-01', '2024-02-11'),
(N'9781853260339', 4, 4, '2024-03-05', '2024-03-15'),
(N'9780553380163', 5, 5, '2024-04-10', '2024-04-20'),
(N'9781984823419', 6, 6, '2024-05-15', '2024-05-25'),
(N'9782070368228', 7, 7, '2024-06-20', '2024-06-30'),
(N'9780060935467', 8, 8, '2024-07-05', '2024-07-15'),
(N'9780099411071', 9, 9, '2024-08-01', '2024-08-11'),
(N'9780749302067', 10, 10, '2024-09-10', '2024-09-20');



-- Chèn dữ liệu vào bảng QuaTrinhMuon
INSERT INTO QuaTrinhMuon (isbn, maCuonSach, ngayMuon, maDocGia, ngayHetHan, ngayTra, tienMuon, tienDaTra, tienDaCoc, ghiChu) VALUES 
(N'9780747532743', 1, '2024-01-10', 1, '2024-01-20', '2024-01-18', 5000, 5000, 1000, N'Mượn sách lần đầu'),
(N'9780345803481', 2, '2024-01-15', 2, '2024-01-25', '2024-01-24', 7000, 7000, 1500, N'Dùng cho bài luận'),
(N'9782226317760', 3, '2024-02-01', 3, '2024-02-11', '2024-02-10', 6000, 6000, 1200, N'Nghiên cứu'),
(N'9781853260339', 4, '2024-03-05', 4, '2024-03-15', '2024-03-13', 8000, 8000, 2000, N'Đọc thêm'),
(N'9780553380163', 5, '2024-04-10', 5, '2024-04-20', '2024-04-18', 6500, 6500, 1300, N'Chuẩn bị kỳ thi'),
(N'9781984823419', 6, '2024-05-15', 6, '2024-05-25', '2024-05-24', 5500, 5500, 1100, N'Tìm hiểu thêm'),
(N'9782070368228', 7, '2024-06-20', 7, '2024-06-30', '2024-06-29', 6000, 6000, 1200, N'Yêu thích tác giả'),
(N'9780060935467', 8, '2024-07-05', 8, '2024-07-15', 'NULL', 7500, 7500, 1500, N'Tài liệu môn học'),
(N'9780099411071', 9, '2024-08-01', 9, '2024-08-11', 'NULL', 9000, 5000, 1800, N'Mượn lâu dài'),
(N'9780749302067', 10, '2024-09-10', 10, '2024-09-20', '2024-09-19', 8000, 5000, 1600, N'Tham khảo chuyên đề');



--1. Liệt kê tất cả các độc giả chưa bao giờ đăng ký sách
SELECT dg.maDocGia, dg.ho, dg.tenLot, dg.Ten, dg.ngaySinh
FROM DocGia dg
LEFT JOIN DangKy dk ON dg.maDocGia = dk.maDocGia
WHERE dk.isbn IS NULL;

--2. Tìm các độc giả chưa trả sách quá hạn của mình, 
--hiển thị thông tin sách, ngày mượn ngày hết hạn và ngày hiện tại.
SELECT dg.maDocGia, dg.ho, dg.tenLot, dg.Ten, dg.ten, ts.tenTuaSach, qs.ngayMuon, qs.ngayHetHan, GETDATE() AS ngayHienTai
FROM DocGia dg
JOIN QuaTrinhMuon qs ON dg.maDocGia = qs.maDocGia
JOIN DauSach ds ON qs.isbn = ds.isbn
JOIN TuaSach ts ON ts.maTuaSach = ds.maTuaSach
WHERE qs.ngayTra IS NULL AND qs.ngayHetHan < GETDATE()

--3. Lấy danh sách độc giả mượn nhiều sách nhất, bao gồm thông tin độc giả 
-- và số lượng sách đã mượn
SELECT dg.maDocGia, dg.ho, dg.tenLot, dg.Ten, Count(*) AS SoLuongSachMuon
FROM DocGia dg
JOIN Muon m ON dg.maDocGia = m.maDocGia
GROUP BY dg.maDocGia, dg.ho, dg.tenLot, dg.Ten
ORDER BY SoLuongSachMuon DESC


--4. Tìm danh sách đang được đăng ký nhiều nhất và chưa mượn(tình trạng còn hàng), bao gồm số lần đăng ký
SELECT ts.tenTuaSach, COUNT(dk.isbn) as SoLanDangKy
FROM DauSach ds
JOIN DangKy dk ON ds.isbn = dk.isbn
JOIN TuaSach ts ON ts.maTuaSach = ds.maTuaSach
WHERE ds.TrangThai = N'Còn hàng'
GROUP BY ts.tenTuaSach
ORDER BY SoLanDangKy DESC


--5. Liệt kê các cuốn sách đã được mượn nhiều nhất cũng số lần mượn, 
-- sắp xếp theo số lần mượn giảm dần.
SELECT cs.maCuonSach, ts.tenTuaSach, COUNT(m.isbn) AS soLanMuon
FROM CuonSach cs 
JOIN Muon m ON cs.maCuonSach = m.maCuonSach
JOIN DauSach ds ON m.isbn = ds.isbn
JOIN TuaSach ts ON ts.maTuaSach = ds.maTuaSach
GROUP BY cs.maCuonSach, ts.tenTuaSach


--6. Tìm kiếm các độc giả nợ số tiền phạt, hiển thị tổng số tiền phạt
-- còn nợ của mỗi người 
SELECT 
    dg.maDocGia, 
    dg.ho, 
    dg.tenLot, 
    dg.Ten, 
    SUM(qm.tienMuon - (qm.tienDaTra + qm.tienDaCoc)) AS tienPhatConNo
FROM 
    DocGia dg
JOIN 
    QuaTrinhMuon qm ON dg.maDocGia = qm.maDocGia
WHERE 
    qm.tienMuon > (qm.tienDaTra + qm.tienDaCoc)
GROUP BY 
    dg.maDocGia, dg.ho, dg.tenLot, dg.Ten
HAVING 
    SUM(qm.tienMuon - (qm.tienDaTra + qm.tienDaCoc)) > 0;

