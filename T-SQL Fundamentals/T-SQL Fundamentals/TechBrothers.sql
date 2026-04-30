create database TechBrothers
use TechBrothers
go

select * from emp_tab
select * from emp_pipe
select [name], [city] from customer_comma
truncate table customer_comma
select id, [name], duration from emp_comma
truncate table emp_comma
select * from employee_fast_parse

alter procedure usp_GetRecordsByName @city as nvarchar(25)
as
begin 
	select * from customer_comma where city=@city
end

exec usp_GetRecordsByName 
@city='Frankfurt'

create table people(id int, [name] nvarchar(25))
select * from people

create table FileInformation (FileID INT identity, [FileName] nvarchar(200), LocalDateTime datetime default getdate())
insert into FileInformation(FileName) values(?)

select * from FileInformation

CREATE TABLE dbo.FileInfos
(
Filename VARCHAR(500),
FileCreatedDateTime DATETIME,
FileSize INT
)

;with a
as
(
select *, ROW_NUMBER() over(partition by Filename order by (select null)) as duplicate from FileInfos
)
delete from a where a.duplicate>1

drop table dbo.FileInfos

truncate table st
select * from st

create table num(numb int)
insert into num values(1),(1),(4),(2),(2),(3),(1),(3)

select count(numb)
from num
group by numb

select count(distinct num.numb) from num

create table ZipFileInfo
(
id int identity,
ZipFileName nvarchar(100),
FileName nvarchar(100)
)

select * from ZipFileInfo

create table Verbraucher
(
id int,
[name] varchar(50),
date_of_birth date
)

select * from Verbraucher

truncate table Verbraucher 