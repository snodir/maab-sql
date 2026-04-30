create database data29
use data29
go

--local temp table--
create table #temptbl(id int)
insert into #temptbl values(1), (2)
select id from #temptbl
--global temp table--
create table ##temptbl(id int)
insert into ##temptbl values(1), (2)
select id from ##temptbl
--table variable--
declare @tblvariable table(id int)
insert into @tblvariable values(1), (2)
begin tran
delete from @tblvariable
where id=1
rollback tran
select id from @tblvariable


truncate table #temptbl
select id from #temptbl


begin tran
delete from #temptbl
where id=1
rollback tran
select id from #temptbl


alter proc usp_testtemptbl
as 
begin 
	if OBJECT_ID('temptbl') is not null
	begin
	drop table temptbl
	end
	create table temptbl(id int)
	insert into temptbl values(1), (2)
	select id from temptbl
end
exec  usp_testtemptbl

select @@SERVERNAME








