create database data12
use data12
go
select * into child FROM [data6].[dbo].[parent]
select * from child
select distinct a.*, b.* from child as a 
				  inner join child as b on a.PName=b.PName
				  and a.gender='m' and b.gender='f'

select a.*, b.* from child as a 
	 left outer join child as b on a.PName=b.PName
	 and a.gender='m' and b.gender='f' where a.gender='m' and b.gender is null

select PName from child where gender='m'
except
select PName from child where gender='f'

select PName from child where gender='m'
intersect
select PName from child where gender='f'

create table employee(id int, name nvarchar(25), managerid int)
insert into employee values(1, 'Great Boss', null), (2, 'First Deputy of Boss', 1), (3, 'Second Deputy of Boss', 1), 
						   (4, 'First Deputy assistant', 2), (5, 'Second Deputy assistant', 3),(6, 'Below First Deputy assist', 4)
select id, name, managerid from employee

select below.name as helper, isnull(chief.name, 'Unknown') as manager, isnull(chief_of_chief.name, 'Unknown') as manager_of_manager from employee as below
	                              left outer join employee as chief on below.managerid=chief.id
								  left outer join employee as chief_of_chief on chief.managerid=chief_of_chief.id
								  
create table transactions(transactiondate date, amount int)
insert into transactions values('2021-01-01', 110), ('2021-02-01', 100),('2021-03-01', 90),('2021-04-01', 80)
select * from transactions 
select a.transactiondate, a.amount, sum(b.amount) from transactions as a
          inner join transactions as b on a.transactiondate>=b.transactiondate 
		  group by a.transactiondate, a.amount



