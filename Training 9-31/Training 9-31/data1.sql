--create database [data1]
--select 1 as Num
--select 'NODIR' as Uppername, 'nodir' as Lowername
--use master

--if 'NODIR'='nodir'
--begin
--	print 'they are same'
--end
--else
--begin
--	print 'they are not same'
--end
select id, Name from [data1].dbo.emp 
create table emp (id int, Name nvarchar(20))
insert into emp (id, Name) values (1, 'John')