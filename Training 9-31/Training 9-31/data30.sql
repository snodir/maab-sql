create database data30
use data30

create table t1(name nvarchar(30), number int)
insert into t1 values('a', 1),('a', 2),('a', 3),('a', 4),
					 ('b', 5),('b', 6),('b', 7),('b', 8)

select name, number from t1

select name, number, 
		min(number) over(partition by name) as min_num_per_name1,
		max(number) over(partition by name) as max_num_per_name2,
		min(number) over(partition by name order by number) as min_num_per_name3,
		max(number) over(partition by name order by number) as max_num_per_name4,
		max(number) over(partition by name order by number rows between unbounded preceding and unbounded following) as max_num_per_name5,
		max(number) over(partition by name order by number rows between 1 preceding and 1 following) as max_num_per_name6,
		sum(number) over(partition by name) as sum_per_name,
	   (select sum(B.number) from t1 as B where A.name=B.name and B.number<=A.number) as runningtotal1,
	   (select sum(B.number) from t1 as B inner join t1 as A on A.name=B.name and B.number<=A.number) as runningtotal2,
	    sum(number) over(partition by name order by number rows between unbounded preceding and current row) as runningtotal3,
	    sum(number) over(partition by name order by number rows between current row and unbounded following) as runningtotal4
from t1 as A

select A.*, sum(B.number) from t1 as B inner join t1 as A on A.name=B.name and A.number>=B.number group  by A.name, A.number

select name, number,
		number-lag(number,1,0)  over(partition by name order by number) as diff_year_by_year,
		lag(number,1,null) over(partition by name order by number) as prevnum,
		lead(number,1,null) over(partition by name order by number) as nextnum,
		first_value(number) over(partition by name order by number rows between unbounded preceding and current row) as firstvalue,
		last_value(number) over(partition by name order by number rows between current row and unbounded following) as lastvalue
from t1

exec('select name, number from t1')

declare @sql nvarchar(100)=''
set @sql=@sql+'select name, '
set @sql=@sql+'number from t1'
exec  @sql
go

--character at any index
alter proc dbo.usp_char_at_any_index  
@inp nvarchar(100), @index int
--declare
as
begin
	;with a as
	(
		select 1 as n, left(@inp, 1) as characters
		union all
		select a.n+1, substring(@inp, a.n+1, 1) 
		from a
		where a.n<len(@inp)
	)
	select n, characters from a where n=@index
end
go

exec usp_char_at_any_index 
@inp='hjfglkj c', 
@index=10

--A1, A2, A3...
declare @alifbe nvarchar(50)='ABCDEFGHIJKL'
; with a as
(
	select 1 AS n, left(@alifbe,1) as letters
	union all
	select a.n+1, substring(@alifbe,a.n+1, 1) from a where a.n<len(@alifbe)
)
select x.letters, 
	   x.n, 
	   string_agg(x.letters+cast(y.n as nvarchar(5)), ', ') as seats 
from a x cross join (select n from a where n<=10) y
group by x.letters, x.n
order by x.letters

--identity--
create table num(id int)
create proc dbo.usp_id_column
@fromto int
as
begin
	if OBJECT_ID('data30.dbo.num', 'U') is not null
	drop table num
	create table num(id int)
	declare @initial int=0
	insert into num(id) values(@fromto)




--company
declare @inp nvarchar(50)='company'
;with a as
(
	select 1 as n, left(reverse(@inp),1) as letters
	union all
	select a.n+1, substring(reverse(@inp), a.n+1, 1)
	from a
	where a.n<len(reverse(@inp))
)
select x.n,
	   reverse(string_agg(y.letters, ''))
	   --(select case when row_number() over(order by (select null))=1 then '' else ', '+z.letters from a as z where z.n=x.n for xml path('') )
from a as x 
inner join a as y on y.n<=x.n
group by x.n
order by x.n desc

--Weekdays--
;with a as
(
select 0 as n, datename(dw, getdate()) as weekdays
union all
select a.n+1, datename(dw, dateadd(day, a.n+1, getdate()))
from a
where a.n<6
)
select n 
	  ,weekdays
from a
order by case weekdays when 'Monday' then 1
					   when 'Tuesday' then 2
					   when 'Wednesday' then 3
					   when 'Thursday' then 4
					   when 'Friday' then 5
					   when 'Saturday' then 6
					   when 'Sunday' then 7
					   end

select datepart(WEEKDAY, getdate()) as int_date,
	   datename(weekday, getdate()) as char_date

















