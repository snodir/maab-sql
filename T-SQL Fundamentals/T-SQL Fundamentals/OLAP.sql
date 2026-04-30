create DATABASE OLAP
go
use OLAP
GO


--SLOWLY CHNAGING DIMENSION TABLE TYPE ZERO
CReate table dim_student(st_ID_surg_key int identity(1,1), [st_Alt_Business_Nat_key] int, [name] varchar(50), city varchar(50), startdate datetime, endddate datetime)

select id, name, city from OLTPvsOLAP.dbo.student
select * from OLAP.dbo.dim_student
select last_successful_loaddate, getdate() as currentdate from audit_exec_log

truncate table OLAP.dbo.dim_student
truncate table OLTPvsOLAP.dbo.student

insert into OLTPvsOLAP.dbo.student values(4, 'Salli', 'MIL', getdate()),(2, 'Tom', 'LA', getdate())

create table audit_exec_log(exec_id int identity(1,1), last_successful_loaddate datetime)
drop table audit_exec_log
go
select last_successful_loaddate, getdate() as currentdate from audit_exec_log
insert into audit_exec_log values('1990-01-01')

update audit_exec_log
set last_successful_loaddate='1900-01-01'
truncate table audit_exec_log

create table Dates([Dates] date)

;with a
as
(
select 0 as n, month(getdate()) as [Dates]
union all
select a.n+1, dateadd(day, a.n+1, getdate()) from a where dateadd(day, a.n, getdate())<=EOMONTH(getdate())
)
insert into Dates select [Dates] from a

truncate table Dates

select dateadd(year,year(getdate())-1900,0)

--Update etilip turgan tableni datasini go'rish 
set transaction isolation level read uncommitted == nolock

dbcc freeproccache ---allows you to have faster execution plan for the whole database objects

parameterlardan keyin shularni ishlatsa STORED PROCEDURE har safar execute etilganda yangi execution plan yaratadi
with recompile;

if object_id('temptable', 'U') is not null 
drop table temptable
create table temptable([names] varchar(50))
insert into temptable values('Mike')



select * from OLTPvsOLAP.dbo.student;
select st_ID_surg_key, st_Alt_Business_Nat_key, name, city, phonenumdim, startdate, endddate from OLAP.dbo.dim_student;
select last_successful_loaddate, 
	   getdate() as currentdate,
	   case when last_successful_loaddate<getdate() then 1 else 0 end as checking
from audit_exec_log;
select id, [name], city, phonenumstaging, load_date from [OLAP].[dbo].[stg_student];

truncate table OLAP.dbo.stg_student;
truncate table OLAP.dbo.dim_student;

update OLTPvsOLAP.dbo.student
set city='Kiel' where id=3

update OLTPvsOLAP.dbo.student
set modified_date=getdate() where id=3

insert into OLTPvsOLAP.dbo.student values(5, 'Sonny', 'Chicago', getdate())


create table stg_student(id int primary key, [name] varchar(50), city varchar(50), load_date datetime default getdate())

----Slowly Changing Dimension Type1---Overwriting updated data into staging table---
merge OLAP.dbo.dim_student as targett
using [OLAP].[dbo].[stg_student] as src
on targett.st_Alt_Business_Nat_key=src.id
when not matched then
insert (st_Alt_Business_Nat_key, name, city, loaddate) values(src.id, src.name, src.city, src.load_date)
when matched and targett.city<>src.city then
update set targett.city=src.city, targett.loaddate=getdate();


update audit_exec_log
set last_successful_loaddate=?


alter table OLAP.dbo.dim_student
add endddate datetime

----Slowly Changing Dimension Type2---Overwriting updated data and Adding one more additional row for historical data into staging table---
declare @currentdate datetime=getdate()
insert into OLAP.dbo.dim_student(st_Alt_Business_Nat_key, name, city, startdate, phonenumdim, hash_value_dim)
select id, name, city, @currentdate, phonenumstaging, hash_value from 
(
merge OLAP.dbo.dim_student as targett
using [OLAP].[dbo].[stg_student] as src
on targett.st_Alt_Business_Nat_key=src.id
when not matched then
insert (st_Alt_Business_Nat_key, name, city, startdate, phonenumdim, hash_value_dim) values(src.id, src.name, src.city, @currentdate, src.phonenumstaging, src.hash_value)
when matched and targett.hash_value_dim<>src.hash_value then
update set targett.endddate=getdate()
output $action as actionn, src.*
) as mergeoutput where mergeoutput.actionn='update'


select student.id, name, city, phone_num,
concat(ltrim(rtrim(city)), ltrim(rtrim(phone_num))) as unique_composite_Col,
substring(master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', concat(ltrim(rtrim(city)), ltrim(rtrim(phone_num))))),3,32) AS hash_values
from OLTPvsOLAP.dbo.student;


SELECT s.name as schema_name, t.name as table_name, c.* FROM sys.columns AS c
INNER JOIN sys.tables AS t ON t.object_id = c.object_id
INNER JOIN sys.schemas AS s ON s.schema_id = t.schema_id
WHERE t.name = 'Production.[Product]' AND s.name = 'dbo';

CREATE TABLE [dbo].[dim_student_changed_data_capture](
	[st_ID_surg_key] [int] IDENTITY(1,1) NOT NULL,
	[st_Alt_Business_Nat_key] [int] NULL,
	[name] [varchar](50) NULL,
	[city] [varchar](50) NULL,
	[startdate] [datetime] NULL,
	[endddate] [datetime] NULL,
	[phonenumdim] [varchar](50) NULL,
) ON [PRIMARY]
GO

delete from dim_student_changed_data_capture where 	[st_Alt_Business_Nat_key]=?
update dim_student_changed_data_capture set endddate=? where [st_Alt_Business_Nat_key]=?

select * from OLTPvsOLAP.dbo.student;
select st_ID_surg_key, st_Alt_Business_Nat_key, name, city, phonenumdim, startdate, endddate from OLAP.dbo.dim_student_changed_data_capture;
select last_successful_loaddate, 
	   getdate() as currentdate,
	   case when last_successful_loaddate<getdate() then 1 else 0 end as checking
from audit_exec_log;
select id, [name], city, phonenumstaging, load_date from [OLAP].[dbo].[stg_student];

delete from OLTPvsOLAP.dbo.student where id =8

insert into OLTPvsOLAP.dbo.student values(7, 'Tom', 'Kiel', 112)
