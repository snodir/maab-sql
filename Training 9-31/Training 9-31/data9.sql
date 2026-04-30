
--create database data9
--go
--use data9
--go
create table wildcardsearch(value nvarchar(10))
insert into wildcardsearch values('some%thing'),('some_thing'),('something')

select * from wildcardsearch
select * from wildcardsearch where value like N'%[%]%'
select * from wildcardsearch where value like N'%@%%' escape '@'
select * from wildcardsearch where value like N'%#_%' escape '#'

select isnull(value, 'I am a null') as checking from wildcardsearch
select coalesce(null, null, 'The 2 previous values are null so i was picked') from wildcardsearch
select coalesce(value, 'The 2 previous values are null so i was picked') from wildcardsearch
select case when null is not null then 'first value' else 'second value' end

create table person(id int, ssn nvarchar(13), passporid nvarchar(13), itid nvarchar(13))
insert into person values(1, '111-11-1111', 'aa155', '123itin'),(2, null, 'aa156', '124itin'),
						(null,  '211-11-1111', null, '125itin'), (4, '311-11-1111', null, '130itin'),
						(5, null, null, null)

select id, ssn, passporid, itid, isnull(ssn, isnull(passporid, itid)), coalesce(ssn, passporid, itid),
case when ssn is null then (case when passporid is null then itid else passporid end) else ssn end,
iif (ssn is null, iif(passporid is null, itid, passporid), ssn) from person

create table t3(num int)
create table t4(num int)

insert into t3 values(-1),(0),(1),(2),(3),(4),(5)
insert into t4 values(2),(3),(4),(5),(6),(7),(8)

 select num from t3
 select num from t4

 
 -- I. outer 1. full outer 2. left outer 3. right outer
 -- II. inner join
 -- III. cross join

-- I. full outer join
 select t3.num, t4.num from t3 full outer join t4 on t3.num=t4.num
 
 --I. left outer join
 select lefttable.num, righttable.num from t3 as lefttable left outer join t4 as righttable on lefttable.num=righttable.num

 --I. right outer join
 select lefttable.num, righttable.num from t3 as lefttable right outer join t4 righttable on lefttable.num=righttable.num
 
 -- II. inner join
 select t3.num, t4.num from t3 inner join t4 on t3.num=t4.num

 --III. cross join
 select t3.num, t4.num from t3 cross join t4 
 select t3.num, t4.num from t3,t4

create table tshirtcolor(color varchar(15))
create table tshirtsize(size varchar(15))

insert into tshirtcolor values('red'), ('black'), ('white')
insert into tshirtsize values('s'), ('m'), ('l')

select color, size from tshirtcolor, tshirtsize --ANSI SQL-89 Syntax

create table t5 (value char(1))
insert into t5 values ('a'), ('b'), ('c'), ('d'), ('e')
  order by a.value --ANSI SQL-92 Syntax

select t5.value+t5.value from t5
drop table customer

 




