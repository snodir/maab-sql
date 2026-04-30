
create database homework1
--insert into EmpBirth
--select 'Pawan', '12/04/1983'
--union all 
--select 'Zuzu', '11/28/1986'
--union all
--select 'Parveen', '05/07/1977'
--union all
--select 'Mahesh', '01/13/1983'
--union all
--select 'Ramesh', '05/09/1983'

create table EmpBirth (EmpID int, EmpName nvarchar(50), BirthDate datetime)

select EmpID, EmpName, BirthDate from [homework1].[dbo].[EmpBirth] 
order by EmpID asc
where EmpID=1 or EmpName='Pawan';

insert into EmpBirth(EmpID, EmpName, BirthDate) values (1, 'Pawan', '12/04/1983') 
insert into EmpBirth values (2, 'Zuzu', '11/28/1986') 
insert into EmpBirth values (3, 'Parveen', '05/07/1977')
insert into EmpBirth values (4, 'Mahesh', '01/13/1983')
insert into EmpBirth values (5, 'Ramesh', '05/09/1983')

insert into EmpBirth
select 6, 'Nodir', '12/05/2002'
union all
select 7, 'Rameesh', '06/09/1983'


--;with A as (select *, ROW_NUMBER()over(partition by EmpID order by EmpID)as Rw from EmpBirth)
--select * from A
----delete from A where A.Rw>1

select EmpName, Birthdate from EmpBirth where month(BirthDate)=5 and day(BirthDate)>=7 and day(BirthDate)<=15
use homework1
go

	

