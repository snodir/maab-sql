create database CrossApply
go
use CrossApply
go

create table Employee(EmployeeID int, FirstName nvarchar(30), LastName nvarchar(25), DepartmentID int)
go
insert into Employee values(1, 'Orlando', 'Gee', 1),(2, 'Keith', 'Harris', 2),
						   (3, 'Donna', 'Cameras', 3),(4, 'Janet', 'Gates', 3)
go
create table Department(DepartmentID int, [Name] nvarchar(25))
go
insert into Department values(1, 'Engineering'),(2, 'Administration'),(3, 'Sales'),
							(4, 'Marketing'),(5, 'Finance')
			
select e.EmployeeID, e.FirstName+' '+e.LastName as [Name], d.Name as DepName from Employee as e 
inner join Department as d
on e.DepartmentID=d.DepartmentID

select * from Department
select * from Employee

select e.EmployeeID, 
	   e.FirstName+' '+e.LastName as [Name], 
	   Dep.[Name] as DepName 
from Employee as e 
cross apply (select * from Department as d where e.DepartmentID=d.DepartmentID) as Dep

alter function in_tf_getDepartName(@DepID int)
returns table
as
return
(
	select DepartmentID, [Name]  from Department where DepartmentID=@DepID
)

--INNER JOIN WITH A REGULAR TABLE
select e.EmployeeID, e.FirstName+' '+e.LastName as [Name], d.Name as DepName from Employee as e 
inner join Department as d
on e.DepartmentID=d.DepartmentID

--INNER JOIN WITH A INLINE-TABLE VALUED FUNCTION
select e.DepartmentID, e.FirstName, e.DepartmentID, udf.Name from Employee as e 
inner join dbo.in_tf_getDepartName(3) as udf 
on e.DepartmentID=udf.departmentID

--CROSS APPY WITH A INLINE-TABLE VALUED FUNCTION
select e.DepartmentID, e.FirstName, e.DepartmentID, udf.Name from Employee as e 
cross apply dbo.in_tf_getDepartName(e.DepartmentID) as udf 

select * from dbo.in_tf_getDepartName(3)

--CROSS APPLY WITH CORRELATED SUBQUERY(RUNNING TOTAL)
select Emp.*, em.running_total
from EmpDepDetails as Emp
cross apply
(
select sum(e.salary) as running_total from EmpDepDetails as e where e.EmpID<=emp.EmpID
) as em


CREATE TABLE workers([name] nvarchar(2500))
insert into workers values('Johnson'),('Jack'),('Steven'),('Stacy')

create table workhours([name] nvarchar(2500), workhours int)

select * from workhours
select * from workers

exec sys.sp_help [in_tf_getDepartName]
exec sys.sp_help '[in_tf_getDepartName]'

exec sys.sp_helptext [in_tf_getDepartName]

