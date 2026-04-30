create database ssis3
go
use ssis3
go

create table StudentGrades
(
id int,
grade int
)

create table Student
(
id int,
name varchar(50),
city varchar(50)
)

insert into StudentGrades values(6,4),(2,4),(3,5),(4,2),(5,1)
insert into Student values(1,'John','LA'),(2,'Anna','NY'),(3,'Robert','Miami'),(4,'Steve','Dallas'),(5,'Alex','Texas')

-- statistical mean--
select * from StudentGrades
select id, 
	   grade, 
	   avg(grade) over(order by (select null)) as mean,
	   row_number() over(partition by grade order by(select null))
from StudentGrades
select id, grade, (select avg(grade) from StudentGrades) as mean from StudentGrades

-- statistical mode--
select grade, count(grade)
from StudentGrades
group by grade 
order by count(grade) desc, grade asc

delete from StudentGrades
where id=6

--failure of SQL
select id, 
	   grade,
	   row_number() over(order by grade) as ascc,
	   row_number() over(order by grade desc) as descc,
	   abs(row_number() over(order by grade)  - row_number() over(order by grade desc)) as symmetry
from StudentGrades 
order by ascc asc, descc desc


--statistical median--
;with a as
(
select id, 
	   grade,
	   row_number() over(order by grade) as ascc,
	   (count(id) over()+1)/2 as lower_count,
	   (count(id) over()+2)/2 as upper_count
from StudentGrades 
)
select  avg(cast(grade as float)) as median
from a
where a.ascc in(a.lower_count, a.upper_count)

--statistical median--
;with a as
(
select id, grade, PERCENTILE_CONT(0.5) within group(order by grade) over() as median from StudentGrades
)
select id from a 
where median=grade

select name, city from Student
where id=1

select getdate()
select format(getdate(), 'yyyy_MM_dd_hh_mm_ss')

