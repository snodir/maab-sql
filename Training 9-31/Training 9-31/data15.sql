create  database data15
use data15
go

create table payments(payerid int, payment_amount int, payment_date date)
insert into payments values (1, 1000, '01-01-2018'),(1, 1800, '02-07-2018'),(1, 1800, '03-11-2018'),
							(2, 1700, '01-01-2018'),(2, 180, '02-07-2018'),(2, 15750, '03-11-2018'),
							(3, 1050, '01-01-2018'),(3, 2100, '02-07-2018'),(3, 1300, '03-11-2018')
create table payer(payerid int, payername nvarchar(25))
insert into payer values(1, 'Sam'),(2, 'Nancy'),(3, 'Rocky'),(4, 'Bek')

select b.payername, a.payment_amount, a.payment_date from payments as a inner join payer as b on a.payerid=b.payerid

select (select payer.payername from payer  where payer.payerid=payments.payerid) as payername, payments.payment_amount, payments.payment_date
from payments  

select payer.payername, payments.payment_amount, payments.payment_date from payments inner join payer on payer.payerid=payments.payerid

select payername from payer where payerid not in(select payments.payerid from payments)

select b.payername, min(a.payment_date),  min(a.payment_amount) from payments as a 
inner join payer as b on a.payerid=b.payerid group by b.payername

select  A.payername,  A.payment_date, A.payment_amount from 
													(select b.payername, a.payment_amount, a.payment_date, ROW_NUMBER() over(partition by b.payername order by a.payment_date) as rw 
from payments as a inner join payer as b on a.payerid=b.payerid) as A where A.rw=1

select b.payername, a.payment_date, a.payment_amount from payments as a inner join payer as b on a.payerid=b.payerid
where a.payment_date=(select top 1 c.payment_date from payments as c where c.payerid=b.payerid order by c.payment_date)

select b.payername, a.payment_date, a.payment_amount from payments as a inner join payer as b on a.payerid=b.payerid
where a.payment_amount in (select top 1 c.payment_amount from payments as c where c.payerid=b.payerid order by c.payment_amount)

select b.payername, a.payment_date, a.payment_amount from payments as a inner join payer as b on a.payerid=b.payerid
where a.payment_date=(select  min(c.payment_date) from payments as c where c.payerid=b.payerid )

select payments.payerid, 
payments.payment_amount, 
payments.payment_date, 
ROW_NUMBER() over(partition by payments.payerid order by payments.payment_date)
from payments



