--create database data3
--use data3
--go

create table child(c_id int, name nvarchar(50), date_of_birth date)
insert into child values(101, 'Ahmed', '1986-01-01')
select * from child

drop table child

create table child(c_id int primary key identity (100,1), name nvarchar(50), date_of_birth date)
insert into child values('Ahmed', '1986-01-01'), ('John', '1987-04-11')
select * from child

insert into child(c_id, name, date_of_birth) values(107, 'Josh', '1986-11-10')
set IDENTITY_INSERT child on

insert into child(c_id, name, date_of_birth) values(102, 'Alex', '1988-08-07')

drop table child

USE [data3]

GO

CREATE SEQUENCE [dbo].[sq_c_id] 
 AS [int]
 START WITH 100
 INCREMENT BY 1

GO

create table child(c_id int primary key default (next value for [dbo].[sq_c_id] ), name nvarchar(50), date_of_birth date)
insert into child(name, date_of_birth) values('Ahmed', '1986-01-01'), ('John', '1987-04-11')
drop table child

create table child(c_id int primary key identity (100,1), name nvarchar(50), date_of_birth date)
insert into child(name, date_of_birth) values('Ahmed', '1986-01-01'), ('John', '1987-04-11'), ('Josh', '1985-06-10')
select * from child

delete from child
insert into child(name, date_of_birth) values('Ahmed', '1986-01-01'), ('John', '1987-04-11')
delete from child where name='Ahmed' or c_id=103

truncate table child




