USE NORTHWND
--create table shippers_audit
--then create trg_shippers_audit after insert/delete/update of Shippers table
create table shippers_audit(
	[Change_id] int identity primary key,
	[ShipperID] int not null,
	[CompanyName] nvarchar(40) not null,
	[Phone] nvarchar(24),
	[update_at] datetime not null,
	[operation] char(3) not null,
	check([operation] = 'INS' or [operation] = 'DEL')
)

--drop table shippers_audit
CREATE TRIGGER	trg_shippers_audit
on Shippers
after insert, delete, update
as
begin
	set nocount on;
	--SET IDENTITY_INSERT shippers_audit ON;
	insert into shippers_audit(
		[ShipperID], 
		[CompanyName], 
		[Phone], 
		[update_at], 
		[operation]
	)
	select
		d.[ShipperID],
		d.[CompanyName],
		d.[Phone],
		GETDATE(),
		'DEL'
	from 
		deleted d
	union all
	select
		i.ShipperID,
		i.[CompanyName],
		i.[Phone],
		GETDATE(),
		'INS'
	from 
		inserted i;
end;

drop trigger trg_shippers_audit

insert into Shippers(CompanyName)
values ('LapNguyen')

update Shippers
set CompanyName = 'DorePita'
where CompanyName = 'LapNguyen'

delete from Shippers
where CompanyName = 'LapNguyen'

select*from Shippers
select* from shippers_audit
--create table suppliers_audit
--then create trg_suppliers_audit after insert/delete/update of Suppliers table
ALTER TABLE suppliers
ALTER COLUMN HomePage NVARCHAR(MAX);

create table suppliers_audit(
	[Change_id] int identity primary key,
	[SupplierID] int not null, 
	[CompanyName] nvarchar(40) not null,
	[ContactName] nvarchar(30),
	[ContactTitle] nvarchar(30),
	[Address] nvarchar(60),
	[City] nvarchar(15),
	[Region] nvarchar(15),
	[PostalCode] nvarchar(10),
	[Country] nvarchar(15),
	[Phone] nvarchar(24),
	[Fax] nvarchar(24),
	[HomePage] nvarchar(max),
	[Update_at] datetime not null,
	[operation] char(3) not null,
	check ([operation] = 'DEL' or [operation] = 'INS')
)
drop table suppliers_audit

create trigger trg_suppliers_audit 
on Suppliers
after insert, delete, update 
as
begin
	set nocount on;
	insert into suppliers_audit(
		[SupplierID], 
		[CompanyName],
		[ContactName],
		[ContactTitle],
		[Address],
		[City],
		[Region],
		[PostalCode],
		[Country],
		[Phone],
		[Fax],
		[HomePage],
		[Update_at],
		[operation]
	)
	select
		d.[SupplierID], 
		d.[CompanyName],
		d.[ContactName],
		d.[ContactTitle],
		d.[Address],
		d.[City],
		d.[Region],
		d.[PostalCode],
		d.[Country],
		d.[Phone],
		d.[Fax],
		d.[HomePage],
		GETDATE(),
		'DEL'
	from deleted d
	union all
	select
		i.[SupplierID], 
		i.[CompanyName],
		i.[ContactName],
		i.[ContactTitle],
		i.[Address],
		i.[City],
		i.[Region],
		i.[PostalCode],
		i.[Country],
		i.[Phone],
		i.[Fax],
		i.[HomePage],
		GETDATE(),
		'INS'
	from inserted i
end

insert into Suppliers (CompanyName)
values ('LapNguyen');

insert into Suppliers(CompanyName)
values ('Doremon');

update Suppliers
set CompanyName = 'DorePita'
where CompanyName in ('LapNguyen', 'Doremon');

delete from Suppliers
where CompanyName = 'DorePita'

select * from Suppliers
select * from suppliers_audit

--create table customers_audit
--then create trg_customers_audit after insert/delete/update of Customers table
create table customers_audit(
	Change_id int identity primary key,
	CustomerID	nchar(5) not null,
	CompanyName	nvarchar(40),
	ContactName	nvarchar(30),
	ContactTitle	nvarchar(30),
	Address	nvarchar(60),
	City	nvarchar(15),
	Region	nvarchar(15),
	PostalCode	nvarchar(10),
	Country	nvarchar(15),
	Phone	nvarchar(24),
	Fax	nvarchar(24),
	Change_at datetime,
	operation char(3),
	check(operation = 'DEL' or operation = 'INS')
)
drop trigger trg_customers_audit 
create trigger trg_customers_audit 
on Customers
after insert,delete,update
as
begin
	set nocount on
	insert into customers_audit(
		CustomerID,
		CompanyName,
		ContactName,
		ContactTitle,
		[Address],
		City,
		Region,
		PostalCode,
		Country,
		Phone,
		Fax,
		Change_at,
		operation
	)
	select
		d.CustomerID,
		d.CompanyName,
		d.ContactName,
		d.ContactTitle,
		d.[Address],
		d.City,
		d.Region,
		d.PostalCode,
		d.Country,
		d.Phone,
		d.Fax,
		GETDATE(),
		'DEL'
	from deleted d
	union all
	select
		i.CustomerID,
		i.CompanyName,
		i.ContactName,
		i.ContactTitle,
		i.[Address],
		i.City,
		i.Region,
		i.PostalCode,
		i.Country,
		i.Phone,
		i.Fax,
		GETDATE(),
		'INS'
	from inserted i;
end

insert into Customers(CustomerID, CompanyName)
values (12, 'LapNguyen')

update Customers
set CompanyName = 'DorePita'
where CompanyName = 'LapNguyen'

delete from Customers
where CompanyName = 'DorePita'

select * from Customers
select * from customers_audit



--create function findMin(@x, @y, @z) to return the minimum of @x, @y and @z
create function findMin(@x int, @y int, @z int)
returns int as
begin
	DECLARE @min int = @x
	if(@min > @y)
		set @min = @y
	if(@min > @z)
		set @min = @z
	return @min
end;

print dbo.findMin(12, -1, 3);

--create function computeCircumference(@radius) to return circumference of a circle
create function computeCircumference(@radius as float)
returns float as
begin
	return @radius*2*PI()
end

print dbo.computeCircumference(0.5)


--create function computeArea(@length, @width) to return area of a rectangle
create function computeArea(@length float, @width float)
returns float as
begin
	return @length*@width*0.5
end

print dbo.computeArea(12, 20)

--create function splitDigits(@number as int) to return a table in which each row is a digit of @number
create function splitDigits(@number as int)
returns @digits table(idx INT IDENTITY PRIMARY KEY, val int) as
begin	
	set @number = REVERSE(@number);
	declare @digit int;
	while(@number != 0)
		begin
			insert into @digits
			values (@number % 10)
			set @number = @number/10
		end
return
end
select * from dbo.splitDigits(123456789)

--create function splitVowel(@str as varchar(max)) to return a table in which each row is a vowel of @str.

create function splitVowel(@str as varchar(max))
returns @vowels table(vowel char(1)) as
begin
	set @str = LTRIM(@str)
	set @str = RTRIM(@str)
	DECLARE @startPoint int = 1;
	DECLARE @endPoint int = @startPoint + 1;
	declare @len int = LEN(@str);
	declare @char char(1);
	while(@startPoint <= @len)
		begin
			set @char = SUBSTRING(@str, @startPoint, @endPoint)
			if(@char in ('u','e','o','a','i'))
				begin
					insert into @vowels
					values (@char)
				end
			set @startPoint = @startPoint + 1
			set @endPoint = @startPoint + 1
		end
return
end

select * from dbo.splitVowel('oi doi oi hoi bi ghe luon nha')

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'customers_audit';