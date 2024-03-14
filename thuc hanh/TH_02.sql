--Bài thực hành số 2

--2.1 
select mahang 'Mã hàng',tenhang 'Tên hàng',donvitinh 'Đơn vị tính',gia 'Giá' 
from mathang
where thoigianbaohanh>=24

--2.2
select mahang 'Mã hàng',tenhang 'Tên hàng',gia 'Giá' 
from mathang
where gia between 400000 and 1000000

--2.3
select mahang 'Mã hàng', tenhang 'Tên hàng', gia 'Giá',
thoigianbaohanh 'TG bảo hành', tenviettat 'Tên viết tắt'
from MatHang
where ThoiGianBaoHanh =24 and TenVietTat is not Null

--2.4
select tenkhachhang 'Tên khách hàng',diachilienhe 'Địa chỉ'
from KhachHang
where Nguoilienhe like N'Nguyễn Thanh Bình'

--2.5
select mahang,tenhang,thoigianbaohanh,gia
from mathang
where MaLoaiHang in ('PC', 'LAPTOP','NET')
order by gia  DESC

--2.6
select distinct donvitinh from MatHang

--2.7
select tenhang from MatHang
where tenhang like N'%HDD%'

--2.8
select makhachhang,tenkhachhang,dienthoai,tinh.TenTinh
from KhachHang as kh
inner join 
TinhThanh as tinh
on kh.MaTinh=tinh.matinh
where dienthoai like '054%' 
and (right(DienThoai,1)=5 
or right(DienThoai,1)=9) 

--2.9
select tenkhachhang,diachilienhe
from KhachHang
where DiaChiLienHe like N'%Huế%'

--2.10
SELECT 
    mahang,
    tenhang,
    donvitinh,
    gia/25600 AS Gia_usd,
    CASE 
        WHEN DonViTinhBaoHanh = 'Ngày' THEN CONVERT(VARCHAR(10), ThoiGianBaoHanh) + ' Days'
        WHEN DonViTinhBaoHanh = 'Tuần' THEN CONVERT(VARCHAR(10), ThoiGianBaoHanh) + ' Weeks'
        WHEN DonViTinhBaoHanh = 'Tháng' THEN CONVERT(VARCHAR(10), ThoiGianBaoHanh) + ' Months'
        WHEN DonViTinhBaoHanh = 'Năm' THEN CONVERT(VARCHAR(10), ThoiGianBaoHanh) + ' Years'
    END AS ThoiGianBaoHanh_Formatted
FROM 
    mathang
