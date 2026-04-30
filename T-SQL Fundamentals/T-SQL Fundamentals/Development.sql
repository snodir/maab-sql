create database Development

create table Students(id int identity(1,1), name nvarchar(50))
insert into Students values('Ali dev'),('Vali dev'),('Soli dev')

select * from Students

restore headeronly
from disk= 'C:\Program Files\Microsoft SQL Server\150\DTS\Binn\SSISDBBackup.bak';

SELECT TOP (1000) [ConfigurationFilter]
      ,[ConfiguredValue]
      ,[PackagePath]
      ,[ConfiguredValueType]
  FROM [Development].[dbo].[SSIS Configurations]

  update [Development].[dbo].[SSIS Configurations] 
  set ConfiguredValue=1
  where  PackagePath='\Package.Variables[User::empid].Properties[Value]'

  update [Development].[dbo].[SSIS Configurations] 
  set ConfiguredValue='Production'
  where  PackagePath='\Package.Connections[DESKTOP-20RAN2E.Development].Properties[InitialCatalog]'

exec sp_who
