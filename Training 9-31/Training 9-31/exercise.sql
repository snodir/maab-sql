create database exercise

IF OBJECT_ID('TwoUnderscores') IS NOT NULL
DROP TABLE TwoUnderscores

CREATE TABLE TwoUnderscores
(
     Id INT IDENTITY(1,1) PRIMARY KEY
    ,Data VARCHAR(1000)
)
GO
 
INSERT INTO TwoUnderscores VALUES
('1234567890123_ABCD_AN_XX_SRCV_A'),
('1234567890123_ABCDE_AN_XX_FARB_B'),
('eshfew_12_45')
GO

select * from TwoUnderscores

select *, 
		substring(Data, CHARINDEX('_', Data)+1, CHARINDEX('_', Data, CHARINDEX('_', Data)+1)-CHARINDEX('_', Data)-1 ) as chars_between_first_two_underscoures
		from TwoUnderscores

select '1_25_3' as col1


IF OBJECT_ID('workers') IS NOT NULL
DROP TABLE workers

CREATE TABLE workers(
  employee_id INT, 
  NAME VARCHAR(50), 
  manager_id INT
)

INSERT INTO workers VALUES
  (1 , 'Mike', 3),
    (2 , 'David', 3),
    (3 , 'Roger', null),
    (4 , 'Mary', 2),
    (5 , 'Joseph', 2),
    (7 , 'ben', 2)

select * from workers

select W1.employee_id, w1.NAME, w1.manager_id, w2.employee_id, w2.NAME 
from workers as w1
left outer join workers as w2
on w1.manager_id=w2.employee_id


--mukammal son--
alter proc usp_muk_son
@number int, @counter int=2
as
begin
	if OBJECT_ID('exercise.dbo.muk_son') is not null
	drop table dbo.muk_son;
	create table dbo.muk_son(numbers int);
	
	while @counter<=@number
		begin 
			insert into exercise.dbo.muk_son(numbers) values(@counter)
			set @counter=@counter+1
		end;

	;with a as
	(
	select numbers, ROW_NUMBER() over(order by (select null)) as boluvchi from muk_son
	)
	,b as
	(
	select  x.numbers , y.boluvchi, x.numbers%y.boluvchi as qoldiq
	from a as x
	inner  join a as y
	on x.numbers>y.boluvchi
	)
	,c as
	(
	select b.numbers, sum(b.boluvchi) as boluvchilar_yigindisi
	from b
	where b.qoldiq=0
	group by b.numbers
	)
	select c.numbers,
		   c.boluvchilar_yigindisi
	from c
	where c.numbers=c.boluvchilar_yigindisi;
end

execute dbo.usp_muk_son 6 



alter proc usp_mukammal_son
@int int
as
begin
	;with a as
	(
	select 2 as n
	union all
	select a.n+1
	from a where a.n<@int
	)
	,b as
	(
	select a.n, ROW_NUMBER() over(order by (select null)) as natural_num from a
	)
	,c as
	(
	select  x.n, y.natural_num, x.n%y.natural_num as qoldiq
	from b as x
	inner  join b as y
	on x.n>y.natural_num
	)
	,d as
	(
	select c.n, sum(c.natural_num) as boluvchilar_yigindisi
	from c
	where c.qoldiq=0
	group by c.n
	)
	select d.n,
		   d.boluvchilar_yigindisi
	from d
	where d.n=d.boluvchilar_yigindisi
end

exec usp_mukammal_son 6


CREATE TABLE max_value
(
Year1 INT
,Max1 INT
,Max2 INT
,Max3 INT
)
GO

CREATE table owner.max_value
(
Year1 INT
,Max1 INT
,Max2 INT
,Max3 INT
)
 
INSERT INTO max_value
VALUES
 (2001,10,101,87)
,(2002,103,19,88)
,(2003,21,23,89)
,(2004,27,28,91)

SELECT * FROM max_value

;with maxmax as
(
select year1 as years, max1 as maxmax_col from max_value
union all
select year1, max2 from max_value
union all
select year1, max3 from max_value
)
select distinct(years), max(maxmax_col) over(partition by years) as maxmax_col from maxmax 
--select years, maxmax_col from maxmax
--where maxmax_col in ( select max(maxmax_col) from maxmax group by years)

--string with commas to one column--
select * from string_split('Nodir, Omonboyevich, Sadullaev', ',')








