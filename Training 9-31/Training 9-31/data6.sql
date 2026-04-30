--create database data6
--go
--use data6
--go

select * into payer from [data5].[dbo].[payers] 
select FirstName, amount from payer

select FirstName, count(amount) from payer group by FirstName
select FirstName, count(FirstName) from payer group by FirstName

select FirstName, amount from payer where FirstName='John'
select FirstName, amount from payer group by FirstName, amount having FirstName='John'

select FirstName, count(amount) as the_most_payments from payer group by FirstName having count(amount)>=2
select FirstName, sum(amount) from payer group by FirstName having sum(amount)>=100

create table agents(name varchar(30), office varchar(20), IsHeadOffice varchar(3))
select * from agents
select distinct name, office, isheadoffice from agents where (office='USA' and IsHeadOffice='yes') or (office='GER' and IsHeadOffice='no')
group by name

select name, office, isheadoffice from agents where (office='USA' and IsHeadOffice='yes') or (office='GER' and IsHeadOffice='no')

USE [data6]
GO
/****** Object:  Table [dbo].[agents]    Script Date: 13/12/2021 16:45:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agents](
	[name] [varchar](30) NULL,
	[office] [varchar](20) NULL,
	[IsHeadOffice] [varchar](3) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[payer]    Script Date: 13/12/2021 16:45:28 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payer](
	[FirstName] [varchar](50) NULL,
	[amount] [int] NULL
) ON [PRIMARY]
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Kurt', N'UK', N'yes')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Kurt', N'USA', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Kurt', N'GER', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Nick', N'USA', N'yes')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Nick', N'FRA', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Nick', N'RUS', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Alex', N'JAP', N'yes')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Alex', N'CHIN', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Alex', N'ITA', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Tom', N'GER', N'yes')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Tom', N'USA', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Tom', N'UK', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Dom', N'USA', N'yes')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Dom', N'GER', N'no')
GO
INSERT [dbo].[agents] ([name], [office], [IsHeadOffice]) VALUES (N'Dom', N'ITA', N'no')
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'John', 48)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'John', 52)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'Josh', 51)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'Ahmed', 55)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'Ahmed', 50)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'Ahmed', 56)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'Steve', 47)
GO
INSERT [dbo].[payer] ([FirstName], [amount]) VALUES (N'Alex', NULL)
GO

select name, office, isheadoffice from agents where (office='USA' and IsHeadOffice='yes') or (office='GER' and IsHeadOffice='no')


select name, count(distinct office) from agents where (office='USA' and IsHeadOffice='yes') or (office='GER' and IsHeadOffice='no') 
group by name having count(distinct office)>1

create table parent(PName varchar(30), CName varchar(30), gender char(1))
insert into parent values('Karen', 'Peter', 'm'), ('Karen', 'Alex', 'm'),('Karen', 'Tom', 'm'),
						 ('Kurt', 'Nick', 'm'), ('Kurt', 'Rose', 'f'),('Kurt', 'Sara', 'f'),
						 ('Artur', 'Jack', 'm'), ('Artur', 'Anna', 'f'), ('Artur', 'Jim', 'm'),
						 ('John', 'Sabine', 'f'), ('Artur', 'Emma', 'f'), ('Artur', 'Kim', 'm') 

select * from parent
select pname, count(distinct gender) from parent group by PName having count(distinct gender)>1

create table swimming(id int, name varchar(20))
create table chess(id int, name varchar(20))

insert into swimming values(1, 'Tom'), (2, 'Jack'), (3, 'Jim'), (4, 'Kim'), (5, 'Berndt')
insert into chess values(1, 'Tom'), (5, 'Ross'), (3, 'Jim'), (4, 'Kim'), (6, 'Mike')

with A as (select *, ROW_NUMBER()over(partition by name order by name)as Rw from swimming)
--select * from A
delete from A where A.Rw>1
delete from swimming where name='Ross' or name='Mike'

select id, name from swimming where id in (2)
select id, name from chess

select id, name from swimming
union
select id, name from chess

 select PName from parent where gender='m'
 intersect
 select PName from parent where gender='f'

 create table t1(letters char(1), numbers int )
 insert into t1 values('a', 1), ('d', 1), ('c', 3), ('e', 4), ('f', 6), ('g', 5)
 select letters from t1 order by case when letters='e' then 1 else 2 end, letters asc
