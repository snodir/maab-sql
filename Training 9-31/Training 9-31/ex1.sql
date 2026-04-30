create database ex1
use ex1
go

create table simple(number int);
drop table simple
create table math(number int)
insert into math(number) values(1), (2), (3), (4), (5), (6)
select number, case when number%2=0 and number%3 =0 then 'hi bye' 
					when number%2=0 and number%3 !=0 then 'hi'
					when number%2 !=0 and number%3 =0 then 'bye' 
					else null end                                       as result from [ex1].dbo.math
