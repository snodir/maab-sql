create database data25
use data25

--user defined functions 3
declare @n1 int, @n2 int
set @n1=3
set @n2=2
select @n1+@n2 as result

create function  udf_addition(@n1 int, @n2 int)   -----Scalar functions
returns int
as 
begin
	return @n1+@n2
end

select dbo.udf_addition(49659865,9865498)

go

alter function udf_division(@n1 int, @n2 int)
returns float
as
begin
	return cast(@n1 as float)/@n2 
end
go
select dbo.udf_division(1,3)
go
create table numbers(num1 int, num2 int)
insert into numbers values(1,2),(3,5),(6,8)
select *, 
		dbo.udf_addition(num1, num2) as addition, 
		dbo.udf_division(num1, num2) as division 
from numbers
go
create function udf_inlinesample(@name1 nvarchar(30), @name2 nvarchar(30), @name3 nvarchar(30))
returns table
as 
return (select @name1 as name
			   union all
			   select @name2
			   union all
			   select @name3
	   )
go
select name from udf_inlinesample('John', 'Steve', 'Rich')  ------Inline Table Valued Functions
go
create function udf_get_emp_by_year(@year int)
returns table
as
return(
	SELECT TOP (1000) [orderid]
					 ,[custid]
					 ,[empid]
					 ,[orderdate]
					 ,[requireddate]
					 ,[shippeddate]
				     ,[shipperid]
					 ,[freight]
				     ,[shipname]
				     ,[shipaddress]
				     ,[shipcity]
				     ,[shipregion]
					 ,[shippostalcode]
					 ,[shipcountry]
  FROM [TSQL2012].[Sales].[Orders]
  where year(requireddate)=@year and year(orderdate)=@year
	)
go
	select * from udf_get_emp_by_year(2007)

--Multi statement table valued functios
create function udf_multi_st_function(@year int, @country nvarchar(30))
returns table 

select 'Nodir' as name,
		reverse('Nodir') as rev_name

create function udf_reversed_name(@orig_name nvarchar(25))
returns nvarchar(25) 
as
begin
declare @reversedname nvarchar(25)=''
;with a as
(
	select 1 as n, left(@orig_name, 1)  as letters
	union all
	select a.n+1, SUBSTRING(@orig_name, a.n+1, 1 ) 
	from a where a.n <len(@orig_name) 
)
select @reversedname=@reversedname+letters from a order by n desc
return @reversedname
end
select dbo.udf_reversed_name('Nodir')







