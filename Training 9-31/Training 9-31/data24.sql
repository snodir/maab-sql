--create database data24
--use data24

select cast('02/18/2019' as date),
	   day('02/18/2019' ),
	   datepart(month, '02/18/2019'),
	   cast(cast(datepart(year, '02/18/2019') as nvarchar) as date) as NewYear,
	   datepart(day, '02/18/2019'),
	   datepart(week, '02/18/2019')
select datepart(week,getdate()),
	   datepart(hour,getdate()),
	   datepart(minute,getdate())

select getdate(),
	   datename(month, getdate()),
	   datepart(day, getdate()),
	   datename(dw, getdate()),
	   cast('2022-01-03 22:39:43.063' as date)as date, 
	   cast('2022-01-03 22:39:43.063' as datetime)as datetime,
	   cast('2022-01-03 22:39:43.063' as datetime2)as datetime2,
	   cast('2022-01-03 22:39:43.063' as smalldatetime)as smalldatetime,
	   cast('2022-01-03 22:39:43.063' as nvarchar(50))as string,
	   cast('2022-01-03 22:39:43.063' as time)as time

select getdate(),
	   format(getdate(), 'hh-mm'),
	   format(getdate(), 'MMM-yyyy'),
	   dateadd(week, -1, cast(getdate() as date)),
	   DATEDIFF(year, '2002-12-05', getdate())

select GETDATe(),
	   cast(getdate() as date),
	   cast(getdate() as datetime),
	   cast(cast(getdate() as date) as datetime),
	   datediff(YEAR, 0, GETDATE()),
	   dateadd(year, datediff(YEAR, 0, GETDATE()), 0),
	   format(cast('2018-08-17' as datetime), 'yyyy-MM-01') as firstdayofmonth
		

select dateadd(YEAR, datediff(year, 0,getdate()), 0 )
	   

select '2012-04-16',
		day('2012-04-16')-1,
		dateadd(day, 1-day('2012-04-16'), '2012-04-16')












