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
SELECT TOP 1 LoaiHang.TenLoaiHang, COUNT(MatHang.MaLoaiHang) AS so_luong
FROM MatHang 
JOIN LoaiHang ON LoaiHang.MaLoaiHang = MatHang.MaLoaiHang
GROUP BY LoaiHang.TenLoaiHang
ORDER BY so_luong DESC;

--5.22
SELECT TOP 1 MatHang.MaNhaSX,NhaSanXuat.TenNhaSX ,COUNT(MatHang.MaNhaSX) AS so_luong
FROM MatHang 
JOIN NhaSanXuat ON NhaSanXuat.MaNhaSX = MatHang.MaNhaSX
GROUP BY MatHang.MaNhaSX,NhaSanXuat.TenNhaSX
ORDER BY so_luong DESC;

--5.23
select top 1 TinhThanh.MaTinh,TinhThanh.TenTinh,count(Khachhang.MaTinh) as so_luong
from KhachHang
join TinhThanh on KhachHang.MaTinh=TinhThanh.MaTinh
group by TinhThanh.MaTinh,TinhThanh.TenTinh
order by so_luong desc;

--5.24
select top 1 MatHang.MaLoaiHang,LoaiHang.TenLoaiHang,
sum(ChiTietChungTu.SoLuong*ChiTietChungTu.DonGia) as doanh_thu
from MatHang
join LoaiHang on MatHang.MaLoaiHang=LoaiHang.MaLoaiHang
join ChiTietChungTu on ChiTietChungTu.MaHang=MatHang.MaHang
group by MatHang.MaLoaiHang,LoaiHang.TenLoaiHang
order by doanh_thu desc;


--5.25.1
SELECT MaHang,
       SUM(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) AS TongDoanhThu,
       (SELECT AVG(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) FROM ChiTietChungTu) AS DoanhThuTrungBinhTatCa
FROM ChiTietChungTu
GROUP BY MaHang
HAVING SUM(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) >
(SELECT AVG(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) FROM ChiTietChungTu);

--5.25.2
select MatHang.MaLoaiHang,LoaiHang.TenLoaiHang,
SUM(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) AS TongDoanhThu,
       (SELECT AVG(CAST(SoLuong AS decimal) * CAST(DonGia AS decimal)) FROM ChiTietChungTu) AS DoanhThuTrungBinhTatCa
from MatHang
join LoaiHang on MatHang.MaLoaiHang=LoaiHang.MaLoaiHang
join ChiTietChungTu on MatHang.MaHang=ChiTietChungTu.MaHang
group by MatHang.MaLoaiHang,LoaiHang.TenLoaiHang

--5.26
select top 1 KhachHang.MaKhachHang, KhachHang.TenKhachHang,
sum(PhieuThuTien.SoTien) as 'Tien da chi'
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join PhieuThuTien on ChungTuBanHang.SoChungTu=PhieuThuTien.SoChungTu
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang

--5.27
select top 1 KhachHang.MaKhachHang,KhachHang.TenKhachHang,ChiTietChungTu.DonGia,
ChiTietChungTu.SoLuong,
(ChiTietChungTu.DonGia*ChiTietChungTu.SoLuong) as gia_tri_don_hang
from KhachHang
join ChungTuBanHang on KhachHang.MaKhachHang=ChungTuBanHang.MaKhachHang
join ChiTietChungTu on ChungTuBanHang.SoChungTu=ChiTietChungTu.SoChungTu
where year(ChungTuBanHang.NgayLapChungTu)=2010
group by KhachHang.MaKhachHang,KhachHang.TenKhachHang, 
ChiTietChungTu.DonGia, ChiTietChungTu.SoLuong
order by gia_tri_don_hang desc;

--5.28





