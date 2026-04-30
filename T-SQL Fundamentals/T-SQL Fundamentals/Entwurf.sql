create database Entwurf
select * into chern from TSQL2012.Sales.Orders
select * from chern where custid=71 
select empid, orderdate, count(freight) from chern where custid=71 group by empid, orderdate  

create table digits(digit int primary key not null)
insert into digits values(0), (1),(2),(3),(4),(5),(6),(7),(8),(9)

select D1.digit, D2.digit, D3.digit, D4.digit, D5.digit 
from digits as D1 
					cross join digits as D2
			        cross join digits as D3 
					cross join digits as D4 
					cross join digits as D5 			          
order by 10*D2.digit+100*D1.digit+D3.digit+1

create table temp(col1 int, col2 int)
insert into temp values(4, 3), (9, 2),(6, 1),(4, 1),(1, 3),(5, 0),(7, 3),(8, 2)
select col1, col2 from temp where col2<>0 and col1/col2>2

select * into child FROM [data6].[dbo].[parent]
select * from child
alter table child
add id int identity
select id, PName, CName,  gender, ROW_NUMBER() over(partition by Pname order by gender) 
from child 
order by id

SELECT [letters]
      ,[numbers] into anyt FROM [data6].[dbo].[t1]

create table num(number int)
insert into num values (0), (1),(1),(1),(4),(5),(6),(7),(8),(10)
 
select digits.digit from digits
select num.number from num

select digits.digit, num.number from digits inner join num on digits.digit=num.number
select digits.digit, num.number from digits left join num on digits.digit=num.number
select digits.digit, num.number from digits right join num on digits.digit=num.number
select digits.digit, num.number from digits full join num on digits.digit=num.number
select digits.digit, num.number from digits cross join num 

create table reverse_return(id int identity, name varchar(25))
insert into reverse_return values('A'),('B'),('C'),('D'),('E'),('F')
select * from reverse_return

;with A as (select id, name, row_number() over(order by name ) as name_asc from reverse_return)
select * 
from A inner join 
					(select  id, name, row_number() over(order by name desc ) as name_desc from reverse_return) as B
on A.name_asc=B.name_desc;


drop table grade;
create table grade(id int, mark int)
insert into grade values(1, 4 ),(1, 5 ),(1, 3 ),(2, 4 ),(2, 4 ),(2, 3 ),(3, 5 ),(3, 4 ),(3, 5 ),(4, 5),(4, 5 ),(4, 4 )
select * from grade
select * from (select distinct * from grade a where a.mark=4) A inner join grade b on A.mark=b.mark
go

--stored procedure with output parameters
create proc usp_getTotalCount1
@totcount int output
as
begin
	select @totcount=count(number) from num
end

declare @total int
--exec usp_getTotalCount1 @total output
exec usp_getTotalCount1 @totcount = @total  output
print @total
go 


--stored procedure with return values
alter proc usp_getTotalCount2
as
begin
	return(select count(number) from num)
end

declare @total int
--exec usp_getTotalCount1 @total  output
exec @total = usp_getTotalCount2 
print @total
go

alter proc usp_getNamebyID1
@id int, 
@name nvarchar(100) out
as
begin
	select @name=PName from child where id = @id
end

declare @empName nvarchar(100) 
execute usp_getNamebyID1 @id=10, @empName out
print 'Name of the employee is '+@empName

--cross apply--
create table t1(letters nvarchar(25))
insert into t1 values('A'),('B'),('C'),('D'),('E')

create table t2(letters nvarchar(25))
insert into t2 values('D'),('E'),('F'),('G')

select t1.letters, cross_apply.letters, (select t2.letters from t2 where t1.letters=t2.letters) as t2_col
from t1 
cross apply
(select t2.letters from t2 where t1.letters=t2.letters) as cross_apply

--cross join--
select t1.letters, cross_join.letters
from t1 
cross join
(select t2.letters from t2 where t2.letters=some(select t1.letters from t1)) as cross_join
order by t1.letters, cross_join.letters

--outer apply--
select t1.letters, outer_apply.letters
from t1 
outer apply
(select t2.letters from t2 where t1.letters=t2.letters) as outer_apply

create table myself(me nvarchar(25))
insert into myself values('Nodir'),('Sadullaev'),('Omonboyevich')
select me from myself

declare @one_row  nvarchar(100) = ''
select @one_row = @one_row  + me +', '  from myself
select left(@one_row, len(@one_row)-1) as I_am_single_row

CREATE table numbers(num int);
select num, count(num) from numbers group by num

select *from numbers
select * from digits

select digit, (select top 1 num from numbers order by num desc) from digits
select digit, (select top 1 digit from digits) from digits
select digit, (select top 1 num from numbers as n where n.num=d.digit ) from digits as d
select digit from digits where exists(select 1 from numbers where num=digit)
select digit from digits where exists(select 1 from numbers as n where n.num!=digits.digit)
select digit from digits where not exists(select 1 from numbers as n where n.num=digits.digit)
select digit, (select avg(num) from numbers as n where n.num=d.digit ) from digits as d


alter procedure dbo.usp_CutRepeatedLetters
@TextInput nvarchar(80)--, @k int
as
begin
;with Rec
as
	(
	 select 1 as n, substring(@TextInput, 1, 1) as Letters
	 union all
	 select Rec.n+1, SUBSTRING(@TextInput, Rec.n+1, 1) from Rec where Rec.n<len(@TextInput)
	)
,a 
as
	(
	 select Rec.n, Rec.Letters, ChangedCol=case when Rec.Letters=lag(Rec.Letters) over(order by n) then 0 else 1 end  from Rec
	)
end

exec dbo.usp_CutRepeatedLetters 'gghff'



declare @TextInput nvarchar(80)='gggjjhbhj'-- @k int

;with Rec
as
	(
	 select 1 as n, substring(@TextInput, 1, 1) as Letters
	 union all
	 select Rec.n+1, SUBSTRING(@TextInput, Rec.n+1, 1) from Rec where Rec.n<len(@TextInput)
	)
,a 
as
	(
	 select Rec.n, Rec.Letters, ChangedCol=case when Rec.Letters=lag(Rec.Letters) over(order by n) then 0 else 1 end  from Rec
	)
,b
as
	(	
	 select *, sum(ChangedCol) over(order by n) as GroupingCol from a
	)
select GroupingCol,  from b group by GroupingCol


if object_id('TempTbl') is not null
drop table TempTbl;
declare @TextInput nvarchar(80)='gggjjhbhj'-- @k int
;with Rec
as
	(
	 select 1 as n, substring(@TextInput, 1, 1) as Letters
	 union all
	 select Rec.n+1, SUBSTRING(@TextInput, Rec.n+1, 1) from Rec where Rec.n<len(@TextInput)
	)
,a 
as
	(
	 select Rec.n, Rec.Letters, ChangedCol=case when Rec.Letters=lag(Rec.Letters) over(order by n) then 0 else 1 end  from Rec
	)
,b
as
	(	
	 select *, sum(ChangedCol) over(order by n) as GroupingCol from a
	)
select * into TempTbl from b

;with c
as
(
	select *, count(GroupingCol) over(partition by GroupingCol) as RepeatedLet from TempTbl
)
--delete from c where RepeatedLet=2
select * from TempTbl

select nullif('Nodir', 'nodir')



declare @InpText varchar(100)='cdhbfk#ansi242l'
;with a
as
(
select 1 as n, substring(@InpText, 1, 1) as Letters
union all
select a.n+1, SUBSTRING(@InpText, a.n+1, 1) from a where a.n<len(@InpText)
)
,b 
as
(
select *, row_number() over(order by a.n desc) as nAsc from a
),
c as (
	select letters, n as col from b where ISNUMERIC(letters) = 1
	union all
	select letters, nAsc as col from b where ISNUMERIC(letters) <> 1
)
select * from  c 


create table Accounttbl(acc_id int, balance int)
SELECT * FROM Accounttbl



create table CountIssue(Country varchar(50), Region varchar(50), City varchar(50), Qishloq varchar(50))

insert into CountIssue values('Uzb', 'Tash', 'Chil', 'xaoi'),
						     ('Uzb', 'Tash', 'Yun', 'sxmk'),
							 ('Uzb', 'Tash', 'Chil', 'aswq'),
							 ('Uzb', 'Tash', 'Chil', 'A55555'),
							 ('Uzb', 'Tash', 'Yun', '475sx'),
							 ('Uzb', 'Khor', 'Khan', 'Toma'),
							 ('Uzb', 'Khor', 'bagat', 'skj'),
							 ('Uzb', 'Khor', 'Urg', '4sxs'),
							 ('Uzb', 'Khor', 'Khan', 'Durv'),
							 ('Kas', 'Olm', 'shx', 'xaoi'),
							 ('Kas', 'ghv', 'Chil', 'xaoi'),
							 ('Uzb', 'Tash', 'Chil', 'xaoi')
select distinct ci.Country, ci.Region, City from [dbo].[CountIssue] as ci
select count(*) from CountIssue as ci
select count(distinct Country) from CountIssue as ci

select --count(*), 
Country,Region 
from CountIssue as ci 
group by Country, Region
having count(Country)=1

select distinct Country,Region from CountIssue as ci

select Country, 
COUNT(*) as CntRec,
COUNT(Country) as CountryCnt,
count(region) as RegCnt,
COUNT(City) CityCnt,
COUNT(Qishloq) as QishCnt
from CountIssue
group by Country


