--create database ssis2
--go
--use ssis2
--go

create table student(id int, name varchar(20), age int)
go
insert into student values(5, 'Sabine', 22),(6, 'Jack', 24)
go
create table allstudent(id int, name nvarchar(25), age  int, loaddate  date)
go
select * from student
drop table student

select * from allstudent
truncate table allstudent

create table proba(id int identity(1,1), [name] nvarchar(25), age int, constraint PK_proba_id primary key (id))

 drop table proba

create table FromFlat(id int, department varchar(5), salary int)
select * from FromFlat

create table Flat(id int, department nvarchar(5), salary int)
select * from Flat
truncate table flat

select * from FlatExercise