/*************************

FOR EACH OF THE FOLLOWING QUESTIONS: 
	CREATE A VIEW WITH A PROPER NAME
	RUN THE VIEW USING SELECT

**************************/

use NORTHWND
--ex: find all information of Orders table
create view [Order_All_Information] as
SELECT *
FROM Orders;

select * from [Order_All_Information]

--ex: find orderID, customerID, employeeID of Orders table
create view Order_ID_Info as
SELECT orderID, customerID, employeeID
FROM Orders;

select * from Order_ID_Info

--ex: find ShipCity, ShipAddress of Orders table
create view View_ship_Address as
SELECT ShipCity, ShipAddress
FROM Orders;

select * from View_ship_Address

--ex: concat ShipCity and ShipAddress as 1 column (eg. Adenauerallee 900-Stuttgart)
create view View_Concatenated_ShipAddress as
SELECT ShipCity + ' ' + ShipAddress as 'Ship address'
FROM Orders;

select * from View_Concatenated_ShipAddress

--ex: find CompanyName and ContactName of Customers table
create view View_customer_name_info as
SELECT CompanyName, ContactName
FROM Customers;

select * from View_customer_name_info

--ex: find CustomerID, CompanyName as 'Customer Name' and ContactName as 'The Person' of Customers table
create view View_customer_name_ID_info as
SELECT CustomerID, CompanyName as 'Customer Name', ContactName as 'The Person'
FROM Customers;

select* from View_customer_name_ID_info

--ex: find all Freight of Orders after 15% tax applied, named as 'Freight after 15% tax'
create view View_Freight_after_tax as
SELECT Freight*0.75 as 'Freight after 15% tax'
FROM Orders;

select * from View_Freight_after_tax

--ex: find all distinct customerID of Orders table
create view View_all_customerID as
SELECT DISTINCT customerID
FROM Orders;

select * from View_all_customerID

--ex: select all information of Orders table (except Freight + 20% tax) into new table OrdersWithTax
--create view View_Orders_after_Tax as
SELECT OrderID, CustomerID, EmployeeID,
		OrderDate, RequiredDate, ShippedDate,
		ShipVia, Freight*1.2, ShipName,
		ShipAddress, ShipCity, ShipRegion,
		ShipPostalCode, ShipCountry
INTO [OrdersWithTax]
FROM Orders



--ex: find all Orders which have Freight greater than 60
create view View_Order_have_freight_more60 as
SELECT *
FROM Orders
WHERE Freight > 60;

select * from View_Order_have_freight_more60

--ex: find all Orders which have Freight less than 10
create view View_Order_have_freight_less10 as
SELECT *
FROM Orders
WHERE Freight < 10;

select * from View_Order_have_freight_less10

--ex: find all Orders which have Freight between 40 and 50
create view View_Order_have_freight_between_40_50 as
SELECT *
FROM Orders
WHERE Freight BETWEEN 40 AND 50;

select * from View_Order_have_freight_between_40_50

--ex: find all customers from Germany
create view View_Germany_customer as
SELECT *
FROM Customers
WHERE Country = 'Germany';

select * from View_Germany_customer

--ex: find all customers whose contactName is %Paul%
create view View_customers_name_having_Paul as
SELECT *
FROM Customers
WHERE ContactName like '%Paul%';

select * from View_customers_name_having_Paul

--ex: find all Mexico customers whose ContactTitle is Owner
create view View_Mexico_Owners_is_customer as
SELECT *
FROM Customers
WHERE Country = 'Mexico' and ContactTitle = 'Owner';

select * from View_Mexico_Owners_is_customer

--ex: find all Orders such that OrderDate in 1997 and employeeID = 4
create view View_Orders_ID_4_in_1997 as
SELECT *
FROM Orders
WHERE OrderDate BETWEEN '1997-1-1' AND '1997-12-31' AND EmployeeID = 4;

select * from View_Orders_ID_4_in_1997

--ex: find all Orders such that ShippedDate in November-1997 and Freight between 10 and 30
create view View_Orders_Freight_between_10_30_in_November_1997 as
SELECT *
FROM Orders
WHERE ShippedDate BETWEEN '1997-11-1' AND '1997-11-30' 
					AND Freight BETWEEN 10 AND 30;

select * from View_Orders_Freight_between_10_30_in_November_1997

--ex: find maximum freight in Orders in which EmployeeId = 3
create view View_Max_freight_of_Employee_ID_3 as
SELECT MAX(Freight) as 'Maximum freight'
FROM Orders
WHERE EmployeeID = 3;

select * from View_Max_freight_of_Employee_ID_3

--ex: find how many Orders placed by customerID 'EASTC'
create view View_amount_of_Orders_by_customer_id_EASTC as
SELECT COUNT(CustomerID) as 'EASTC amount'
FROM Orders
WHERE customerID = 'EASTC'

select * from View_amount_of_Orders_by_customer_id_EASTC

--ex: find how many Orders placed by customerID 'EASTC' and orderDate in 1998
create view View_Orders_in_1998_of_customer_id_EASTC as
SELECT COUNT(CustomerID) as 'CustomerID EASTC and OrderDate 1998 amount'
FROM Orders
WHERE customerID = 'EASTC' 
		AND OrderDate BETWEEN '1998-1-1' AND '1998-12-31';

select * from View_Orders_in_1998_of_customer_id_EASTC