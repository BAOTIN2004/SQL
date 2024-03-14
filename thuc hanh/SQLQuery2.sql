select L.malop, tenlop,
	count (masinhvien) as 'Tong so sinh vien'
from Lop L left join sinhvien S
	on L.MaLop = s.MaLop
group by L.malop, tenlop
having count (masinhvien) =0