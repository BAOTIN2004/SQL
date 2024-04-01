--6.1


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


--6.17
select ct.orderid,ct.OrderDate,sum(ct.Price*ct.quantity) as order_value ,cu.CustomerName,ct.ShipperName,
case 
	when cu.Country in ('USA','CANADA') Then sum(ct.Price*ct.quantity)*0.03
	when cu.Country in('Argentina','Brazil','Mexico','Venezuele') THEN sum(ct.Price*ct.quantity)*0.05
	else sum(ct.Price*ct.quantity)*0.07
end as transport_fee
from 
	( select ordt.orderid, pro.productname, pro.price,ordt.quantity,ord.OrderDate,ord.customerid,ship.shippername,
		(pro.price *ordt.quantity) as SoTienPhaiThanhToanMatHang
	from Products as pro
	join orderdetails as ordt on ordt.ProductID=pro.productId
	join orders ord on ord.orderid=ordt.orderid
	join Shippers ship on ord.ShipperID=ship.ShipperID
	) as ct
join Customers cu on cu.CustomerID=ct.CustomerID
group by ct.orderid,ct.OrderDate,cu.CustomerName,ct.ShipperName,cu.Country

--6.18
select th.ShipperName, sum(transport_fee) as TienCongDaNhan
from 
		(select ct.orderid ,ct.ShipperName,
			case 
				when cu.Country in ('USA','CANADA') Then sum(ct.Price*ct.quantity)*0.03
				when cu.Country in('Argentina','Brazil','Mexico','Venezuele') THEN sum(ct.Price*ct.quantity)*0.05
				else sum(ct.Price*ct.quantity)*0.07
			end as transport_fee
		from 
			(select ordt.orderid, pro.price,ordt.quantity,ord.customerid,ship.shippername
			from Products as pro
			join orderdetails as ordt on ordt.ProductID=pro.productId
			join orders ord on ord.orderid=ordt.orderid
			join Shippers ship on ord.ShipperID=ship.ShipperID
			) as ct
		join Customers cu on cu.CustomerID=ct.CustomerID
		group by ct.orderid,cu.CustomerName,ct.ShipperName,cu.Country) th
group by th.ShipperName


--6.19
/* so luong mat hang cua cty ban ra nhiu nhat */

select sup.SupplierID,sup.SupplierName,sup.Address,count(SL.ProductID) as SoMatHangCungCap
from (
	select top 1 with ties ordt.ProductID,pro.ProductName,pro.SupplierID,sum(ordt.Quantity) as SoLuongDaCungCap
	from OrderDetails ordt
	join Products pro on ordt.ProductID=pro.ProductID
	group by ordt.ProductID,pro.ProductName,pro.SupplierID
	order by sum(ordt.Quantity) desc) as SL
join Suppliers sup on SL.SupplierID=sup.SupplierID
group by sup.SupplierID,sup.SupplierName,sup.Address

--6.20
select Top 1 with ties pro.ProductName,sum(ordt.Quantity*pro.Price) as TongDoanhThu
from OrderDetails ordt
join Products pro on ordt.ProductID=pro.ProductID
join Orders ord on ordt.OrderID=ord.OrderID
where year(ord.OrderDate)=2017
group by pro.ProductName
order by sum(ordt.Quantity*pro.Price) desc

--c2
select pro.ProductName,sum(ordt.Quantity*pro.Price) as TongDoanhThu
from OrderDetails ordt
join Products pro on ordt.ProductID=pro.ProductID
join Orders ord on ordt.OrderID=ord.OrderID
where year(ord.OrderDate)=2017
group by pro.ProductName
having sum(ordt.Quantity*pro.Price)>=all(
		select  sum(ordt.Quantity*pro.Price) as TongDoanhThu
		from OrderDetails ordt
		join Products pro on ordt.ProductID=pro.ProductID
		join Orders ord on ordt.OrderID=ord.OrderID
		where year(ord.OrderDate)=2017
		group by pro.ProductName)

--6.21
select top 1 with ties emp.EmployeeID, CONCAT(emp.firstname,'',emp.LastName) as HoTen , sum(ordt.Quantity*pro.Price) as TongTienDaDemVe
from Employees emp
join Orders ord on emp.EmployeeID=ord.EmployeeID
join OrderDetails ordt on ord.OrderID=ordt.OrderID
join Products pro on ordt.ProductID=pro.ProductID
where year(ord.orderdate)=2017
group by emp.EmployeeID, CONCAT(emp.firstname,'',emp.LastName)
order by sum(ordt.Quantity*pro.Price) desc
