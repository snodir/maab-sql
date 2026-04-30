/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [Other]
      ,[Together]
      ,[Cntry]
      ,[City]
      ,[ZipCode]
  FROM [DemoDB].[dbo].[ColumnCompareCaseConcat]

  create table tblCountIssue(Continent char(1), Region char(1), Country char(1), City char(1), Town char(1), Street char(1))
  insert into tblCountIssue values('a','b','c','d','e','f'),
								  ('a','b','c','d','e','g'),
								  ('a','b','c','d','h','i'),
								  ('a','b','c','d','h','f'),
								  ('a','b','c','j','e','f'),
								  ('a','b','c','j','e','f'),
								  ('a','b','k','d','e','f'),
								  ('a','b','k','d','e','d'),
								  ('a','b','k','d','e','p'),
								  ('a','b','l','d','e','f'),
								  ('a','m','c','d','e','f'),
								  ('a','m','c','d','e','f'),
								  ('x','b','c','d','e','f')
 
 select * from tblCountIssue
 select Continent, Region, Country, COUNT(*), COUNT(Continent), COUNT(Region), COUNT(Country), COUNT(City)
 from tblCountIssue
 group by Continent, Region, Country


 declare @str as varchar(250)='I'
 set @str = (select @str+' love')
 select @str = @str + ' me'
 select @str

