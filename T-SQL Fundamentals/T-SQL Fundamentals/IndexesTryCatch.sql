create database indexes
go
use indexes
go

create table tblSampleNumbers(id int)
insert into tblSampleNumbers values(11),(0),(4),(7),(7),(3),(9),(2)
select * from tblSampleNumbers

create clustered index ix_testID
on tblSampleNumbers(id)

drop index ix_testID on tblSampleNumbers

create index ix_IDdesc
on tblSampleNumbers(id desc)

sp_helpindex tblSampleNumbers

drop index ix_IDdesc on tblSampleNumbers
drop index tblSampleNumbers.ix_IDdesc 

truncate table tblSampleNumbers

declare @num int=1
while (@num<=4000)
begin
	insert into tblSampleNumbers values(@num)
	set @num=@num+1
end

select id from tblSampleNumbers where id=500

create table workers(id int, [name] nvarchar(25))

declare @count int=1
while (@count<=5000)
begin
	insert into workers values(ROUND(rand()*10000,0), CONCAt('name', ROUND(rand()*10000,0)))
	set @count=@count+1
end

set statistics IO on
select * from workers where id =9629

create clustered index ix_ID_onWorkers
on workers(id)

drop  index ix_ID_onWorkers on workers

create nonclustered index ncix_ID_onWorkers
on workers(id)

dbcc freeproccache

create table numbers(num int)
select num from numbers
truncate table numbers

begin tran
insert into numbers values(1)
insert into numbers values(2)
rollback tran
select * from numbers

create table Accounttbl(acc_id int, balance int)
insert into Accounttbl values(101, 1000),(102,500)
select * from Accounttbl;
delete from Accounttbl where acc_id=103


alter procedure usp_TranMoney
@senders_acc int,
@receivers_acc int,
@tran_amt int
as
begin
begin try
begin tran
	update Accounttbl 
	set balance=balance-@tran_amt
	where acc_id=@senders_acc
	update Accounttbl 
	set balance=balance+@tran_amt
	where acc_id=@receivers_acc
if (not exists(select acc_id from Accounttbl where acc_id=@receivers_acc))
	rollback tran
else
	commit tran
end

exec usp_TranMoney 101, 102, 200



--try catch
alter procedure usp_TranMoney
@senders_acc int,
@receivers_acc int,
@tran_amt int
as
begin
begin try
  begin tran
	update Accounttbl 
	set balance=balance-@tran_amt
	where acc_id=@senders_acc
--raiserror('This error is caused by Bek', 16, 1)
select 1/0
	update Accounttbl 
	set balance=balance+@tran_amt
	where acc_id=@receivers_acc
  commit tran
end try

begin catch
  rollback tran
  select ERROR_MESSAGE()
end catch
end

select * from Accounttbl;

begin tran 
insert into Accounttbl values(101, 2000)
commit tran

begin tran 
truncate table Accounttbl
commit tran

select * from [dbo].[SSIS Configurations]

update [dbo].[SSIS Configurations]
set ConfiguredValue='Entwurf'
where PackagePath='\Package.Connections[DESKTOP-20RAN2E.indexes].Properties[InitialCatalog]';

truncate table Accounttbl
select * from Accounttbl
select * from Entwurf.dbo.Accounttbl