/***********************
~~~~ IF ELSE ~~~~
***********************/
use NORTHWND
--ex: write sql to check whether a given year is a leap year or not
create procedure check_leap_year(@year as int) as 
begin
	if @year % 4 = 0 and @year % 100 != 0
		print('leap year');
	else
		print('not a leap year');
end

exec check_leap_year @year = 2016
exec check_leap_year @year = 2018

--@year=2016, print 'leap year'
--@year=2018, print 'not a leap year'


--ex: write sql to find the largest of 3 numbers
--@x=1, @y=2, @z=3, print 3
create procedure highest_number_in_3_number(@x as int, @y as int, @z as int) as 
begin
	declare @max int = @x;
	if(@max < @y)
		set @max = @y;
	if(@max < @z)
		set @max = @z;
	print(@max)
end

exec highest_number_in_3_number @x=1, @y=2, @z=3;

--Write sql display a suitable message according to temperature state below
--@Temp < 0 then Freezing weather
--@Temp 0-10 then Very Cold weather
--@Temp 10-20 then Cold weather
--@Temp 20-30 then Normal in Temp
--@Temp 30-40 then Its Hot
--@Temp >=40 then Its Very Hot
create procedure Temp_warning(@Temp as int) as
begin
	if (@Temp < 0)
		print('Freezing weather');
	else if (@temp <10)
		print('Very Cold weather');
	else if (@temp < 20)
		print('Cold weather');
	else if (@temp < 30)
		print('Normal in Temp');
	else if (@Temp < 40)
		print('Its Hot');
	else
		print('Its Very Hot');
end

exec Temp_warning @temp = 0;
exec Temp_warning @temp = 10;
exec Temp_warning @temp = 20;
exec Temp_warning @temp = 30;
exec Temp_warning @temp = 40;



--write sql to check if 3 numbers can form a triangle
--@a, @b, @c
--(a+b > c) and (b+c >a) and (c+a > b), print 'a triangle'
--else print 'not a triangle'
create procedure checkTriangle(@a as int, @b as int, @c as int) as
begin
	if( @a+@b > @c and @b+@c > @a   and @c + @a > @b)
		print('a triangle');
	else
		print('not a triangle');
end

exec checkTriangle @a = 3, @b = 4, @c = 10 
exec checkTriangle @a = 3, @b = 4, @c = 5 

--write sql to check if 3 numbers can form a right triangle
--(a*a + b*b = c*c) or (a*a + c*c = b*b) or (b*b + c*c = a*a), print 'a right triangle'
--else print 'not a right triangle'
create procedure checkRightTriangle(@a as int, @b as int, @c as int) as
begin
	declare @check int;
	if( @a+@b > @c and @b+@c > @a   and @c + @a > @b)
		set @check = 1;
	else
		begin
			set @check = 0;
			print('not a triangle');
		end
	if(@check = 1)
		begin
			if((@a*@a + @b*@b = @c*@c) or (@a*@a + @c*@c = @b*@b) or (@b*@b + @c*@c = @a*@a))
				print('a right triangle');
			else
				print('not a right triangle');
		end
end

exec checkRightTriangle @a = 3, @b = 4, @c = 10 
exec checkRightTriangle @a = 3, @b = 4, @c = 6
exec checkRightTriangle @a = 3, @b = 4, @c = 5

/***********************
~~~~ WHILE ~~~~
***********************/
--write sql to find the sum from 1 to @n: 1+2+3+4+...+@n 
--@n=9, print 45
create procedure sum1toN(@n as int) as
begin
	declare @sum int = 0;
	declare @i int = 1;
	while(@i < @n)
		begin
			set @sum = @sum + @i;
			set @i = @i + 1;
		end
	print(@sum)
end

exec sum1toN @n = 9
exec sum1toN @n = 45

--write sql to print a table from 1 to @n=100 as follow
--1		2	3	4	5	6	7	8	9	10
--11	12	13	14	15	16	17	18	19	20
--21	22	23	24	25	26	27	28	29	30
--31	32	33	34	35	36	37	38	39	40
--41	42	43	44	45	46	47	48	49	50
--51	52	53	54	55	56	57	58	59	60
--61	62	63	64	65	66	67	68	69	70
--71	72	73	74	75	76	77	78	79	80
--81	82	83	84	85	86	87	88	89	90
--91	92	93	94	95	96	97	98	99	100

create procedure Display_1_to_n(@n as int)as
begin
	declare @sequence nvarchar(40) = '';
	declare @i int = 1;
	while(@i <= @n)
	begin
		set @sequence = @sequence + CONVERT(nvarchar, @i)
		if(@i < 10)
			set @sequence = @sequence + '  ';
		else if(@i % 10 != 0)
			set @sequence = @sequence + ' ';
		else
		begin
			print @sequence;
			set @sequence = '';
		end
		
		if(@i = @n and @n % 10 != 0)
		begin
			print @sequence;		
		end
		set @i =  @i + 1;
	end
end

drop procedure Display_1_to_n
exec Display_1_to_n @n = 100;
exec Display_1_to_n @n = 18;
exec Display_1_to_n @n = 90;
exec Display_1_to_n @n = 51;

--write sql to find the sum of all digits of a numbers
--@x=123, print 6
create procedure sumDigits(@x as int) as
begin
	declare @remain int = 0;
	declare @sum int = 0;
	while(@x != 0)
		begin
			set @remain = @x % 10;
			set @sum = @sum + @remain;
			set @x = @x / 10;
		end
	print(@sum)
end

exec sumDigits @x = 123;
exec sumDigits @x = 234;

--write sql to calculate a^b (only use while loop)
--@a=3, @b=2, print 9
create procedure pow(@a as int, @b as int) as
begin
	declare @i int = 0;
	declare @pow int = @a;
	while(@i < @b-1)
		begin
			set @pow = @pow * @a;
			set @i = @i +1;
		end
	print(@pow);
end

exec pow @a = 3, @b = 2
exec pow @a = 3, @b = 3
exec pow @a = 2, @b = 3

--write sql to find all factors of a numbers
--@n=12, print 1, 2, 3, 4, 6, 12
create procedure factor(@n as int) as
begin
	declare @i int = 1;
	declare @result nvarchar(1000) = '';
	while(@i <= @n)
		begin
			if(@n % @i = 0)
				begin
					if(@i = @n)
						set @result = @result + convert(varchar, @i)
					else
						set @result = @result + (convert(varchar, @i) + ', ')
				end
			set @i = @i +1;
		end
	print @result;
end

exec factor @n = 12;
exec factor @n = 13;
exec factor @n = 21;
