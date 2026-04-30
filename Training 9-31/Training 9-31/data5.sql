create database data5
use data5
go

create table payers(FirstName varchar(50), amount int)
insert into payers(FirstName, amount) values('John', 48), ('John', 52), ('Josh', 51), ('Ahmed', 55), ('Ahmed', 50), ('Ahmed', 56), ('Steve', 47)

select FirstName, max(amount) as max_amount, min(amount) as min_amount, count(amount) as pay_per_payer from payers group by FirstName

select top 1 FirstName, amount from payers order by amount desc

select FirstName, amount from payers where amount=(select max(amount) from payers) 

select * from payers
select FirstName as first_name, max(amount) as max_amount, min(amount) as min_amount, count(amount) as pay_per_payer, sum(amount) as tot_pay_per_person from payers group by FirstName

select FirstName from payers group by FirstName
select count(distinct FirstName) from payers

insert into payers values('Alex', null)

