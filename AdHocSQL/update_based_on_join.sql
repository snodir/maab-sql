create table Department(DepID int, DepCode varchar(5), DepName varchar(50))
insert into Department(DepID, DepCode) values(1, 'Fin'),(2,'Prod'),(3,'HR')

create table RedundantData(ID int, DepName varchar(50))
insert into RedundantData values(1,'Finance'),(1,'Finance and Accounting'),
								(2,'Production'),(2,'Producing'),(2,'Product'),
								(3,'Human Resources'),(3,'HR Management')
select d.*, rd.ID, rd.DepName from Department as d
inner join RedundantData as rd
on rd.ID=d.DepID

update d 
set d.DepName=rd.DepName
from Department as d
inner join RedundantData as rd
on rd.ID=d.DepID

select * from Department
