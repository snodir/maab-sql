jcreate database extra
Drop table if exists [dbo].[tbl]
Go
CREATE TABLE [dbo].[tbl](
  [dates] [date] NULL,
  [id] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[tbl] ([dates], [id]) 
VALUES (CAST(N'2021-01-01' AS Date), 101),(CAST(N'2021-01-01' AS Date), 101),(CAST(N'2021-01-01' AS Date), 102),(CAST(N'2021-01-01' AS Date), 103),
       (CAST(N'2021-01-02' AS Date), 101),(CAST(N'2021-01-02' AS Date), 102),(CAST(N'2021-01-02' AS Date), 103),(CAST(N'2021-01-02' AS Date), 104),
       (CAST(N'2021-01-02' AS Date), 104),(CAST(N'2021-01-02' AS Date), 104),(CAST(N'2021-01-02' AS Date), 105),
       (CAST(N'2021-01-03' AS Date), 101),(CAST(N'2021-01-03' AS Date), 102),(CAST(N'2021-01-03' AS Date), 105),
     (CAST(N'2021-01-03' AS Date), 105),(CAST(N'2021-01-03' AS Date), 106),
       (CAST(N'2021-01-04' AS Date), 101),(CAST(N'2021-01-04' AS Date), 106)

select * from [dbo].[tbl]
b tran
delete from tbl where dates='2021-01-03' and id=101
insert into tbl values(CAST(N'2021-01-03' AS Date), 101) 
-------Execute me!
select * from (select  cont1.*, cont2.id, cont2.idcnt 
from    (select C.dates, count(distinct C.id) as cnt from tbl as C where C.dates=(select min(C.dates) from tbl as C) group by C.dates
		union
		select C.dates, count(distinct C.id) as cnt from tbl as C left outer join tbl as D
				on C.dates>D.dates and C.id=D.id 
		where D.dates =(select min(dates) from tbl) 
		group by C.dates)  
as cont1 inner join   
(select  A.dates, A.id, B.idcnt from (select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as A inner join
	   (select  dates, max(helper_table.number_of_activities_of_each_person_in_one_day) as idcnt 
		from 
			    (select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as helper_table
		group by dates
		) as B
		on A.dates=B.dates and A.number_of_activities_of_each_person_in_one_day=B.idcnt
		
) 
as cont2 on cont1.dates=cont2.dates) as complex_container
where complex_container.id in (select min(complex_container.id) from (select  cont1.*, cont2.id, cont2.idcnt 
																							from  (select C.dates, count(distinct C.id) as cnt from tbl as C where C.dates=(select min(C.dates) from tbl as C) group by C.dates
																									union
																								select C.dates, count(distinct C.id) as cnt from tbl as C left outer join tbl as D
																														on C.dates>D.dates and C.id=D.id 
																									where D.dates in (select min(dates) from tbl) 
																									group by C.dates)  
																							as cont1 inner join   
																						(select  A.dates, A.id, B.idcnt from (select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as A inner join
																				  (select  dates, max(helper_table.number_of_activities_of_each_person_in_one_day) as idcnt 
																											from 
																											    (select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as helper_table
																																		group by dates
																												) as B
																								on A.dates=B.dates and A.number_of_activities_of_each_person_in_one_day=B.idcnt
		
																) 
																		as cont2 on cont1.dates=cont2.dates) as complex_container
group by complex_container.dates)
-----up to here!

 
 ------Explanation of Aliases------
------cont1
select  C.dates, count(distinct C.id) as cnt from tbl as C where C.dates=(select min(C.dates) from tbl as C) group by C.dates  
		union
		select C.dates, count(distinct C.id) as cnt from tbl as C left outer join tbl as D
				on C.dates>D.dates and C.id=D.id 
		where D.dates in (select min(dates) from tbl) 
		group by C.dates
------cont1

------cont2
select  A.dates, A.id, B.idcnt from (select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as A inner join
	   (select  dates, max(helper_table.number_of_activities_of_each_person_in_one_day) as idcnt 
		from 
			(select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as helper_table
		group by dates) as B
		on A.dates=B.dates and A.number_of_activities_of_each_person_in_one_day=B.idcnt
------cont2

------A
select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates 
------A

-----B
select  dates, max(helper_table.number_of_activities_of_each_person_in_one_day) as idcnt 
from 
	(select dates, id, count(id) as number_of_activities_of_each_person_in_one_day from  tbl group by id, dates) as helper_table
group by dates ----B
-----B

 
-----C             
 select C.dates, count(distinct C.id) as cnt from tbl as C where C.dates=(select min(C.dates) from tbl as C) group by C.dates
 union
 select C.dates, count(distinct C.id) as cnt from tbl as C left outer join tbl as D
				on C.dates>D.dates and C.id=D.id 
 where D.dates in (select min(dates) from tbl) 
 group by C.dates             
-----C 

-----D
select * from tbl as C left outer join tbl as D
				on C.dates>D.dates and C.id=D.id 
-----D

