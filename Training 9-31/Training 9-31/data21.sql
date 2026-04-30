create database data21
use data21

select @@SERVERNAME
select @@VERSION
select getdate()
select year('01-01-2022')

select floor(-2.5), ceiling(2.8)
select 100*rand(), cast(100*rand() as int), round(rand()*100, 2)

select * from sys.tables

create table t
(
id int
)
select * from sys.columns
where object_id=581577110

select OBJECT_ID('t')

declare @number int=5
select cast(@number as varchar(5))+' is my number'
print convert(varchar(5), @number)+' is my number'

select @@IDENTITY
select SCOPE_IDENTITY()

create table t1(id int identity(1,1), name nvarchar(25))

insert into t1 values('John'),('Mike'),('Carl')
select @@IDENTITY
select * from t1

create table t2(t1_id int, lname nvarchar(25))
insert into t2 values(@@IDENTITY, 'Carls_lname')

select name, nullif('John', name) from t1
 select name, nullif(name, 'John' ) from t1
  