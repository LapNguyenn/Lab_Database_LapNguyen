use NORTHWND;

/*************************

FOR EACH OF THE FOLLOWING QUESTIONS: 
	CREATE A STORED PROCEDURE (SP) WITH A PROPER NAME
	RUN THE SP USING EXEC

**************************/



--ex: find all countries which have more than (@supp=2) suppliers
create procedure Countries_suppliers_more_than(@supp as int) as
begin
	select Country, COUNT(SupplierID) as '#Supplier ID'
	from Suppliers
	group by Country
	having COUNT(SupplierID) > @supp;
end

exec Countries_suppliers_more_than @supp = 2

--ex: find all ContactTitle in Customers table which have less than (@cust=4) customerIDs
create procedure ContactTitle_customers_having_less_than(@cust as int) as
begin
	select ContactTitle, COUNT(CustomerID) as '#Customer ID'
	from Customers
	group by ContactTitle
	having COUNT(CustomerID) > @cust
end

exec ContactTitle_customers_having_less_than @cust = 4;

-- find all companyName, contactName in suppliers table, ordered by City desc
create procedure Name_of_company_contact_descending_by_City_name as
begin
	select CompanyName, ContactName, City
	from Suppliers
	order by City desc
end

exec Name_of_company_contact_descending_by_City_name

-- find all contactName in suppliers table, ordered by City asc, companyName desc
create procedure Name_of_contact_ordered_by_ascending_City_decending_companyName as 
begin
	select ContactName, CompanyName, City
	from Suppliers
	order by City, CompanyName desc;
end

exec Name_of_contact_ordered_by_ascending_City_decending_companyName

-- find CompanyName (Suppliers table) who supply products (Products table) of which unitprice > (@price=90)
create procedure CompanyName_supply_product_with_price_more_than (@price as money) as
begin
	select s.CompanyName, p.ProductName, p.UnitPrice
	from Suppliers as s
	join Products as p on p.SupplierID = s.SupplierID
	where p.UnitPrice > @price 
end

exec CompanyName_supply_product_with_price_more_than @price  = 90

-- find CategoryName (Categories table) which have products' unitInStock = (@stock=0) (products tables)
create procedure CategoryName_having_products_in_stock_equal(@stock as int) as
begin
	select distinct c.CategoryName, p.ProductName, p.UnitsInStock
	from Categories as c
	join Products as p on p.CategoryID = c.CategoryID
	where p.UnitsInStock = @stock;
end

exec CategoryName_having_products_in_stock_equal @stock = 0
--run the following insert
insert into Suppliers (CompanyName)
values ('FPT');

--then find all CompanyName (Suppliers table) who do not supply any products (Products table).
create procedure Company_not_supply_any_products as
begin
	select s.CompanyName
	from Suppliers as s
	join Products as p on p.SupplierID = s.SupplierID
	where p.UnitsInStock = 0;
end

exec Company_not_supply_any_products

--run the following insert
insert into Region (RegionID, RegionDescription)
values (5, 'Asia');
--then find all RegionDescription (Region table) which do not have territories(Territories table)
create procedure RegionDescription_no_territories as
begin
	select r.RegionDescription
	from Region as r 
	left join Territories as t on t.RegionID = r.RegionID
	where t.RegionID is null;
end

exec RegionDescription_no_territories


--find all orders (Orders table) which have ShipCountry: France, Brazil, Belgium
create procedure Orders_Ship_to_any_France_Brazil_Belgium as
begin
	select *
	from Orders
	where ShipCountry in ('France', 'Brazil', 'Belgium');
end

exec Orders_Ship_to_any_France_Brazil_Belgium

--find all orders (orders table) which were ordered by customers (customers table) who are NOT from Spain, Austria and Mexico
create procedure Orders_not_ordered_by_Spain_Austria_Mexico as
begin
	select *
	from Orders as o
	join Customers as c on o.CustomerID = c.CustomerID
	where c.Address not in ('Spain', 'Austria', 'Mexico');
end

exec Orders_not_ordered_by_Spain_Austria_Mexico

-- find the productName (products table) which is:
--@foodType = 'Seafood' (categories table)
--@suppliedBy =  'Tokyo Traders' (suppliers table)
create procedure findProduct_by_foodtype_and_supplier(@foodType as nvarchar(40), @suppliedBy as nvarchar(40)) as
begin
	select p.ProductName
	from Products as p
	join Categories as c on p.CategoryID = c.CategoryID
	join Suppliers as s on p.SupplierID = s.SupplierID
	where c.CategoryName = @foodType and s.CompanyName = @suppliedBy;
end

exec findProduct_by_foodtype_and_supplier @foodType = 'Seafood', @suppliedBy = 'Tokyo Traders'


-- find the productName (products table) which is:
--@foodType = 'Condiments' (categories table)
--@suppliedBy =  'New Orleans Cajun Delights' (suppliers table)
-- has the MAX unitprice (products table)
--hint: the product is Chef Anton's Cajun Seasoning if @foodType = 'Condiments' and @suppliedBy =  'New Orleans Cajun Delights' 
create procedure Find_most_expensive_product_by_foodtype_and_supplier(@foodType as nvarchar(40), @suppliedBy as nvarchar(40)) as
begin
	select ProductName
	from Products as p
	join Categories as c on p.CategoryID = c.CategoryID
	join Suppliers as s on p.SupplierID = s.SupplierID
	where UnitPrice =(
		select MAX(p.UnitPrice)
		from Products as p
		join Categories as c on p.CategoryID = c.CategoryID
		join Suppliers as s on p.SupplierID = s.SupplierID
		where s.CompanyName = @foodType and c.CategoryName = @suppliedBy
	) and s.CompanyName = @foodType and c.CategoryName = @suppliedBy

end

exec Find_most_expensive_product_by_foodtype_and_supplier @foodType = 'New Orleans Cajun Delights', @suppliedBy = 'Condiments'
