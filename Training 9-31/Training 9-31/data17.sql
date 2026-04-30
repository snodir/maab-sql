
create database data17
use data17
go
--user stored procedure--
create proc usp_GiveMeCurrentDate
as
begin
 select getdate() as CurrentDate
end

execute usp_GiveMeCurrentDate
 
alter proc usp_GiveMeCurrentDate
as
begin
 select getdate() as CurrentDate, datediff(day, '2021.12.27', getdate()) as differencebetween2dates
end 

declare @birthdate as date
set @birthdate='2002-12-05'
select datediff(month, @birthdate, getdate()) as myAge
go
create proc usp_CalculateAge 
@your_birthdate as date
as 
begin
select datediff(year, @your_birthdate, getdate()) as Age
end

alter proc usp_CalculateAge
@your_birthdate as date
as 
begin
select datediff(year, @your_birthdate, getdate()) as Age
end
execute usp_CalculateAge '2002-12-05'

select t.name, c.name from sys.tables as t join sys.columns as c on t.object_id=c.object_id

if exists(select name from sys.tables where name='shopping')
begin
drop table shopping
end
create table shopping(step int, description nvarchar(80))

alter procedure usp_shopping
as
begin
	set nocount on
	if object_id('dbo.shopping') is not null
	begin
	drop table shopping
	end
	create table shopping(step int, description nvarchar(80));
	
	if not exists(select step from shopping where step=1)
	begin
		insert into shopping values(1, 'Get up early')
	end
	if exists (select step from shopping where step=1) and not exists(select step from shopping where step=2)
	begin
		insert into shopping values(2, 'Grab your wallet')
	end
	if exists (select step from shopping where step=2) and not exists(select step from shopping where step=3)
	begin
		insert into shopping values(3, 'Drive to store')
	end
	if exists (select step from shopping where step=3) and not exists(select step from shopping where step=4)
	begin
		insert into shopping values(4, 'Collect the produce')
	end
	if exists (select step from shopping where step=4) and not exists(select step from shopping where step=5)
	begin
		insert into shopping values(5, 'Check out the produce')
	end
	--if exists (select step from shopping where step=5) and not exists(select step from shopping where step=6)
	--begin
	--	insert into shopping values(6, 'Get back home')
	--end
	if (select count(step) from shopping)=6
	begin
		print 'Congratulation, your shopping is complete'
	end
	else
	begin
		print 'You missed some steps and you are not done with some shopping'
	end
end

execute usp_shopping

create proc usp_IsEven
@number int
as
select case when @number%2=0 then 'even' else 'not even' end

exec usp_IsEven 21

create table t1(numbers int)
insert into t1 values(1),(2),(3),(5),(6),(8),(11),(12)
select t1.numbers from t1

numbers group range
1			1-3
2			1-3
3			1-3
5			5-6
6			5-6
8			8-8
11			11-12
12			11-12


 select initial.numbers, helper_father.group_range
 from 
	(select numbers, t1.numbers-row_number() over(order by numbers) as diff from t1) as initial 
	inner join 
	(select helper.diff, concat(min(helper.numbers),'-', max(helper.numbers)) as group_range
	from
		(select numbers, t1.numbers-row_number() over(order by numbers) as diff
		from t1) as helper
	group by helper.diff) as helper_father
	on helper_father.diff=initial.diff


-----common table expressions(CTE)----
;with helper as (select numbers, t1.numbers-row_number() over(order by numbers) as diff from t1) 
select A.numbers,
	concat((select min(B.numbers) from helper as B where B.diff=A.diff),'-',
	(select max(B.numbers)from helper as B where B.diff=A.diff)) as grouprange 
	from  helper as A

;with helper as (select numbers, t1.numbers-row_number() over(order by numbers) as diff from t1) 
select helper.numbers,
	concat( min(helper.numbers) over (partition by helper.diff),'-',
	max(helper.numbers) over (partition by helper.diff)) as grouprange 
	from  helper 

;with helper as (select numbers, t1.numbers-row_number() over(order by numbers) as diff from t1) 
select helper.numbers,
	cast(min(helper.numbers) over (partition by helper.diff) as nvarchar(10))+'-'+
	cast(max(helper.numbers) over (partition by helper.diff) as nvarchar(10))as grouprange 
from  helper 









