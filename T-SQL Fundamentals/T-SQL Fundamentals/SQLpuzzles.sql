create database SQLpuzzles
go
use SQLpuzzles
go


CREATE TABLE lagg
(
BusinessEntityID INT
,SalesYear   INT
,CurrentQuota  DECIMAL(20,4)
)
GO
 
INSERT INTO lagg
SELECT 275 , 2005 , '367000.00'
UNION ALL
SELECT 275 , 2005 , '556000.00'
UNION ALL
SELECT 275 , 2006 , '502000.00'
UNION ALL
SELECT 275 , 2006 , '550000.00'
UNION ALL
SELECT 275 , 2006 , '1429000.00'
UNION ALL
SELECT 275 , 2006 ,  '1324000.00'

--Puzzle1 --Find Previous Value
--I way
select *, lag(lagg.CurrentQuota, 1, 0) over(order by (select null)) as prev from lagg

--II way
;with a 
as
(
select *, ROW_NUMBER() over(order by (select null)) as HelperID from lagg
)
select l1.BusinessEntityID, l1.SalesYear, l1.CurrentQuota, isnull(l2.CurrentQuota, 0)  from a as l1
left outer join a as l2
on l1.HelperID=l2.HelperID+1

--Puzzle2 --Find next value
--I way
select *, lead(lagg.CurrentQuota, 1, 0) over(order by (select null)) as prev from lagg

--II way
;with a 
as
(
select *, ROW_NUMBER() over(order by (select null)) as HelperID from lagg
)
select l1.BusinessEntityID, l1.SalesYear, l1.CurrentQuota, isnull(l2.CurrentQuota, 0)  from a as l1
left outer join a as l2
on l1.HelperID=l2.HelperID-1

--Puzzle3 --Movie&RolePuzzle

CREATE TABLE [Movie]
(
 
[MName] [varchar] (10) NULL,
[AName] [varchar] (10) NULL,
[Roles] [varchar] (10) NULL
)
 
GO
 
--Insert data in the table
 
INSERT INTO Movie(MName,AName,Roles)
SELECT 'A','Amitabh','Actor'
UNION ALL
SELECT 'A','Vinod','Villan'
UNION ALL
SELECT 'B','Amitabh','Actor'
UNION ALL
SELECT 'B','Vinod','Actor'
UNION ALL
SELECT 'D','Amitabh','Actor'
UNION ALL
SELECT 'E','Vinod','Actor'
 
--Check your data
--First way
SELECT MName , Roles FROM Movie where AName='Amitabh'
intersect 
SELECT MName , Roles FROM Movie where AName='Vinod'


--Second way
;with a
as
(
SELECT MName, AName, Roles FROM Movie  where AName='Amitabh'
),
b
as
(
SELECT MName, AName, Roles FROM Movie where AName='Vinod'
)
select m1.MName, m1.AName, m2.AName, m1.Roles from a as m1
inner join b as m2
on m1.MName=m2.MName and m1.Roles=m2.Roles

select MName, count(AName), Roles 
from Movie
group by MName, Roles
having count(distinct AName)=2

--Puzzle4 --Unwanted Null Values Puzzle
CREATE TABLE PQ
(
ID INT
,Name VARCHAR(10)
,Typed VARCHAR(10)
)
 
--Insert data
INSERT INTO PQ(ID,Name,Typed) VALUES  (1,'P',NULL) , (1,NULL,'Q')
 
--Verify data
;with a
as
(
SELECT ID, Name, ROW_NUMBER() over(order by (select 1)) as help FROM  PQ where [Name] is not null
),
b 
as
(
select ID, Typed, ROW_NUMBER() over(order by (select 1)) as help from PQ where Typed is not null
)
select a.ID, a.Name, b.Typed from a
inner join b on a.help=b.help


--Puzzle5 nth highest
CREATE TABLE NthHighest
(
 Name  varchar(5)  NOT NULL,
 Salary  int  NOT NULL
)
 
--Insert the values
INSERT INTO  NthHighest(Name, Salary)
VALUES
('e5', 45000),
('e3', 30000),
('e2', 49000),
('e4', 36600),
('e1', 58000)
 
--Check data
;with a
as
(
SELECT top(2) with ties [name], Salary 
FROM NthHighest 
order by Salary desc
)
select top(1) with ties 
[name], 
salary
from a order by Salary 

--Puzzle7; --running total
CREATE TABLE List
(
ID INT
)
GO
 
INSERT INTO List(ID) VALUES (1),(2),(3),(4),(5);

select id, sum(id) over(order by (select null) rows between unbounded preceding and current row) as SumUpToHere from List;

select id, 
(select sum(id) from list as [inner] where [inner].id<=[outer].id) as SumUpToHere
from list as [outer]

--Puzzle8 --Find max value from multipple columns
CREATE TABLE TestMax
(
Year1 INT
,Max1 INT
,Max2 INT
,Max3 INT
)
GO
 
--Insert data
INSERT INTO TestMax 
VALUES
 (2001,10,101,87)
,(2002,103,19,88)
,(2003,21,23,89)
,(2004,27,28,91)
 
--Select data
Select Year1,Max1,Max2,Max3 FROM TestMax
SELECT Year1,
(
       SELECT Max(v)
       FROM (
              VALUES (max1) , (max2), (max3) 
       ) as value(v)
) as mmax
FROM TestMax

--second way
SELECT Year1,
       CASE WHEN Max1 > Max2 AND MAX1 > Max3 THEN MAX1
       WHEN Max2 > Max1 AND MAX2 > Max3 THEN MAX2
       WHEN Max3 > Max2 AND MAX3 > Max1 THEN MAX3
       END AS Maxx
FROM TestMax

--Puzzle9 --Developers salary > managers salary
CREATE TABLE [dbo].[EmpSalaryGreaterManager]
(
[EmpID] [int] NULL,
[EmpName] [varchar](50) NULL,
[EmpSalary] [bigint] NULL,
[MgrID] [int] NULL
)
GO
 
--Insert Data
INSERT INTO [EmpSalaryGreaterManager](EmpID,EmpName,EmpSalary,MgrID)
VALUES
(1,    'Pawan',      80000, 4),
(2,    'Dheeraj',    70000, 4),
(3,    'Isha',       100000,       4),
(4,    'Joteep',     90000, NULL),
(5,    'Suchita',    110000,       4)
 
--Verify Data
SELECT Emp.* FROM [dbo].[EmpSalaryGreaterManager] as Emp
inner join [dbo].[EmpSalaryGreaterManager] as Mngr
on Emp.MgrID=Mngr.EmpID and Emp.EmpSalary>Mngr.EmpSalary


--Puzzle10 --2nd highest salary puzzle
CREATE TABLE Department
(
DeptID INT
,DeptName VARCHAR(10)
)
GO
 
--Insert Data
 
INSERT INTO Department(DeptID,DeptName)
VALUES
(1,'Finance'),
(2,'IT'),
(3,'HR')
 
--Verify Data
 
 
--Create Table
 
CREATE TABLE Emps
(
EmpID INT
,EmpName VARCHAR(50)
,DeptID INT
,EmpSalary FLOAT
)
GO
 
--Insert Data
 
INSERT INTO Emps(EmpID,EmpName,DeptID,EmpSalary) VALUES
(101,'Isha',1,7000),
(111,'Esha',1,8970),
(102,'Mayank',1,8900),
(103,'Ramesh',2,4000),
(104,'Avtaar',2,9000),
(105,'Gopal',3,17000),
(106,'Krishna',3,1000),
(107,'Suchita',3,7000),
(108,'Ranjan',3,17900)
 
--Verify Data
SELECT DeptID,DeptName FROM Department

;with a
as
(
SELECT EmpID, 
	   EmpName,
	   EmpSalary, 
	   [D].[DeptName],
	   dense_rank() over(partition by [D].[DeptName] order by EmpSalary desc) as OrderedSalary
FROM Emps as E
inner join Department as D
on E.DeptID=D.DeptID
)
select EmpID, 
	   EmpName,
	   EmpSalary, 
	   [DeptName]
from a 
where OrderedSalary=2

--Puzzle11 --Remove all zero value 
CREATE TABLE [dbo].[TestMultipleZero]
(
[A] [int] NULL,
[B] [int] NULL,
[C] [int] NULL,
[D] [int] NULL
)
GO
 
--Insert Data
INSERT INTO [dbo].[TestMultipleZero](A,B,C,D)
VALUES (0,0,0,1),(0,0,1,0),(0,1,0,0),(1,0,0,0),(0,0,0,0),(1,1,1,0)
 
--Check data
SELECT A,B,C,D FROM [dbo].[TestMultipleZero] where not (A=0 and B=0 and C=0 and D=0)

--Puzzle12--
CREATE TABLE GroupbyMultipleColumns
(
ID INT
,Typ VARCHAR(1)
,Value1 VARCHAR(1)
,Value2 VARCHAR(1)
,Value3 VARCHAR(1)
)
GO
 
--Insert Data
INSERT INTO GroupbyMultipleColumns(ID,Typ,Value1,Value2,Value3)
VALUES
(1,'I','a','b',''),
(2,'O','a','d','f'),
(3,'I','d','b',''),
(4,'O','g','l',''),
(5,'I','z','g','a'),
(6,'I','z','g','a')
 
--Verify Data
select * from GroupbyMultipleColumns

;with a as
(
SELECT Typ,Value1 FROM GroupbyMultipleColumns 
union all
SELECT Typ,Value2 FROM GroupbyMultipleColumns
union all
SELECT Typ,Value3 FROM GroupbyMultipleColumns
)
select Typ, count(Value1) as [Counts] 
from a
where Value1='a'
group by Typ


--SecondWay--
select Typ, 
	   sum(case when Value1='a' then 1 else 0 end + 
	       case when Value2='a' then 1 else 0 end +
	       case when Value3='a' then 1 else 0 end) as [Counts]
from GroupbyMultipleColumns
group by Typ

--puzzle13

CREATE TABLE [dbo].[testGoldRateChange]
(
[dt] [datetime] NULL,
[Rate] [int] NULL
)
GO
 
--Insert Data
INSERT INTO [dbo].[testGoldRateChange](dt,Rate)
VALUES
('2014-09-18 06:25:19.897', 27000),
('2014-09-19 06:25:19.897', 27000),
('2014-09-20 06:25:19.897', 31000),
('2014-09-21 06:25:19.897', 31000),
('2014-09-22 06:25:19.897', 31000),
('2014-09-23 06:25:19.897', 32000),
('2014-09-24 06:25:19.897', 31000),
('2014-09-25 06:25:19.897', 32000),
('2014-09-26 06:25:19.897', 27000)
 
 select dt, rate from testGoldRateChange
--Check data
;WITH CTE1 
AS
(SELECT dt , Rate , ROW_NUMBER() OVER (ORDER BY dt) Rnk  FROM testGoldRateChange )
,CTE2 
AS
(
SELECT *,  CASE WHEN
              Rate = ( SELECT Rate from CTE1 c3 WHERE c3.rnk =  (SELECT MAX(c1.rnk) FROM CTE1 c1 WHERE c1.rnk < c2.rnk ))  
              THEN 0 ELSE 1 END Identifier,
            SUM(CASE WHEN
              Rate = ( SELECT Rate from CTE1 c3 WHERE c3.rnk =  ( SELECT MAX(c1.rnk) FROM CTE1 c1 WHERE c1.rnk < c2.rnk ))  
              THEN 0 ELSE 1 END) OVER (ORDER BY rnk ) cols                   
                       FROM CTE1 c2
)
SELECT MIN(dt) StartDate , MAX(dt) EndDate , MAX(Rate) Rate FROM CTE2 GROUP BY cols
 

;WITH CTE1 AS
( 
       SELECT dt , Rate , ROW_NUMBER() OVER (ORDER BY dt) Rnk  FROM testGoldRateChange 
)
,CTE2 AS
(
       SELECT *,  CASE WHEN Rate = lag(Rate) over(order by rnk) THEN 0 ELSE 1 END cols FROM CTE1 c2
)
,CTE3 AS
(
       SELECT *,  SUM(cols) over(order by rnk) Grouper FROM CTE2 c2
)
SELECT MIN(dt) StartDate , MAX(dt) EndDate , MAX(Rate) Rate FROM CTE3 GROUP BY Grouper

--puzzle14

CREATE TABLE IndAusSeries
(
TeamA VARCHAR(3)
,TeamB VARCHAR(3)
,MatchDate DATETIME
,WinsBy VARCHAR(3)
)
GO
 
--Insert Data
 
INSERT INTO IndAusSeries(TeamA,TeamB,MatchDate,WinsBy)
VALUES
('Ind','Aus','01-10-2014','Ind'),
('Ind','Aus','01-15-2014','Ind'),
('Ind','Aus','01-19-2014','Ind'),
('Ind','Aus','01-23-2014','Aus'),
('Ind','Aus','01-27-2014','Ind'),
('Ind','Aus','01-31-2014','Ind')
 
--Verify Data
select * from IndAusSeries

--My unfull solution
;with a
as
(
SELECT TeamA,TeamB,MatchDate,WinsBy,
	   case when WinsBy=lag(WinsBy) over(order by matchdate) then 0 else 1 end as grouping_by_agg_sum
FROM IndAusSeries
)
,b
as
(
select a.TeamA, 
	   a.TeamB, 
	   a.MatchDate, 
	   a.WinsBy, 
	   a.grouping_by_agg_sum,
	   sum(a.grouping_by_agg_sum) over(order by MatchDate) as helper 
from a 
),
c
as
(
select b.TeamA, 
	   b.TeamB, 
	   b.MatchDate, 
	   b.WinsBy, 
	   b.grouping_by_agg_sum,
	   b.helper,
	   count(helper) over(partition by helper) as HelperCnt
from b 
)
select top (1) with ties *
from c
--where WinsBy='ind'
order by c.HelperCnt desc

--The right solution
;WITH CTE1 AS
(
    SELECT * , ROW_NUMBER() OVER  (ORDER BY %%Physloc%%) rnk 
    FROM IndAusSeries
)
,CTE2 AS
(
    SELECT *, 
        CASE WHEN WinsBy = lag(WinsBy) 
        over(order by rnk) THEN 0 ELSE 1 END cols 
    FROM CTE1 c2         
)
,CTE3 AS
(
    SELECT * , SUM(cols) OVER (ORDER BY rnk) grouper FROM CTE2
)
,CTE4 AS
(
    SELECT grouper,COUNT(grouper) Maxy FROM CTE3 GROUP BY grouper
)
,CTE5 AS
(
    SELECT MAX(Maxy) Maxy FROM CTE4
)
SELECT c.TeamA , c.TeamB , c.MatchDate , c.WinsBy 
FROM CTE4 a 
INNER JOIN CTE5 b ON a.Maxy = b.Maxy 
INNER JOIN CTE3 c ON c.grouper = a.grouper

--puzzle15

CREATE TABLE TestCommaUsingCrossApply
(
ID INT
,VALUE VARCHAR(100)
)
GO
 
--Insert Data
 
INSERT INTO TestCommaUsingCrossApply(ID,VALUE)
VALUES
(1,'a,b,c'),
(2,'s,t,u,v,w,x')
 
--Verify Data
select ID,VALUE from TestCommaUsingCrossApply
SELECT Id,SplitedValue FROM
(
    SELECT ID,cast(('<X>'+replace(e.VALUE,',' ,'</X><X>')+'</X>') as xml) as xmlcol  FROM  TestCommaUsingCrossApply e 
) s
OUTER APPLY
(
    SELECT ProjectData.D.value('.', 'varchar(100)') as SplitedValue
    FROM s.xmlcol.nodes('X') as ProjectData(D)
) a 
 

--My Solution
select ID,VALUE from TestCommaUsingCrossApply


declare @Temp table([chars] varchar(5))
declare @Temp2 table([chars] varchar(5))

declare @firstRowStr varchar(100)=(select [VALUE] from TestCommaUsingCrossApply where id=1)
declare @firstRowStr2 varchar(100)=(select [VALUE] from TestCommaUsingCrossApply where id=2)

while len(@firstRowStr)>0
begin 
	insert into @Temp(chars) values(substring(@firstRowStr, 1, 1))
	set @firstRowStr=right(@firstRowStr, len(@firstRowStr)-1)
end

while len(@firstRowStr2)>0
begin 
	insert into @Temp2(chars) values(substring(@firstRowStr2, 1, 1))
	set @firstRowStr2=right(@firstRowStr2, len(@firstRowStr2)-1)
end
select 1 as ID, chars from @Temp where chars<>','
union all
select 2 as ID, chars from @Temp2 where chars<>','

--puzzle16
CREATE TABLE TestSplitData
(
 Start DATETIME
,EndDt DATETIME
,Amount INT
)
GO
 
--Insert Data
 
INSERT INTO TestSplitData(Start,EndDt,Amount)
VALUES
('14-Apr-14','13-May-14',200),
('15-May-14','16-Jun-14',320)
 
--Verify Data
 
SELECT Start,EndDt,Amount FROM TestSplitData

select datediff(day, [Start], [EndDt])/2 from TestSplitData

--puzzle17
CREATE TABLE dbo.AlternateMaleFemale
(
ID INT
,NAME VARCHAR(10)
,GENDER VARCHAR(1)
)
GO
 
--Insert data
INSERT INTO dbo.AlternateMaleFemale(ID,NAME,GENDER)
VALUES
(1,'Neeraj','M'),
(2,'Mayank','M'),
(3,'Pawan','M'),
(4,'Gopal','M'),
(5,'Sandeep','M'),
(6,'Isha','F'),
(7,'Sugandha','F'),
(8,'kritika','F')
 
--Verify Data
select DerT.ID, NAME, GENDER 
from 
	(
	 SELECT ID,NAME,GENDER, 
	 row_number() over(partition by gender order by gender desc) as rw
	 FROM AlternateMaleFemale
	 ) as DerT
order by rw asc, GENDER desc

--puzzle18
CREATE TABLE Salaries
(emp_name CHAR(10) NOT NULL,
sal_date DATE NOT NULL,
sal_amt DECIMAL (8,2) NOT NULL,
PRIMARY KEY (emp_name, sal_date));
 
--Insert Data
INSERT INTO Salaries
VALUES ('Tom', '1996-06-20', 500.00),
('Tom', '1996-08-20', 700.00),
('Tom', '1996-10-20', 800.00),
('Tom', '1996-12-20', 900.00),
('Dick', '1996-06-20', 500.00),
('Harry', '1996-07-20', 500.00),
('Harry', '1996-09-20', 700.00);
 
--Verify Data
SELECT emp_name, 
	   max(case when sal_date='1996-06-20' then sal_amt end) as [1996-06-20],
	   max(case when sal_date='1996-07-20' then sal_amt end) as [1996-07-20],
	   max(case when sal_date='1996-08-20' then sal_amt end) as [1996-08-20],
	   max(case when sal_date='1996-09-20' then sal_amt end) as [1996-09-20],
	   max(case when sal_date='1996-10-20' then sal_amt end) as [1996-10-20],
	   max(case when sal_date='1996-12-20' then sal_amt end) as [1996-12-20]
FROM Salaries
group by emp_name




