create database data20
use data20
go 

create table employee(id int identity, name nvarchar(25), hiredate date, duration as (datediff(month, hiredate, getdate())))
insert into employee values('Mike', '2017-01-01'),('Tom', '2017-01-01'),('John', '2017-02-01'),
					('Josh', '2017-02-01'),('Patrick', '2017-03-01'),('Steve', '2017-03-01'),
					('Luis', '2017-05-01'),('Sara', '2017-05-01'),('Chloe', '2017-07-01')

select * from employee

create proc usp_promote
@duration int
as
begin
	select name from employee where duration>@duration
end

exec usp_promote 56 
select * from employee

alter proc usp_promote
@duration int
as
begin
	select 'following emmployee: ' +name+ ' got promoted'as message from employee where duration>@duration
end

--declare @sql nvarchar(300)=''
--select @sql=@sql+', '+name from employee
--select @sql

declare @sql nvarchar(300)=''
select @sql=@sql+ case when row_number() over(order by (select null))=1 then '' else ', ' end +name from employee
select @sql as oneline

declare @sql nvarchar(300)=''
select @sql=@sql+', '+name from employee
select ', Mike, Tom, John, Josh, Patrick, Steve, Luis, Sara, Chloe', len(', Mike, Tom, John, Josh, Patrick, Steve, Luis, Sara, Chloe'),
		right(', Mike, Tom, John, Josh, Patrick, Steve, Luis, Sara, Chloe', len(', Mike, Tom, John, Josh, Patrick, Steve, Luis, Sara, Chloe')-1)

declare @sql nvarchar(300)=''
select @sql=@sql+', '+name from employee  
set @sql=right(@sql, len(@sql)-1)
set @sql='following employees: '+@sql+' got promoted' 
select @sql as message

alter proc usp_newpromote
@duration int
as
begin
	declare @sql nvarchar(300)=''
	select @sql=@sql+', '+name from employee where duration>@duration
	set @sql=right(@sql, len(@sql)-1)
	select @sql='following employees: '+@sql+' got promoted' 
	select @sql as message
end

exec usp_newpromote 56
exec usp_promote 56