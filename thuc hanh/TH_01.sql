﻿--1.1
SELECT MaSinhVien 'Sinh Viên', HoDem, Ten, NgaySinh, GioiTinh
FROM SINHVIEN
WHERE HoDem  LIKE 'Lê%'

--1.2
SELECT MaSinhVien, HoDem, Ten, NgaySinh, GioiTinh
FROM SINHVIEN
WHERE HoDem  LIKE N'%Thị%'

--1.3
SELECT MaSinhVien, CONCAT(HoDem, ' ', Ten) AS HoTen, NgaySinh, GioiTinh
FROM SINHVIEN
WHERE HoDem LIKE N'% Văn'

--1.4
SELECT MaSinhVien, HoDem, Ten, NgaySinh, GioiTinh, l.TenLop,sv.MaLop
FROM SINHVIEN sv
JOIN LOP l ON sv.Malop=l.MaLop
WHERE HoDem LIKE N'Dư %'or HoDem LIKE N'Dư' or Ten like N'V%'

--1.5
SELECT MaSinhVien, CONCAT(HoDem, ' ', Ten) AS HoTen, NgaySinh, GioiTinh,NoiSinh
FROM SINHVIEN
WHERE NoiSinh  LIKE N'%Huế%'

--1.6
SELECT MaSinhVien, HoDem, Ten, NgaySinh, GioiTinh
FROM SINHVIEN
WHERE NgaySinh >= '1992-03-01' AND NgaySinh < '1992-09-01'

--1.7
SELECT MaSinhVien, HoDem, Ten, NgaySinh, GioiTinh, l.TenLop,sv.MaLop
FROM SINHVIEN sv
JOIN LOP l ON sv.Malop=l.MaLop
WHERE MONTH(NgaySinh) BETWEEN 5 AND 11 or GioiTinh like'0'

--1.8
SELECT MaSinhVien 'Mã SV', CONCAT(HoDem, ' ', Ten) 'Họ và tên', NgaySinh 'Ngày sinh',
	CASE GioiTinh
		WHEN 1 THEN N'Nam'
		WHEN 0 THEN N'Nữ'
	END 'Giới tính',
	L.MaLop 'Mã lớp', TenLop 'Tên lớp'
FROM SINHVIEN S INNER JOIN LOP L ON S.MaLop = L.MaLop
WHERE
	HoDem NOT LIKE N'Lê %'
	AND HoDem NOT LIKE N'Lê'
	AND HoDem NOT LIKE N'Dư %'
	AND HoDem NOT LIKE N'Dư'
	AND HoDem NOT LIKE N'Võ %'
	AND HoDem NOT LIKE N'Võ'
	AND HoDem NOT LIKE N'Nguyễn %'
	AND HoDem NOT LIKE N'Nguyễn'

--1.9
SELECT MaSinhVien, CONCAT(HoDem, ' ', Ten) AS HoTen, NgaySinh, GioiTinh, l.TenLop,sv.MaLop
FROM SINHVIEN sv
JOIN LOP l ON sv.Malop=l.MaLop
WHERE HoDem like N'Lê%' AND Ten like N'Nga' OR TEN LIKE N'Lý'

--1.10
SELECT MaSinhVien, CONCAT(HoDem, ' ', Ten) AS HoTen, NgaySinh, GioiTinh, l.TenLop,sv.MaLop
FROM SINHVIEN sv
JOIN LOP l ON sv.Malop=l.MaLop
WHERE NoiSinh IS NULL

SELECT MaSinhVien 'Sinh Viên', HoDem, Ten, NgaySinh, GioiTinh
FROM SINHVIEN
WHERE HoDem  LIKE N'%Lê%'

SELECT MaSinhVien 'Sinh Viên', HoDem, Ten, NgaySinh, GioiTinh
FROM SINHVIEN
WHERE HoDem  like N'Lê Thị%'
order by Ten asc;

--1.16
insert into SINHVIEN_HOLE
select * 
from SINHVIEN
where HoDem like N'Lê%'
SELECT * FROM SINHVIEN_HOLE

--1.17
UPDATE SINHVIEN_HOLE
SET SINHVIEN_HOLE.NOISINH=N'Quảng Bình'
where SINHVIEN_HOLE.masinhvien like '%03'

--1.18
DELETE FROM SINHVIEN_HOLE
WHERE SINHVIEN_HOLE.NGAYSINH BETWEEN '1991-03-01' AND '1991-10-01'


DELETE FROM SINHVIEN_HOLE
WHERE YEAR(NGAYSINH) = (
    SELECT YEAR(NGAYSINH)
    FROM SINHVIEN_HOLE
    WHERE MaSinhVien = 'KD02'
);

ALTER TABLE LOP
ADD TongSoSinhVien INT; 

UPDATE LOP
SET TongSoSinhVien = (
	SELECT COUNT(*)
	FROM SINHVIEN 
	WHERE SINHVIEN.MaLop=LOP.MaLop);

SELECT COUNT(SINHVIEN.MaLop) AS TongSoSv
FROM SINHVIEN
GROUP BY SINHVIEN.MaLop,