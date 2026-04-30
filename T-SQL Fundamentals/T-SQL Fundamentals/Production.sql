create database Production

create table Students(id int identity(1,1), name nvarchar(50))
insert into Students values('Ali'),('Vali'),('Soli')

select * from Students