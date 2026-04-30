alter proc Demo_sp
as
begin 
declare @id as int
select @id=ID from  [dbo].[Emp_SSRS]
select @id=id from [dbo].[ExcelFileInformation]
select @id=1
select @id
end

select * from  [dbo].[Emp_SSRS]
select * from  [dbo].[ExcelFileInformation]

