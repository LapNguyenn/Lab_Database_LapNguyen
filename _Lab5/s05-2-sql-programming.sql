--credit: http://www.sqlservertutorial.net
use NORTHWND;


select CompanyName, Address
from Suppliers
where Address like '%ed%';

--text parameter
create procedure Supplier_By_Address (@addr as varchar(255)) as
begin
	select CompanyName, Address
	from Suppliers
	where Address like '%' + @addr + '%';

end;

exec Supplier_By_Address @addr='ed';
exec Supplier_By_Address @addr='Rd';
exec Supplier_By_Address @addr='St';


--default values
create procedure Products_By_Price_Name (
	@low as money = 0,
	@high as money = 9999,
	@name as varchar(255) = ''
) as
begin
	select ProductID, ProductName, UnitPrice
	from Products
	where UnitPrice between @low and @high
	and ProductName like '%' + @name + '%'
end;

exec Products_By_Price_Name @low = 90;
exec Products_By_Price_Name @low = 90, @high = 125;
exec Products_By_Price_Name @low = 90, @high = 125, @name = 'niku';


/***********************
~~~~ VARIABLES ~~~~
***********************/

--create variables
declare @age as smallint;
declare @price as money, @text as varchar(255);

--assign values
set @age = 15;
set @price = 12.7;
set @text = 'Aptech';

--variable in query
select ProductName, UnitPrice 
from Products 
where UnitPrice < @price;

--//must run everything in one shot

--store query result in a variable
declare @productCount int;
set @productCount = (select count(ProductID) from Products);
print 'The number of products is: '
print @productCount;


--select a record into variables
declare @_name varchar(255), @_price money;
select 
	@_name = p.ProductName,
	@_price = p.UnitPrice
from Products p
where ProductID = 17;
print @_name;
print @_price;


--accumulating values into a variable
declare @productList varchar(max);
set @productList = '';

select 
	@productList += p.ProductName + ': ' + p.QuantityPerUnit + char(10)
from Products p
order by ProductName asc;

print @productList;


/***********************
~~~~ IF ELSE ~~~~
***********************/

create procedure Compare_Products (@firstID int, @secondID int) as
begin
	declare @firstPrice money, @secondPrice money;
	
	select
		@firstPrice = UnitPrice
	from Products where ProductID = @firstID;

	select
		@secondPrice = UnitPrice
	from Products where ProductID = @secondID;

	if @firstPrice > @secondPrice
		begin
			print 'First is more expensive than Second';
		end
	else
		begin
			print 'Second is more expensive than First';
		end
end;

exec Compare_Products 15, 17;
exec Compare_Products 9, 70;

--nested if
DECLARE @x INT = 10,
        @y INT = 20;
 
IF (@x > 0)
BEGIN
    IF (@x < @y)
        PRINT 'x > 0 and x < y';
    ELSE
        PRINT 'x > 0 and x >= y';
END 


/***********************
~~~~ WHILE ~~~~
***********************/

DECLARE @counter INT = 1;
 
WHILE @counter <= 5
BEGIN
    PRINT @counter;
    SET @counter = @counter + 1;
END

--BREAK
DECLARE @counter INT = 0;
 
WHILE @counter <= 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 4
        BREAK;
    PRINT @counter;
END


--CONTINUE
DECLARE @counter INT = 0;
 
WHILE @counter < 5
BEGIN
    SET @counter = @counter + 1;
    IF @counter = 3
        CONTINUE; 
    PRINT @counter;
END