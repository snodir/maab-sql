CREATE database OLTPvsOLAP

--OLTP - OnLine Transactional Processing - a database that directly works with some applications or web-apps
--OLAP - OnLine Analytical Processing - data warehous or data marts


create table phonecust([name] varchar(50), phone int, phonetype nchar(1)) --c - cellphone, h - homephone
insert into phonecust values('Anna', 101, 'c'),('Anna', 102, 'h'),('Steve', 103, 'c'),('Steve', 104, 'h')

select * from phonecust
[name]	[cell]	[home]
Anna	101		102
Steve	103		104


--First way
select name, 
	avg(case when phonetype='c' then phone end) as cell,
	avg(case when phonetype='h' then phone end) as home
from phonecust 
group by name

--Second Way
;with cell 
as
(
select * from phonecust where phonetype='c'
)
,home
as
(
select * from phonecust where phonetype='h'
)
select c.name, c.phone as cell, h.phone as home  from cell as c
inner join home as h
on c.name=h.name


create table student(id int primary key, [name] varchar(50), city varchar(50), modified_date datetime)
insert into student values(1, 'John', 'NY', getdate())
insert into student values(2, 'Laris', 'Bruklin', getdate())
insert into student values(3, 'Michael', 'AZ', getdate())
insert into student values(4, 'Karen', 'CH', getdate())
insert into student values(8, 'Fredo', 'LasVegas', getdate())

select * from student
drop table OLTPvsOLAP.dbo.student

delete from OLTPvsOLAP.dbo.student
where id=1

insert into student values(1, 'Michael', 'NYC', getdate())

update student 
set city='Madrid' where name='Karen'


execute sys.sp_cdc_enable_db

SELECT TOP (1000) [object_id]
      ,[version]
      ,[source_object_id]
      ,[capture_instance]
      ,[start_lsn]
      ,[end_lsn]
      ,[supports_net_changes]
      ,[has_drop_pending]
      ,[role_name]
      ,[index_name]
      ,[filegroup_name]
      ,[create_date]
      ,[partition_switch]
  FROM [OLTPvsOLAP].[cdc].[change_tables]

SELECT TOP (1000) [object_id]
      ,[column_name]
      ,[column_id]
      ,[column_type]
      ,[column_ordinal]
      ,[is_computed]
      ,[masking_function]
  FROM [OLTPvsOLAP].[cdc].[captured_columns]

  exec sys.sp_cdc_enable_table
  @source_schema=N'dbo',
  @source_name=N'student',
  @role_name=null,
  @supports_net_changes=1  --The last modified data