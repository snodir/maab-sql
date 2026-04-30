CREATE database triggers

select * into TestEmp from [SQLpuzzles].[dbo].[Emps]

select * from TestEmp
select * from TestEmpAudit



create table TestEmpAudit(id integer identity, AuditData nvarchar(max))
drop table TestEmpAudit
alter trigger tr_TestEmp_ForInsert
on TestEmp
after insert
as
begin
	declare @id int
	select @id=EmpID from inserted
	
	insert into TestEmpAudit
	values('New employee with id =' + cast(@id as nvarchar(5))  +' is added'+ CAST(GETDATE() as nvarchar(19)))
end

insert into TestEmp values (117, 'Vali', 3, 5000)

create trigger tr_TestEmp_ForDelete
on TestEmp
for delete
as
begin
	declare @id int
	select @id=EmpID from deleted
	
	insert into TestEmpAudit
	values('An existing employee with id =' + cast(@id as nvarchar(5))  +' is deleted'+ CAST(GETDATE() as nvarchar(19)))
end

delete from TestEmp where EmpName='Ali'

select replace(replace(cast(getdate() as nvarchar), ':', '_'), ' ', '__')





