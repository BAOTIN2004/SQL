--6.1
select * 
from 

--6.2
select Cate.CategoryID,Cate.CategoryName,count(Pro.CategoryID) as SoLuong
from Categories as Cate
join Products Pro on Cate.CategoryID=Pro.CategoryID
group by Cate.CategoryID,Cate.CategoryName

--6.3
select Cu.CustomerID,Cu.CustomerName,count(Ord.CustomerID) as SoLanMuaHang
from Customers as Cu
right join Orders Ord on Cu.CustomerID=Ord.CustomerID
group by Cu.CustomerID, Cu.CustomerName

--6.4
select Ship.ShipperID,Ship.ShipperName,count(Ord.ShipperID) as SoLuongDonDaGiao
from Shippers as Ship
join Orders as Ord on Ship.ShipperID=Ord.ShipperID
group by Ship.ShipperID,Ship.ShipperName

--6.5
Select Sup.country,count(Sup.Country) as SoLuongNcc
from Suppliers as Sup
group by  Sup.Country

--6.6
Select Cu.country,count(Cu.Country) as SoLuongKH
from Suppliers as Cu
group by  Cu.Country

--6.7

--6.8
Select emp.EmployeeID,concat(emp.FirstName,'',emp.LastNAme) as TenNV, count(ord.employeeid) as SoLuongDonHangDaLap
from Employees as emp
join Orders ord on ord.employeeid=emp.employeeid
where month(ord.orderdate)=8 and year(ord.orderdate)=2016
group by emp.EmployeeID,concat(emp.FirstName,'',emp.LastNAme)

--6.11
select ordt.orderid, pro.productname, pro.price,ordt.quantity, (pro.price *ordt.quantity) as SoTienPhaiThanhToanMatHang
from Products as pro
join orderdetails as ordt on ordt.ProductID=pro.productId
join orders ord on ord.orderid=ordt.orderid
order by ordt.orderid desc

--6.12
select ct.orderid,ct.OrderDate,sum(ct.Price*ct.quantity) as GiaTriDonHang,cu.CustomerName,ct.ShipperName,ct.Name_emp
from 
	( select ordt.orderid, pro.productname, pro.price,ordt.quantity,ord.OrderDate,ord.customerid,ship.shippername,
		concat(emp.firstname,'',emp.lastname) as Name_emp,
		(pro.price *ordt.quantity) as SoTienPhaiThanhToanMatHang
	from Products as pro
	join orderdetails as ordt on ordt.ProductID=pro.productId
	join orders ord on ord.orderid=ordt.orderid
	join Shippers ship on ord.ShipperID=ship.ShipperID
	join Employees emp on ord.EmployeeID=emp.EmployeeID

	) as ct
join Customers cu on cu.CustomerID=ct.CustomerID
where year(ct.OrderDate)=2017
group by ct.orderid,ct.OrderDate,cu.CustomerName,ct.ShipperName,ct.Name_emp
