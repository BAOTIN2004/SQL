--7.1
CREATE PROCEDURE sp_Print_CurrentDate
AS
BEGIN
    PRINT N'Ngày hiện tại: ' + CONVERT(nvarchar, GETDATE(), 103);
END
execute sp_Print_CurrentDate

--7.2
-- Tạo stored procedure
CREATE PROCEDURE TinhHCN
    @cd FLOAT,
    @cr FLOAT,
    @cv FLOAT OUTPUT,
    @s FLOAT OUTPUT
AS
BEGIN
    SELECT @s = @cd * @cr
    SELECT @cv = 2 * (@cd + @cr)
END
DECLARE @s FLOAT = 0
DECLARE @cv FLOAT -- Chú ý: Cần khai báo biến @cv trước khi sử dụng
EXECUTE TinhHCN 2, 5, @cv OUTPUT, @s OUTPUT
select @s AS DienTich, @cv as ChuVi

--7.3
create procedure DSSV (@malop nvarchar(50),@tenlop nvarchar(50))
as 
begin 
	select sv.MaSinhVien,CONCAT(sv.HoDem,'',sv.Ten) as HoTen,sv.NgaySinh,l.MaLop,l.TenLop
	from SINHVIEN sv
	join LOP l on sv.MaLop=l.MaLop
	where l.MaLop=@malop and l.TenLop=@tenlop
end
EXEC DSSV 'K45HDDL',N'Lớp K45HDDL'

--7.5
CREATE PROCEDURE DSSV_GT3
    @gt BIT,
    @noisinh NVARCHAR(30)
AS 
BEGIN 
    SELECT 
        sv.MaSinhVien,
        CONCAT(sv.HoDem, ' ', sv.Ten) AS HoTen,
        CASE 
            WHEN sv.GioiTinh = 1 THEN N'Nam'
            ELSE N'Nữ'
        END AS GioiTinh,
        sv.NoiSinh
    FROM 
        SINHVIEN sv
    WHERE 
        sv.NoiSinh LIKE '%' + @noisinh + '%'
        AND (@gt IS NULL OR sv.GioiTinh = @gt)
END;

-- Gọi stored procedure với tham số giới tính là 1 (Nam) và nơi sinh là 'Huế'
EXEC DSSV_GT3 0, N'Huế';

--7.6

create procedure DSSV_Date (@tu_thang int ,@den_thang int)
as 
begin 
	if @tu_thang > @den_thang
	begin 
		print ('Du lieu khong hop le ')
		return
	end
	begin try 
	select concat(sv.HoDem,' ',sv.Ten),sv.NgaySinh
	from SINHVIEN sv
	where MONTH(sv.Ngaysinh) between @tu_thang and @den_thang
	end try 
	BEGIN CATCH
        -- Xử lý ngoại lệ ở đây
        PRINT 'Có lỗi xảy ra: ' + ERROR_MESSAGE()
    END CATCH
end 

exec DSSV_Date 8,9

--7.7
create procedure DSSV_Noisinh(@noisinh nvarchar(50))
as 
	begin 
		select sv.MaSinhVien,CONCAT(sv.Hodem,' ',sv.Ten) as HoTen,sv.NgaySinh,sv.NoiSinh
		from SINHVIEN sv
		where sv.Noisinh like '%'+@noisinh+'%'
	end
exec DSSV_Noisinh N'Quảng Trị'

--7.8
create procedure TongDiem (@masv nvarchar(50))
as 
	begin 
		select sv.MaSinhVien,concat(sv.HoDem,' ',sv.Ten) as  HoTen, (dts.Diemmon1+dts.Diemmon2+dts.Diemmon3) as TongDiem
		from SINHVIEN sv
		join DIEMTS dts on sv.masinhvien=dts.masinhvien
		where sv.MaSinhVien = @masv
	end
exec TongDiem N'DL01'

--7.9
create procedure TongSvLop (@tenlop nvarchar(50))
as 
	BEGIN 
    IF NOT EXISTS (SELECT 1 FROM LOP WHERE TenLop = @tenlop)
    BEGIN 
        PRINT N'Lớp không tồn tại'
        RETURN
    END
	begin try
		select LOP.MaLop,LOP.TenLop,count(sv.MaLop) as SoLuongSv
		from LOP
		join SINHVIEN sv on LOP.MaLop=sv.MaLop
		group by LOP.MaLop,LOP.TenLop
	end try
	BEGIN CATCH
        -- Xử lý ngoại lệ ở đây
        PRINT 'Có lỗi xảy ra: ' + ERROR_MESSAGE()
    END CATCH
end;
exec TongSvLop N'Lớp K45HDDL'

--7.10


--7.11
create procedure Ss_diem2 (@masv1 nvarchar(50),@masv2 nvarchar(50))
as 
begin
	DECLARE @DiemMon1_SV1 FLOAT
	DECLARE @DiemMon1_SV2 FLOAT

	SELECT @DiemMon1_SV1 = DIEMTS.Diemmon1
    FROM DIEMTS 
    WHERE MaSinhVien = @masv1

	SELECT @DiemMon1_SV2 = DIEMTS.Diemmon1
    FROM DIEMTS 
    WHERE MaSinhVien = @masv2

	if @DiemMon1_SV1>@DiemMon1_SV2
	begin 
		select sv.MaSinhVien, CONCAT(sv.HoDem,' ',sv.Ten) as HoTen,sv.NgaySinh,DIEMTS.Diemmon1
		from SINHVIEN sv
		join DIEMTS on sv.MaSinhVien=DIEMTS.MaSinhVien
		where sv.MaSinhVien=@masv1
	end
	else if @DiemMon1_SV1<@DiemMon1_SV2
		begin 
		select sv.MaSinhVien, CONCAT(sv.HoDem,' ',sv.Ten) as HoTen,sv.NgaySinh,DIEMTS.Diemmon1
		from SINHVIEN sv
		join DIEMTS on sv.MaSinhVien=DIEMTS.MaSinhVien
		where sv.MaSinhVien=@masv2
	end
	else 
	BEGIN
        PRINT 'Hai sinh viên có cùng điểm môn 1.'
    END
end

Ss_diem2 'DL02','KD01'

--3.12
create procedure Ss_tongdiem1 (@masv1 nvarchar(50),@masv2 nvarchar(50))
as 
begin
	
	DECLARE @TongDiem_SV1 FLOAT
	DECLARE @TongDiem_SV2 FLOAT

	SELECT @TongDiem_SV1 = (Diemmon1+Diemmon2+Diemmon3)
    FROM DIEMTS 
    WHERE MaSinhVien = @masv1

	SELECT @TongDiem_SV2 = (Diemmon1+Diemmon2+Diemmon3)
    FROM DIEMTS 
    WHERE MaSinhVien = @masv2

	if @TongDiem_SV1>@TongDiem_SV2
	begin 
		select sv.MaSinhVien, CONCAT(sv.HoDem,' ',sv.Ten) as HoTen,sv.NgaySinh,DIEMTS.Diemmon1,Diemmon2,Diemmon3
				,(Diemmon1+Diemmon2+Diemmon3) as TongDiem
		from SINHVIEN sv
		join DIEMTS on sv.MaSinhVien=DIEMTS.MaSinhVien
		where sv.MaSinhVien=@masv1
	end
	else if @TongDiem_SV1<@TongDiem_SV2
		begin 
		select sv.MaSinhVien, CONCAT(sv.HoDem,' ',sv.Ten) as HoTen,sv.NgaySinh,DIEMTS.Diemmon1,Diemmon2,Diemmon3
				,(Diemmon1+Diemmon2+Diemmon3) as TongDiem
		from SINHVIEN sv
		join DIEMTS on sv.MaSinhVien=DIEMTS.MaSinhVien
		where sv.MaSinhVien=@masv2
	end
	else 
	BEGIN
        PRINT 'Hai sinh viên có cùng điểm môn 1.'
    END
end

exec Ss_tongdiem1 'KD02','KD01'