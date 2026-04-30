create database data26
use data26

select 'Nodir, Omonboyevich, Sadullaev' as fullname,
	   CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev') as firstcommalocation,
	   left('Nodir, Omonboyevich, Sadullaev', CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')-1) as firstname,
	   SUBSTRING('Nodir, Omonboyevich, Sadullaev', 1, CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')-1 ),
	   REVERSE('Nodir, Omonboyevich, Sadullaev') as reversedfull,
	   reverse(right(REVERSE('Nodir, Omonboyevich, Sadullaev'), CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')-1)) as firstnamewithright

select 'Nodir, Omonboyevich, Sadullaev' as fullname,
	   CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev') as firstcommalocation,
	   CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev', CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')+1)  as secondcommalocation,
	   SUBSTRING('Nodir, Omonboyevich, Sadullaev', CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev', CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')+1)+1, len('Nodir, Omonboyevich, Sadullaev')) as lastname,
	   SUBSTRING('Nodir,Omonboyevich,Sadullaev',       CHARINDEX(',', 'Nodir,Omonboyevich,Sadullaev')+1,        CHARINDEX(',', 'Nodir,Omonboyevich,Sadullaev', CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')+1)-CHARINDEX(',', 'Nodir, Omonboyevich, Sadullaev')-1) as middlename
 
 select 'Nodir,Omonboyevich,Sadullaev' as fullname,
		cast('<B>'+REPLACE('Nodir,Omonboyevich,Sadullaev', ',', '</B><B>')+'</B>' as xml),
		cast('<B>'+REPLACE('Nodir,Omonboyevich,Sadullaev', ',', '</B><B>')+'</B>' as xml).value('B[1]', 'nvarchar(20)') as firstname,
		cast('<B>'+REPLACE('Nodir,Omonboyevich,Sadullaev', ',', '</B><B>')+'</B>' as xml).value('B[2]', 'nvarchar(20)') as middlename,
		cast('<B>'+REPLACE('Nodir,Omonboyevich,Sadullaev', ',', '</B><B>')+'</B>' as xml).value('B[3]', 'nvarchar(20)') as lastname

----user defined function---


select	@output=@output+letter from a where letter<>',' and n-n1=@location
select @output



create function udf_stringsplit(@fullname nvarchar(50), @separator nvarchar(50), @location int)
returns nvarchar(100)
as
begin
declare @output nvarchar(50)=''
;with a as(
	select 1 as n, left(@fullname, 1) as letter, 1 as n1
	union all
	select a.n+1, SUBSTRING(@fullname, a.n+1,1), case when SUBSTRING(@fullname, a.n+1,1)=',' then a.n1 else a.n1+1 end
	from a where a.n<len(@fullname)	
)
select	@output=@output+letter from a where letter<>@separator and n-n1=@location
return @output
end

select dbo.udf_stringsplit('Nodir,Omonboyevich,Sadullaev,jr', ',', 0) as firstname,
	   dbo.udf_stringsplit('Nodir,Omonboyevich,Sadullaev,jr', ',', 1) as middlename,
	   dbo.udf_stringsplit('Nodir,Omonboyevich,Sadullaev,jr', ',', 2) as lastname


;with A as (
select *
		--, row_number() over(order by (select null)) as rw
		from string_split('Nodir,Omonboyevich,Sadullaev,jr', ',')
)
select * from A where rw=3


-------Google question------
declare @inptext nvarchar(50)='afg64tjy'



declare @name nvarchar(25)='nodir'
declare @reversedname nvarchar(50)=''
while len(@name)>0
	begin
		set @reversedname=@reversedname+right(@name, 1)
		set @name=left(@name, len(@name)-1)
	end
select @reversedname


select * from string_split('John,Doe', ',')

