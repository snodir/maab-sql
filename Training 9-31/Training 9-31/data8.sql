create database data8
go
use data8
go
create table t1(num int)
insert into t1 values(1),(1),(1),(2),(2),(2),(3),(3),(3),(4),(4),(5)
select * from t1

select num, ROW_NUMBER() over(order by num) as rw1,
			ROW_NUMBER() over(partition by num order by num) as rw2 from t1
order by ROW_NUMBER() over(partition by num order by num), num 

select num from t1
order by ROW_NUMBER() over(partition by num order by num), num 


create table t2 (name varchar(10), subject varchar(10), grade char(1))
insert into t2 values( null,'Math', 'A'),('John', 'Economics', 'B'),('John', 'Laws', 'B'),
					 ('Josh','Math', 'A'),('Josh', 'Economics', 'A'), ('Josh','Laws', 'A'),
					 ('Tim', 'Math', 'A'), ('Tim', 'Economics', 'C'), ('Tim', 'Laws', 'C'),
					 ('Alex', 'Math', 'B'),('Alex', 'Economics', 'C'),('Alex', 'Laws', 'C')
select * from t2
I. select  name, count(grade) from t2 where grade='A' group by name having count(grade)=3
II. select name from t2 where grade='A'
	except
	select name from t2 where grade!='A'
begin tran
delete from t2
rollback tran 
commit tran

select isnull(name, ''), subject, grade from t2
select coalesce(name, null), subject, grade from t2

