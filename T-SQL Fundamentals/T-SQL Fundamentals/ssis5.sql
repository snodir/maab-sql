create database ssis5
use ssis5
go

select * from current_st
select * from old_st
select * from teacher
select * from AllExcelSheets
insert into current_st select * from ssis1.dbo.current_st
select * into current_st  from ssis1.dbo.current_st

truncate  table current_st
truncate table old_st
truncate table teacher
truncate  table AllExcelSheets
truncate TABLE custAll_at_once_from_Flat_ForEachFileEnumarator


create table custAll_at_once_from_Flat_ForEachFileEnumarator(name varchar(50), city varchar(50))
select * from custAll_at_once_from_Flat_ForEachFileEnumarator 
insert into custAll_at_once_from_Flat_ForEachFileEnumarator select [name], [city] from ssis4.dbo.customer


SELECT * 
FROM OPENROWSET('Microsoft.ACE.OLEDB.12.0', 
   'Excel 12.0 Xml;Database=d:\source\Excel_subsource\infos1.xlsx;', current_st$);

EXEC sp_configure 'show advanced options', 1
RECONFIGURE
GO

EXEC sp_configure 'ad hoc distributed queries', 1
RECONFIGURE

GO

select format(getdate(), 'yyyy.MM.dd')
select * from Kunde

execute master.dbo.xp_fileexist 'C:\Users\NODIR\Desktop\customer.txt'


select * from FromOracleHRdatabaseJobsTbl