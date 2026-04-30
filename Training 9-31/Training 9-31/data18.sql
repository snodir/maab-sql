create database data18
use data18
go
create table worker(id int, name nvarchar(25), clientname nvarchar(25))
insert into worker values(1, 'John', 'Anhel'),(1, 'John', 'Rebecca'),(2, 'Steve', 'Ross'),
						 (2, 'Steve', 'Rich'),(2, 'Steve', 'Brandy'),(2, 'Steve', 'Jennifer')
select @@VERSION
 ----SQL 2017 and later versions result
select id, name, string_agg(clientname,', ') as listofclientsname from worker group by id, name
select * from worker  
-----SQL 2012 version result
select distinct A.id, 
			    A.name, 
			   (
			    select case when ROW_NUMBER() over(order by (select null))=1 then '' else ', ' end + B.clientname 
				from worker as B where A.id=B.id for xml path('')
			   )as rollup_result
from worker as A 

