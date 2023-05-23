use NORTHWND;

select SupplierID, ContactName, ContactTitle, Address, City, Country, Phone
from Suppliers;

--Next time, if you want to get the same result set, you can save this query into a text file, open it, and execute it again.
--SQL Server provides a better way to save this query in the database catalog through a view.
--A view is a named query stored in the database catalog that allows you to refer to it later.



create view SupplierInfo as
select SupplierID, ContactName, ContactTitle, Address, City, Country, Phone
from Suppliers;
select * from SupplierInfo;


create view Nummber_of_Customers_in_Country_greater_than_5 as
SELECT Country, COUNT(CustomerID) AS '# Customers'
FROM Customers
GROUP BY Country
HAVING COUNT(CustomerID) > 5;
select * from Nummber_of_Customers_in_Country_greater_than_5;

--2 table join
create view Orders_Customers_Shippers as
SELECT Orders.OrderID, 
		Customers.CompanyName as 'Customer Company', 
		Shippers.CompanyName as 'Shipping Company'
FROM (
		Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID
		JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
	); 
select * from Orders_Customers_Shippers;

--alter
alter view Orders_Customers_Shippers as
SELECT Orders.OrderID, 
		Orders.Freight,
		Customers.CompanyName as 'Customer Company', 
		Shippers.CompanyName as 'Shipping Company'
FROM (
		Orders JOIN Customers ON Orders.CustomerID = Customers.CustomerID
		JOIN Shippers ON Orders.ShipVia = Shippers.ShipperID
	); 
select * from Orders_Customers_Shippers;


--drop
drop view Orders_Customers_Shippers;


--Stored Procedure: SQL programming
create procedure Product_greater_than_50 as
begin
	select ProductID, ProductName, UnitPrice
	from Products
	where UnitPrice > 50
end;

exec Product_greater_than_50;

--alter
alter procedure Product_greater_than_50 as
begin
	select ProductID, ProductName, UnitPrice, QuantityPerUnit
	from Products
	where UnitPrice > 50
end;

--drop
drop procedure Product_greater_than_50;


--1 input parameter
create procedure Product_greater_than (@price as money) as
begin
	select ProductID, ProductName, UnitPrice
	from Products
	where UnitPrice > @price
end;

exec Product_greater_than 70;
exec Product_greater_than @price=70;

--multiple input parameter
create procedure Product_between (
	@low as money,
	@high as money
) as
begin
	select ProductID, ProductName, UnitPrice
	from Products
	where UnitPrice between @low and @high
end;

exec Product_between @low=20, @high=50;


