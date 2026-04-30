create database data23
use data23
go

declare @counter int=1
while @counter<=300
begin
	print @counter 
	set @counter=@counter+1
end
go


declare @text nvarchar(300)='a,ss,5,4,9c,,c4s9ee,8x+', @commacount int=0
	while len(@text)>0
		begin
			if left(@text, 1)=',' --or left(@text, 1 )='0' or left(@text, 1 )='1' or  left(@text, 1 )='2'  or left(@text, 1 )='3' or left(@text, 1 )='4' or left(@text, 1 )='5' or left(@text, 1 )='6' or left(@text, 1 )='7' or left(@text, 1 )='8' or left(@text, 1 )='9'
				begin
				set @commacount = @commacount+1
				end
		set @text=right(@text, len(@text)-1 )
		end
	select @commacount
go			

declare @text2 nvarchar(300)='a,abcajhj'
declare @output nvarchar(300)=''
while len(@text2)>0
	begin
		if left(@text2,1)='a'
			begin
			set @output=@output+left(@text2,1)+','
			end
		else
			begin
			set @output=@output+left(@text2,1)
			end
		set @text2=right(@text2, len(@text2)-1)
	end
	select @output
go

	create table t1(characters char(1))
declare @text nvarchar(300)='a,ss,54,9c,,c4s9ee,8x+'
	while len(@text)>0
		begin
		  insert into t1 values(left(@text, 1))
		  set @text=right(@text, len(@text)-1 )
		end
	select characters, row_number() over(order by (select null)) as indexx from t1
 go
;with a as(
	select 1 as n
	union all
	select a.n+1 from a
	where a.n<10
)
select n from a

declare @text2 nvarchar(300)='a,b,c'
;with a as
(
select 1 as n, left(@text2, 1) as charac
union all
select a.n+1, SUBSTRING(@text2, a.n+1, 1) from a
where a.n<len(@text2)
)
select * from a

create table emp(id int, name nvarchar(25))
create table officevisits(emp_id int, visit_id int, vdate date)

insert into emp values(1, 'Steve'),(2, 'Ihsan')
insert into officevisits values(1,1,'2019-04-01'),(1,2,'2019-04-03'),(2,1,'2019-04-02'),(2,2,'2019-04-05')

select id, name from emp
select emp_id, visit_id, vdate from officevisits



