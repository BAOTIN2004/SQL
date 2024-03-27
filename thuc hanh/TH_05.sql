--5.1
select maloaihang,count(maloaihang) as 'so luong'
from mathang
group by maloaihang

--5.2
select maloaihang,nsx.tennhasx,count(maloaihang) as 'so luong'
from MatHang mh inner join NhaSanXuat nsx
on mh.MaNhaSX=nsx.MaNhaSX
group by nsx.TenNhaSX,mh.MaLoaiHang

--5.3
select kh.matinh,tt.tentinh,count(kh.matinh) as 'so luong'
from khachhang kh inner join TinhThanh tt
on kh.MaTinh=tt.MaTinh
group by kh.matinh,tt.TenTinh

--5.4
SELECT nhk.manhomkh, nhk.tennhomkh, COUNT(kh.makhachhang) AS so_luong_khach_hang
FROM nhomkhachhang nhk
LEFT JOIN khachhang kh ON nhk.manhomkh = kh.manhomkh
GROUP BY nhk.manhomkh, nhk.tennhomkh;

--5.5

--5.6

--5.7
select mh.MaLoaiHang,lh.tenloaihang, count(mh.MaLoaiHang) 'so luong'
from MatHang mh
left join LoaiHang lh on mh.MaLoaiHang=lh.MaLoaiHang
group by mh.MaLoaiHang,lh.tenloaihang
having count(mh.MaLoaiHang)>2

--5.9
SELECT ct.mahang, mh.tenhang, SUM(ct.soluong * ct.dongia) AS doanh_thu
FROM chitietchungtu ct
JOIN mathang mh ON ct.mahang = mh.mahang
JOIN nhasanxuat nsx ON mh.manhasx = nsx.manhasx
WHERE nsx.tennhasx = 'Hãng máy tính IBM'
GROUP BY ct.mahang, mh.tenhang

--5.10
SELECT ct.mahang, mh.tenhang, SUM(ct.soluong * ct.dongia) AS doanh_thu
FROM chitietchungtu ct
JOIN mathang mh ON ct.mahang = mh.mahang
JOIN nhasanxuat nsx ON mh.manhasx = nsx.manhasx
WHERE nsx.tennhasx = 'Hãng máy tính IBM'
GROUP BY ct.mahang, mh.tenhang

select ct.mahang,sum(ct.soluong*ct.dongia) as doanh_thu
from ChiTietChungTu ct
JOIN mathang mh ON ct.mahang = mh.mahang
JOIn ChungTuBanHang ctbh on ct.SoChungTu=ctbh.SoChungTu
where year(ctbh.NgayLapChungTu)=2010
group by ct.MaHang
having sum(ct.soluong*ct.dongia)>10000000;



--5.18
select MatHang.MaHang,MatHang.TenHang
from MatHang
where MatHang.MaLoaiHang=(select MatHang.MaLoaiHang
from MatHang 
where MatHang.MaHang='PC001')

--5.19
select  KhachHang.MaKhachHang,KhachHang.TenKhachHang, KhachHang.DienThoai
from KhachHang
join TinhThanh on KhachHang.MaTinh = TinhThanh.MaTinh
where KhachHang.MaTinh=(select KhachHang.MaTinh from KhachHang
where KhachHang.TenKhachHang Like N'Trần Nguyên Phong')

--5.20
select NhomKhachHang.MaNhomKH, KhachHang.MaKhachHang,KhachHang.TenKhachHang
from KhachHang
join NhomKhachHang on KhachHang.MaNhomKH=NhomKhachHang.MaNhomKH
where KhachHang.MaNhomKH=(select KhachHang.MaNhomKH from KhachHang
where KhachHang.TenKhachHang Like N'Nguyễn Thanh Bình')

--5.21
SELECT  LoaiHang.TenLoaiHang, COUNT(MatHang.MaLoaiHang) AS so_luong
FROM MatHang 
JOIN LoaiHang ON LoaiHang.MaLoaiHang = MatHang.MaLoaiHang
GROUP BY LoaiHang.TenLoaiHang,MatHang.MaLoaiHang
ORDER BY so_luong DESC


--5.22
SELECT MatHang.MaNhaSX,NhaSanXuat.TenNhaSX ,COUNT(MatHang.MaNhaSX) AS so_luong
FROM MatHang 
LEFT JOIN NhaSanXuat ON NhaSanXuat.MaNhaSX = MatHang.MaNhaSX
GROUP BY MatHang.MaNhaSX,NhaSanXuat.TenNhaSX
having count(mathang.manhasx) >= ALL(
	select count(MatHang.MaNhaSX)
	from MatHang
	group by MatHang.MANHASX)

--5.23
select top 1 WITH TIES TinhThanh.MaTinh,TinhThanh.TenTinh,count(Khachhang.MaTinh) as so_luong
from KhachHang
join TinhThanh on KhachHang.MaTinh=TinhThanh.MaTinh
group by TinhThanh.MaTinh,TinhThanh.TenTinh
order by so_luong desc;


SELECT TINHTHANH.MaTinh,TINHTHANH.TenTinh ,COUNT(KhachHang.MaTinh) AS so_luong
FROM KhachHang
LEFT JOIN TinhThanh ON KhachHang.MaTinh = TinhThanh.MaTinh
GROUP BY TINHTHANH.MaTinh,TINHTHANH.TenTinh
having count(KhachHang.MaTinh) >= ALL(
	select count(KhachHang.MaTinh)
	from KhachHang
	group by KhachHang.MaTinh)

--5.24
select MatHang.MaHang, MatHang.TenHang,
sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as doanh_thu
from MatHang
join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
group by MatHang.MaHang,MatHang.TenHang
having sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia)>=all(
		select MatHang.MaHang, MatHang.TenHang,
sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as doanh_thu
from MatHang
join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
group by MatHang.MaHang,MatHang.TenHang)

select top 1 MatHang.MaLoaiHang,LoaiHang.TenLoaiHang,
sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as doanh_thu
from MatHang
join LoaiHang on MatHang.MaLoaiHang=LoaiHang.MaLoaiHang
join ChiTietChungTu on ChiTietChungTu.MaHang=MatHang.MaHang
group by MatHang.MaLoaiHang,LoaiHang.TenLoaiHang
order by doanh_thu desc;


--5.25.1
select MatHang.MaHang,MatHang.TenHang, sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as TongDoanhThu
from MatHang
join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
group by  MatHang.MaHang,MatHang.TenHang
having sum(cast(ChiTietChungTu.SoLuong as bigint) *cast(ChiTietChungTu.DonGia as bigint) )>
	(
	select avg(TongDoanhThu.Tong)
	from 
	( select MatHang.MaHang,MatHang.TenHang, sum(cast(ChiTietChungTu.SoLuong as bigint)*cast(ChiTietChungTu.DonGia as bigint)) as Tong
		from MatHang
	join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
	group by  MatHang.MaHang,MatHang.TenHang )as TongDoanhThu)

--5.25.2
select MatHang.MaLoaiHang,LoaiHang.TenLoaiHang,
SUM(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) AS DoanhThuLoaiHang
from MatHang
join LoaiHang on MatHang.MaLoaiHang=LoaiHang.MaLoaiHang
join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
group by MatHang.MaLoaiHang,LoaiHang.TenLoaiHang
having SUM(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) >(
	select avg(TongDoanhThu.Tong)
	from (
		select MatHang.MaLoaiHang,LoaiHang.TenLoaiHang,
			SUM(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) AS Tong
	from MatHang
	join LoaiHang on MatHang.MaLoaiHang=LoaiHang.MaLoaiHang
	join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
	group by MatHang.MaLoaiHang,LoaiHang.TenLoaiHang
		) as TongDoanhThu)

--5.26
--C1
select KhachHang.MaKhachHang,KhachHang.TenKhachHang,sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as TongChi
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang
having sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia)=(
	select max(TongChi.TongChi)
	from (select KhachHang.MaKhachHang,KhachHang.TenKhachHang,sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as TongChi
	from KhachHang
	join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
	join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
	group by KhachHang.MaKhachHang,KhachHang.TenKhachHang )as TongChi)
--C2
select top 1 with ties  KhachHang.MaKhachHang, KhachHang.TenKhachHang,
sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as TongChi
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang
order by sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) desc

--5.27
--c1
select  MaKhachHang,TenKhachHang,SoChungTu,sum(DonGia*SoLuong) as GiaTriDonHang
from (select KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu,
ChiTietChungTu.SoLuong,
sum(ChiTietChungTu.DonGia*ChiTietChungTu.SoLuong) as gia_tri_don_hang
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
where year(ChungTuBanHang.NgayLapChungTu)=2010 and KhachHang.MaKhachHang is not null
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,
ChiTietChungTu.SoLuong,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu) as Tong
group by MaKhachHang,TenKhachHang,SoChungTu
having sum(DonGia*SoLuong)=( select max(T.GiaTriDonHang) 
from (select  MaKhachHang,TenKhachHang,SoChungTu,sum(DonGia*SoLuong) as GiaTriDonHang
from (select KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu,
ChiTietChungTu.SoLuong,
sum(ChiTietChungTu.DonGia*ChiTietChungTu.SoLuong) as gia_tri_don_hang
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
where year(ChungTuBanHang.NgayLapChungTu)=2010 and KhachHang.MaKhachHang is not null
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,
ChiTietChungTu.SoLuong,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu) as Tong
group by MaKhachHang,TenKhachHang,SoChungTu) as T )

--c2
select Top 1 with ties MaKhachHang,TenKhachHang,SoChungTu,sum(DonGia*SoLuong) as GiaTriDonHang
from (select KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu,
ChiTietChungTu.SoLuong,
sum(ChiTietChungTu.DonGia*ChiTietChungTu.SoLuong) as gia_tri_don_hang
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
where year(ChungTuBanHang.NgayLapChungTu)=2010 and KhachHang.MaKhachHang is not null
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,
ChiTietChungTu.SoLuong,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu) as Tong
group by MaKhachHang,TenKhachHang,SoChungTu
order by sum(DonGia*SoLuong) desc



---------
select Top 1 with ties MaKhachHang,TenKhachHang,SoChungTu,sum(DonGia*SoLuong) as GiaTriDonHang
from (select KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu,
ChiTietChungTu.SoLuong,
sum(ChiTietChungTu.DonGia*ChiTietChungTu.SoLuong) as gia_tri_don_hang
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
where year(ChungTuBanHang.NgayLapChungTu)=2010 and KhachHang.MaKhachHang is not null
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,
ChiTietChungTu.SoLuong,ChiTietChungTu.DonGia,ChiTietChungTu.SoChungTu) as Tong
group by MaKhachHang,TenKhachHang,SoChungTu
order by sum(DonGia*SoLuong) desc

--5.28
--c1
select  KhachHang.MaKhachHang,KhachHang.TenKhachHang,sum(PhieuThuTien.SoTien) AS TienDaNhan,
	ChungTuBanHang.SoChungTu
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join PhieuThuTien on ChungTuBanHang.SoChungTu=PhieuThuTien.SoChungTu
where PhieuThuTien.LyDo like N'Thu tiền mua hàng'
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChungTuBanHang.SoChungTu
having sum(PhieuThuTien.SoTien)>=all(
	select TienDaNhan.Tien
	from (
	 select KhachHang.MaKhachHang,KhachHang.TenKhachHang,sum(PhieuThuTien.SoTien) AS Tien,
	ChungTuBanHang.SoChungTu
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join PhieuThuTien on ChungTuBanHang.SoChungTu=PhieuThuTien.SoChungTu
where PhieuThuTien.LyDo like N'Thu tiền mua hàng'
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChungTuBanHang.SoChungTu
) as TienDaNhan);

--c2
select top 1 with ties KhachHang.MaKhachHang,KhachHang.TenKhachHang,sum(PhieuThuTien.SoTien) AS TienDaThu,
	ChungTuBanHang.SoChungTu
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join PhieuThuTien on ChungTuBanHang.SoChungTu=PhieuThuTien.SoChungTu
where PhieuThuTien.LyDo like N'Thu tiền mua hàng'
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChungTuBanHang.SoChungTu
order by sum(PhieuThuTien.SoTien) desc;

--5.29
/*số chứng từ, ngày lập chứng từ, tên khách hàng và tổng số tiền hàng */
SELECT TABLE_Tien_Hang.SOCT, TABLE_Tien_Hang.NgayLapChungTu, TenKhachHang, 
		Tien_Hang
FROM
	(SELECT  C.SoChungTu SOCT, NgayLapChungTu, MaKhachHang, SUM(Soluong*Dongia) Tien_Hang
	 FROM ChungTuBanHang C LEFT JOIN ChiTietChungTu T
			ON C.SoChungTu = T.SoChungTu
	GROUP BY C.SoChungTu, NgayLapChungTu, MaKhachHang) AS TABLE_Tien_Hang
INNER JOIN
	(SELECT  C.SoChungTu SOCT, NgayLapChungTu, SUM(SoTien) Tien_Da_Thu
	FROM ChungTuBanHang C LEFT JOIN PhieuThuTien P
			ON C.SoChungTu = P.SoChungTu
	GROUP BY C.SoChungTu, NgayLapChungTu) AS TABLE_Da_Thu
ON TABLE_Tien_Hang.SOCT = TABLE_Da_Thu.SOCT
LEFT JOIN KhachHang K ON TABLE_Tien_Hang.MaKhachHang = K.MaKhachHang
WHERE Tien_Hang > Tien_Da_Thu






SELECT 
    CTBH.SoChungTu,
	CTBH.MaKhachHang,
	CTBH.TenKhachHang,
    CTBH.TongHoaDon AS TongTienCanThu,
    COALESCE(PTT.TongDaThu, 0) AS TongDaThu,
    (CTBH.TongHoaDon - COALESCE(PTT.TongDaThu, 0)) AS ConLai
FROM (
    -- Tính tổng tiền cần thu
    SELECT 
        CTBH.SoChungTu,
		KH.MaKhachHang,
		KH.TenKhachHang,
        SUM(CTCT.SoLuong * CTCT.DonGia) AS TongHoaDon
    FROM ChungTuBanHang CTBH
    JOIN ChiTietChungTu CTCT ON CTBH.SoChungTu = CTCT.SoChungTu
	JOIN KhachHang KH on CTBH.MaKhachHang=KH.MaKhachHang
    GROUP BY CTBH.SoChungTu,KH.MaKhachHang,Kh.TenKhachHang
) AS CTBH
LEFT JOIN (
    -- Tính tổng tiền đã thanh toán
    SELECT 
        PTT.SoChungTu,
        SUM(PTT.SoTien) AS TongDaThu
    FROM PhieuThuTien PTT
    WHERE PTT.LyDo LIKE N'Thu tiền mua hàng'
    GROUP BY PTT.SoChungTu
) AS PTT ON CTBH.SoChungTu = PTT.SoChungTu
WHERE (CTBH.TongHoaDon - COALESCE(PTT.TongDaThu, 0)) > 0

















select * from bh
	(select  ChungTuBanHang.SoChungTu,KhachHang.MaKhachHang,KhachHang.TenKhachHang,
sum(PhieuThuTien.SoTien) AS TienDaNhan

from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join PhieuThuTien on ChungTuBanHang.SoChungTu=PhieuThuTien.SoChungTu
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
where PhieuThuTien.LyDo like N'Thu tiền mua hàng'
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChungTuBanHang.SoChungTu) as bh) 

select TongTienCanThu.SoChungTu,TongTienCanThu.TongThu, DaThu.TongDaThu
	from (
--Tong tien da thu theo so chung tu
		SELECT 
			PhieuThuTien.SoChungTu,
			sum(PhieuThuTien.SoTien) as TongDaThu
		from PhieuThuTien
		WHERE 
			PhieuThuTien.LyDo LIKE N'Thu tiền mua hàng'
		GROUP BY 
		   PhieuThuTien.SoChungTu) as DaThu)

from (
--TongTienCanThu
(select ChungTuBanHang.SoChungTu,sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as TongThu
from ChungTuBanHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
group by ChungTuBanHang.SoChungTu ) as TongTienCanThu


select DaThu.TongDaThu
from (
--Tong tien da thu theo so chung tu
SELECT 
    PhieuThuTien.SoChungTu,

	sum(PhieuThuTien.SoTien) as TongDaThu
	
from PhieuThuTien
WHERE 
    PhieuThuTien.LyDo LIKE N'Thu tiền mua hàng'
GROUP BY 
   PhieuThuTien.SoChungTu) as DaThu





;
select tb.SoChungTu, khachhang.MaKhachHang, khachhang.TenKhachHang,
tb.[Tổng thu], tb.[Đã thu], tb.[Còn lại]
from
(select tb1.SoChungTu,  tb1.[Tổng thu], tb2.[Đã thu],
tb1.[Tổng thu] - tb2.[Đã thu] as [Còn lại]
from 
(select sochungtu, sum(dongia*soluong) as [Tổng thu]
from ChiTietChungTu
group by sochungtu) as tb1
inner join 
(select sochungtu,  sum(sotien) as [Đã thu]
from PhieuThuTien
group by SoChungTu) as tb2
on tb1.SoChungTu = tb2.SoChungTu) as tb
full outer join ChungTuBanHang
on tb.SoChungTu = ChungTuBanHang.SoChungTu
full outer join KhachHang
on ChungTuBanHang.MaKhachHang = khachhang.MaKhachHang
-- where tb.[Còn lại] > 0