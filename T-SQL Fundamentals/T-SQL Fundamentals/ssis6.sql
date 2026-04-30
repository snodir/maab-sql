create database ssis6

select FORMAT(getdate(), 'yyyy_MM_dd')

select * from Employee
truncate table Employee
truncate table current_st
select * from current_st

execute master.dbo.xp_fileexist 'D:\SQL Server Management Studio\src\Flat_subsource\employee.txt'

declare @FileExist int=0;
while @FileExist<>1
begin
	execute master.dbo.xp_fileexist 'D:\source\customer.txt', @FileExist output
	if @FileExist=1 break;
	else waitfor delay'00:00:05'
end


waitfor delay '00:00:10'
select 2

"select * from __InstanceCreationEvent within 10 where TargetInstance ISA \"CIM_DataFile\" and TargetInstance.Name=\"D:\\\\source\\\\customer.txt\""
