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
select num from numbers
truncate table numbers



