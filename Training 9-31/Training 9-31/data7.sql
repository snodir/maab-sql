create database data7
use data7
go

select * into nobel from homework2.dbo.nobel_win
select * from nobel

select  *  from nobel order by newid()
select top 1 with ties * from nobel order by SUBJECT 
														--O'zimiz xohlagan elementni ikkinchi o'rinda qo'yish
alter table nobel
add id int identity(100,1)
select id, row_number() over(order by id desc) as row_num from nobel
select winner, row_num from (select winner, row_number() over(order by winner) as row_num from nobel) as a order by case when row_num in(select top 1 row_num from a) 
;with a as (select winner, row_number() over(order by winner) as row_num from nobel)
select winner from a

order by case when row_num in(select top 1 row_num from a order by row_num) then 1
			  when winner='Reinhard Selten' then 2
			  else 3 end, winner

select * from nobel

begin tran
update nobel set winner='Nodir Sadullaev'
rollback tran
commit tran

update nobel set winner='Bernard Katz'
where id=104 

delete from nobel where country='Japan' and id=(select min(id) from nobel where country='Japan')

insert into nobel values(1970, 'Physics', 'Hannes Alfven',  'Sweden',  'Scientist')
begin tran
delete from nobel where country='Sweden' and subject='Physics'
rollback tran

delete from nobel where country='Sweden' and subject='Physics'

