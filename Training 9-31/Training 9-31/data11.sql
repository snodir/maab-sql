create database data11

create table t1(numbers int)

declare @counter int--=1 dep yozsaham bo'laredi
set @counter=1
--truncate table t1

while @counter<=50
begin
	if @counter%2=0
	insert into t1 values (@counter)
	set @counter=@counter+1
end
select numbers from t1 


select * into grades from data8.dbo.t2
select * from grades
select chap.*, ong.* from grades as chap inner join grades as ong on chap.name=ong.name
and chap.grade='A' and ong.grade='B'

select name from grades where grade='A'
union all
select name from grades where grade='B'  

select name from grades where grade='A'
except
select name from grades where grade<>'A'

select name from grades where grade='A' group by name having count(grade)=3
select name from grades where name not in (select name from grades where grade<>'A')
