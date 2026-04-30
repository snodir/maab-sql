create database SSISscheduling
go
use SSISscheduling
go

create table tbl([date] datetime)

insert into tbl values(getdate())
select count([date]) from tbl
select [date] from tbl

truncate table tbl

--Executing SSIS pkg through cmd command prompt
C:\Users\NODIR>dtexec /f "d:\SSIS Projects\SSISwithBek(10-25)\SSISwithBek(10-25)\SSISscheduling.dtsx"



exec sp_server_info
exec sp_databases

