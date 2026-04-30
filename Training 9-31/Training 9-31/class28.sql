create database data28

use data28
;with recCTE as
(
	select 1 as n
	union all
	select n+1 from recCTE
) 
select * from recCTE
option(maxrecursion 100)

-----Prime number----
declare @number int=19
;with recCTE as
(
select 2 as n
union all
select n+1 from recCTE
where n<@number
)
select a.n
from recCTE as a 
left join recCTE as b 
on a.n>b.n 
group by a.n
having min(a.n%b.n)<>0 or count(b.n)=0

declare @date datetime='2022-01-07 17:40:44.060'
declare @UTCdate datetime=getutcdate()
declare @localdate datetime=getdate()
select @UTCdate, @localdate, DATEDIFF(HH, @localdate, @UTCdate) as diff
set @date=DATEADD(HH, -DATEDIFF(HH, @localdate, @UTCdate), @date)
select @date


create function udf_fromUTCtoLocaldatetime(@date datetime)
returns datetime
as 
begin
declare @UTCdate datetime=getutcdate()
declare @localdate datetime=getdate()
set @date=DATEADD(HH, -DATEDIFF(HH, @localdate, @UTCdate), @date)
return @date
end
select '2022-01-07 18:20:30.163', cast('2022-01-07 18:20:30.163' as date),
	cast(cast('2022-01-07 18:20:30.163' as date) as datetime)
select dbo.udf_fromUTCtoLocaldatetime('2022-01-07 17:40:44.060')


create function udf_tobusinesshour(@datetime datetime)
returns datetime
as 
begin


declare @daystart datetime=cast(cast(@datetime as date) as datetime)
declare @startbusinesshour datetime=dateadd(hh, 8, @daystart)
declare @endbusinesshour datetime=dateadd(hh, 18, @daystart)
if @datetime<@startbusinesshour 
begin
	set @datetime=@startbusinesshour
end
else if @datetime>@endbusinesshour
begin
	set @datetime=dateadd(day, 1, @startbusinesshour)
end
if datename(DW, @datetime)='Saturday'
begin
	set @datetime=dateadd(day, 2, @datetime)
end
else if datename(DW, @datetime)='Sunday'
begin
	set @datetime=dateadd(day, 1, @datetime)
end
return @datetime

end
select dbo.udf_tobusinesshour(getdate())


	


