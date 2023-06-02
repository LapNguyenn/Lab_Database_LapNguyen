/*Run SQL all script below and do requirements:
1.	Write function name: StudenID_ Func1 with parameter @mavt, return the sum
of sl*giaban corresponding.
2.	Write  function to return a total of the HoaDon (@MahD is a parameter) 
3.	Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure
help user update @diachi corresponding @makh.
4.	Write procedure to add an item into Hoadon
5.	Write trigger name: StudenId_ Trig1 on table Chitiethoadon, when user insert data into Chitiethoadon, the trigger will update the Tongtien in HoaDon(student should add Tongtien column into Hoadon, tongtien=sum(sl*giaban).
6.	Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong’
*/
use ABCCompany
//Script
CREATE DATABASE ABCCompany 
CREATE TABLE KHACHHANG
	(
	MaKH nvarchar(5) NOT NULL PRIMARY KEY,
	TenKH nvarchar(30) NOT NULL,
	DiaChi nvarchar(50),
	DT nvarchar(10) ,
	Email nvarchar(30)
	)
CREATE TABLE VATTU
	(
	MaVT nvarchar(5) PRIMARY KEY NOT NULL,
	TenVT nvarchar(30) NOT NULL,
	DVT nvarchar(20),
	GiaMua int CHECK (GiaMua>0),
	SLTon int CHECK (SLTon>=0)
	)
CREATE TABLE HOADON
	(
	MaHD nvarchar(10) PRIMARY KEY NOT NULL,
	Ngay datetime CHECK(Ngay<getdate()),
	MaKH nvarchar(5) FOREIGN KEY REFERENCES KHACHHANG(MaKH),
	TongTG int
	)
CREATE TABLE CHITIETHOADON
	(
	MaHD nvarchar(10) FOREIGN KEY REFERENCES HOADON(MaHD),
	MaVT nvarchar(5) FOREIGN KEY REFERENCES VATTU(MaVT),
	PRIMARY KEY (MaHD,MaVT),
	SL int,
	KhuyenMai int,
	GiaBan int
	)
INSERT VATTU
VALUES( 'VT01','XI MANG','BAO',50000,5000)
INSERT VATTU
VALUES( 'VT02',	'CAT'	,'KHOI',	45000,	50000)
INSERT VATTU
VALUES( 'VT03',	'GACH ONG',	'VIEN',	120,	800000)
INSERT VATTU
VALUES( 'VT04',	'GACH THE',	'VIEN',	110,	800000)
INSERT VATTU
VALUES( 'VT05',	'DA LON',	'KHOI',	25000,	100000)
INSERT VATTU
VALUES( 'VT06',	'DA NHO',	'KHOI',	33000,	100000)

INSERT KHACHHANG
VALUES( 'KH01',	'NGUYEN THI BE',	'TAN BINH',	8457895,	'bnt@yahoo.com')
INSERT KHACHHANG
VALUES( 'KH02',	'LE HOANG NAM',	'BINH CHANH',	9878987,	'namlehoang @abc.com.vn')
INSERT KHACHHANG
VALUES( 'KH03',	'TRAN THI CHIEU',	'TAN BINH',	8457895,null	)
INSERT KHACHHANG
VALUES( 'KH04',	'MAI THI QUE ANH',	'BINH CHANH	',null,null)
INSERT KHACHHANG
VALUES( 'KH05',	'LE VAN SANG',	'QUAN 10',	null	,'sanglv@hcm.vnn.vn')
INSERT KHACHHANG
VALUES( 'KH06',	'TRAN HOANG KHAI',	'TAN BINH',	8457897	,null)

INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD001','2000-05-12',	'KH01')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD002','2000-05-25',	'KH02')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD003','2000-05-25','KH01')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD004','2000-05-25','KH04')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD005','2000-05-26','KH04')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD006','2000-05-02','KH03')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD007','2000-06-22','KH04')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD008','2000-06-25','KH03')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD009','2000-08-15','KH04')
INSERT HOADON([MaHD],[Ngay],[MaKH])
VALUES( 'HD010','2000-08-30','KH01')

INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES('HD001','VT01',5,52000)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD001','VT05',	10,	30000)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD002','VT03',	10000,	150)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD003','VT02',	20,	55000)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD004','VT03',	50000,	150)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD004',	'VT04',	20000,	120)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD005',	'VT05',	10,	30000)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD006',	'VT04',	10000,	120)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD007',	'VT04',	20000,	125)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD008',	'VT01',	100,	55000)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD009',	'VT02',	25,	48000)
INSERT CHITIETHOADON([MaHD],[MaVT],[SL],[GiaBan])
VALUES( 'HD010',	'VT01',	25,	57000)
--Write function name: StudenID_ Func1 with parameter @mavt, return the sum
-- of sl*giaban corresponding.
create function StudenID_Func1 (@mavt nvarchar(5))
returns @searchMavt table([Doanh thu tren san pham] int) as
begin
	insert into @searchMavt ([Doanh thu tren san pham])
		select SUM(SL * GiaBan)
		from CHITIETHOADON
		where MaVT = @mavt
		group by MaVT
return
end

select * from dbo.StudenID_Func1('VT01')


--Write  function to return a total of the HoaDon (@MakH is a parameter) 
create function totalOfHoaDon(@MakH nvarchar(10))
returns @totalHD table([Tong hoa don] int) as
begin
	--declare @Mahd nvarchar(10) = ''
	insert into @totalHD([Tong hoa don])
		select COUNT(MaKH)
		from HOADON
		where MaKH = @MakH
return
end

select * from dbo.totalOfHoaDon('KH01')

--Write procedure name: StudenId _Proc1, parameter @makh, @diachi. This procedure
-- help user update @diachi corresponding @makh.
create procedure StudenId_Proc1 (@makh as nvarchar(5), @diachi nvarchar(50)) as
begin
	update KHACHHANG
	set DiaChi = @diachi
	where MaKH = @makh
end

exec StudenId_Proc1 @makh = 'KH01', @diachi = 'Phu Xuyen'
exec StudenId_Proc1 @makh = 'KH01', @diachi = 'TAN BINH'


--Write procedure to add an item into Hoadon
create procedure addItem(@MaHD nvarchar(10), @Ngay datetime, @MaKH nvarchar(5))
as
begin

	INSERT INTO HOADON([MaHD],[Ngay],[MaKH])
	VALUES (@MaHD, @Ngay, @MaKH)
end

exec addItem @MaHD = 'HD09',@Ngay = '1/1/1990', @MaKH = 'KH05'

--Write trigger name: StudenId_ Trig1 on table Chitiethoadon, when user insert data into Chitiethoadon, the trigger will
create table Chitiethoadon_audit(
	ChangeID	int identity primary key,
	MaHD		nvarchar(10) not null,
	MaVT		nvarchar(5) not null,
	SL			int,
	KhuyenMai	int,
	GiaBan		int,
	Time_change	datetime,
	operation   char(3),
	check(operation = 'DEL' or operation = 'INS')
)

create trigger StudenId_Trig1
on CHITIETHOADON
after delete, insert
as
begin
	set nocount on
	insert into Chitiethoadon_audit (MaHD,MaVT,SL,KhuyenMai,GiaBan,Time_change,operation)
	select 
		d.MaHD,
		d.MaVT,
		d.SL,
		d.KhuyenMai,
		d.GiaBan,
		GETDATE(),
		'DEL'
	from deleted d
	union all
	select 
		i.MaHD,
		i.MaVT,
		i.SL,
		i.KhuyenMai,
		i.GiaBan,
		GETDATE(),
		'INS'	
	from inserted i
end

INSERT INTO CHITIETHOADON(MaHD, MaVT)
values('HD010', 'VT02')

delete from CHITIETHOADON
where MaHD = 'HD010' and MaVT = 'VT02'

select*from CHITIETHOADON
select*from Chitiethoadon_audit

--Write view name: StudentID_View1 to extract list of customers who bought ‘Gach Ong’

select * from KHACHHANG
select * from HOADON
select * from CHITIETHOADON
select * from VATTU

create view StudentID_View1 as
select k.MaKH, k.TenKH, k.DiaChi, k.DT, k.Email
from KHACHHANG as k
join HOADON as h on k.MaKH = h.MaKH
where h.MaHD = ANY (
	select c.MaHD
	from CHITIETHOADON as c
	join VATTU as v on v.MaVT = c.MaVT
	where v.TenVT = 'GACH ONG'
)

select * from StudentID_View1

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'CHITIETHOADON';