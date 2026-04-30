create database object1
go
use object1
go
CREATE TABLE Approver
(
ID INT
,Name VARCHAR(10)
)
GO
 
INSERT INTO Approver(ID,Name)
VALUES (1001,'Ram') , (1002,'Ramesh') , (1003,'Supriya') ,(1004,'Sharlee')
  
CREATE TABLE TicketDetails
(
TicketID INT
,CreatedBy INT
,ApprovedBy INT
)
GO
 
INSERT INTO TicketDetails(TicketID,CreatedBy,ApprovedBy)
VALUES
(1,1001,1004),
(2,1001,1004),
(3,1002,1004),
(4,1001,1003)

select * from Approver
select * from TicketDetails

select t.TicketID, 
	   a.Name as CreatedBy, 
	   b.Name as ApprovedBy  
from TicketDetails as t 
inner join Approver as a
on a.ID=t.CreatedBy
inner join Approver as b
on b.ID=t.ApprovedBy

;with a as
(
select 1 as n
union all
select a.n+1 from a where a.n<10
)
select lag(a.n, 1, 0) over(order by a.n) as col1,
	   lag(a.n, 2, 0) over(order by a.n) as col2
	   from a;


alter proc usp_fibonacci
@top int
as
begin
;WITH Fibonacci AS
(
     SELECT 0 as PrevN, 1 as N
     UNION ALL
     SELECT N, PrevN + N
     FROM Fibonacci
     WHERE N < 1000000000
)
SELECT top (@top) * 
FROM Fibonacci 
end;

execute dbo.usp_fibonacci 8

create table family(id int, fam_members nvarchar(25) constraint PK_Fam_ID primary key(id))
alter table dbo.family
add [BirthYear] date
go
alter table dbo.family
add constraint DF_fam_Birth
default(cast(getdate() as date)) for BirthYear
insert into family(id, fam_members) values(1, 'father' )
insert into family(id, fam_members) values(2, 'mother')
select * from family
create table workers(w_id int, location nvarchar(25) constraint FK_workers_Wid foreign key(w_id)  references family(id))
drop table family
drop table workers

select isdate(getdate())

;with
a
as
(
select 1 as n, substring('Nodir', 1, 1) as letters
union all
select a.n+1, substring('Nodir', a.n+1, 1)
from a 
where a.n<=len('Nodir')
)
select n, letters from a
where letters=''