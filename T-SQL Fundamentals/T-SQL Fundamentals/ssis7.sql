create database ssis7

select * from ssisTesting
select * from error_log

truncate table ssisTesting

create table letters(let nvarchar(5))
insert into letters values('a'),('h'),('e'),('d'),('f'),('k'),('b'),('s')

exec sp_help ssisTesting

select top(2) let from  letters
union all
select let from letters where let='b' 
union all
select let from letters 
where let not in
			   (select l.let 
				from 
					   (
					   select top(2) let, row_number() over(order by (select null)) as rw  from  letters
					   union all
					   select let, 3  from letters where let='b'
					   ) as l
				where l.rw not in (1,2,3)
			   )


