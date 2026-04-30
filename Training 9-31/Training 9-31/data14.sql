create database data14
use data14
go

create table num1(number int)
create table num2(number int)
insert into num1 values(1),(2),(3),(5)
insert into num2 values(1),(2),(3),(4)

select num1.number, num2.number from num1 inner join num2 on num1.number=num2.number
select num1.number from num1 where num1.number in (select num2.number from num2) 
select num1.number from num1 where exists (select num2.number from num2 where num1.number=num2.number) 
select num1.number from num1 where num1.number=any(select num2.number from num2)

select number as num1table,
	(select  number from num2 where num1.number=num2.number) as num2table
	from num1

select top 1 number from num1 
where number in (select top 3 num1.number from num1 order by number asc) 
order by number desc

select max(number) from num1 where number in (select top 3 num1.number from num1 order by number asc) 

select num1.number, 
(select top 1 a.number from num1 as a where a.number<num1.number order by a.number desc) as [previous number]
from num1

select * into transactions from data12.dbo.transactions
select a.transactiondate, a.amount, sum(b.amount) as runningtotal from transactions as a
          inner join transactions as b on a.transactiondate>=b.transactiondate 
		  group by a.transactiondate, a.amount

select a.transactiondate, a.amount, 
		(select  sum(b.amount) from transactions as b where a.transactiondate>=b.transactiondate) as runningtotal
from transactions as a

select a.transactiondate,  
		(select  top 1 b.transactiondate from transactions as b where a.transactiondate>b.transactiondate order by b.transactiondate desc) as prevdate
from transactions as a







