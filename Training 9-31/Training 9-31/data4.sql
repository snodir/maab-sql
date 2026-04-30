create database data4

use data4
go

create table students(id int, name nvarchar(30), class int, tuition_per_class int, total_tuition as class*tuition_per_class)
insert into students(id, name, class, tuition_per_class) values(100, 'John', 3, 549), (101, 'Alex', 4, 550)
select id, name, class, tuition_per_class, class*tuition_per_class as total  from data4.dbo.students

create table hr.employee(name nvarchar(30), hire_year int, org_level as case when 2021 - hire_year>=3 then 'senior' else 'junior' end)
insert into employee(name, hire_year) values('Ahmed', 2016), ('Mohamed', 2019)
;with A as (select *, ROW_NUMBER()over(partition by name order by name)as Rw from employee)
--select * from A
delete from A where A.Rw>1
select name, hire_year, case when 2021 - hire_year>=3 then 'senior' else 'junior' end as org_level from employee