create database data16
use data16
go

create table employee(id int, name varchar(25), salary int, department varchar(25))
drop table employee
insert into employee values (1, N'John', 100, N'IT'),(3, N'Rich', 90, N'IT'),(4, N'Steve', 80, N'IT'),(5, N'Anna', 200, N'HR'),
							(6, N'Brandy', 180, N'HR'),(7, N'Nancy', 210, N'HR'),(8, N'Bek', 190, N'HR'),(9, N'Cody', 220, N'HR')
select a.id, 
	   a.name,
	   a.salary,
	   a.department
	   ,(select max(c.salary) from employee as c where a.department=c.department ) as max_sal_of_dep
	   from employee as a 
	   where a.salary= (select max(c.salary) from employee as c where a.department=c.department ) order by a.id 

select id, 
	   name,
	   salary,
	   department
	   from employee  
	   where salary in (select max(salary) from employee group by department) 
	   order by id 

select a.id, 
	   a.name,
	   a.salary,
	   a.department
	   --,(select min(c.salary) from employee as c 
	   -- where c.salary in(select top (2) c.salary from employee as c where a.department=c.department order by c.salary desc )) as secondhighest_sal
	   from employee as a 
	   where a.salary= (select min(c.salary) from employee as c 
						where c.salary in(select top (2) c.salary from employee as c 
										 where a.department=c.department order by c.salary desc )
					   ) 
	   order by a.id 

select getdate() as [getdate],  
	   current_timestamp as[current_timestamp],
	   getutcdate() as[getutcdate],
	   sysdatetime() as[sysdatetime],
	   sysutcdatetime() as[sysutcdatetime],
	   sysdatetimeoffset() as[sysdatetimeoffset] ;

select dates, id from 
				(select dates, id,
				lag(id, 1, 0) over (partition by dates order by id) as previous_id
				from tbl) as a
				where a.id!=a.previous_id