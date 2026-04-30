
----create database data2
----use data2
----go
----create table EmpBirth (EmpID int, EmpName nvarchar(50), BirthDate datetime)

----select EmpID, EmpName, BirthDate from [homework1].dbo.EmpBirth 

----insert into EmpBirth(EmpID, EmpName, BirthDate) values (1, 'Pawan', '12/04/1983') 
----insert into EmpBirth values (2, 'Zuzu', '11/28/1986') 
----insert into EmpBirth values (3, 'Parveen', '05/07/1977')
----insert into EmpBirth values (4, 'Mahesh', '01/13/1983')
----insert into EmpBirth values (5, 'Ramesh', '05/09/1983')

----insert into EmpBirth
----select 6, 'Nodir', '12/05/2002'
----union all
----select 5, 'Ramesh', '05/09/1983'

----	delete from EmpBirth where EmpID=5
----;with A as (select *, ROW_NUMBER()over(partition by EmpID order by EmpID)as Rw from EmpBirth)
----select * from A
------delete from A where A.Rw>1

--create table workers(ID int unique, [First Name] nvarchar(50))
--select * from data2.dbo.workers
--insert into workers values(1, 'Josh')

--if null=null
--begin
--	print 'They are equal'
--end
--else
--begin
--	print 'They are not equal'
--end

--set ANSI_nulls off

--drop table data2.dbo.workers

----create table workers(ID int primary key , [First Name] nvarchar(50))  The easiest way
----create table workers(ID int not null, [First Name] nvarchar(50))

--alter table [data2].dbo.workers
--add primary key(ID) 
 
--select * from data2.dbo.workers
----insert into workers values(2, 'Ihsan', 2 )
--insert into workers values(3, 'John', 3 )

--alter table data2.dbo.workers 
--add DepartmentID int

--create table Department(DepartmentID int primary key, Dep_Name nvarchar(10))
--create table workers(ID int not null, [First Name] nvarchar(50), DepartmentID int foreign key references Department(DepartmentID))
--drop table workers
--drop table Department

--select * from data2.dbo.Department
--select * from workers 

--;with A as (select *, ROW_NUMBER()over(partition by DepartmentID order by DepartmentID)as Rw from Department)
--select * from A
--delete from A where A.Rw>1

--insert into data2.dbo.Department values(1, 'Accounting'), (2, 'Marketing')

--update workers
--set DepartmentID=1 where ID=1





create table groups(id_group int primary key, title nvarchar(50))

create table users(id_user int primary key, id_group int foreign key references groups(id_group), 
first_name nvarchar(50), fam_name nvarchar(50), email nvarchar(50), pass nvarchar(50), about nvarchar(50))

create table topics(id_topic int primary key, id_user int foreign key references users(id_user), date_modified nvarchar(50), 
title nvarchar(50))

create table posts(id_post int primary key, id_topic int foreign key references topics(id_topic), 
id_user int foreign key references users(id_user), date_created nvarchar(50), body nvarchar(50))

create table pages(id_page int primary key, id_user int foreign key references users(id_user), date_modified nvarchar(50),
title nvarchar(50), body nvarchar(50), id_home int)

create table files(id_file int primary key, id_user int foreign key references users(id_user), date_modified nvarchar(50),
title nvarchar(50), filename nvarchar(50))

create table calendar(id_cal int primary key, date_start nvarchar(50), date_end nvarchar(50), title nvarchar(50))

create table schedule(id_sch int primary key, time_start nvarchar(50), time_end nvarchar(50), weekday nvarchar(50),
title nvarchar(50))

