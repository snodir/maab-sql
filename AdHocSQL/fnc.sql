create database DemoDB
create table ColumnCompareCaseConcat(Other varchar(50),Together varchar(50), Cntry varchar(50), City varchar(50), ZipCode varchar(50))
insert into ColumnCompareCaseConcat values('Uzb Knonqa 220814', 'Uzb Knonqa 220814', 'Uzb', 'Knonqa', '220814')
insert into ColumnCompareCaseConcat values('Uzb Jizzax 200100', 'Uzb Jiz 200100', 'Uzb', 'Jizzax', '220814')

select * from ColumnCompareCaseConcat
go
create function udf_ConcatCompare(
@concat varchar(250),
@sum_of_3col varchar(250)
)
returns int
as
begin
declare @concatCopy as varchar(250)=''
declare @sum_ofCopy as varchar(250)=''
declare @diff as int


while len(@concat)>0
begin
	if left(@concat,1) not in(' ', ',')
		set @concatCopy=@concatCopy+left(@concat,1)
	else 
		set @concatCopy=@concatCopy+''
	set @concat=RIGHT(@concat, LEN(@concat)-1)
end


while len(@sum_of_3col)>0
begin
	if left(@sum_of_3col,1) not in(' ', ',')
		set @sum_ofCopy=@sum_ofCopy+left(@sum_of_3col,1)
	else 
		set @sum_ofCopy=@sum_ofCopy+''
	set @sum_of_3col=RIGHT(@sum_of_3col, LEN(@sum_of_3col)-1)
end

if @concatCopy=@sum_ofCopy
	set @diff=0
else
	set @diff=1
return @diff

end

select *,
	   [Cntry]+[City]+[ZipCode] as Concateneted, 
	   [dbo].[udf_ConcatCompare](Together, [Cntry]+[City]+[ZipCode]) as IsDiff,
	   case when  [dbo].[udf_ConcatCompare](Together, [Cntry]+[City]+[ZipCode])=0 then Other else Together end as ResCol
from ColumnCompareCaseConcat



select dd.DateKey, ff.DateKey, dd.CalendarYear, COUNT(*) from [dbo].[DimDate] as dd
left join [dbo].[FactFinance] as ff
on dd.DateKey=20110501
group by dd.DateKey, ff.DateKey, dd.CalendarYear


select dd.DateKey, ff.DateKey, dd.CalendarYear, COUNT(*) from [dbo].[DimDate] as dd
inner join [dbo].[FactFinance] as ff
on dd.DateKey=20110501
group by dd.DateKey, ff.DateKey, dd.CalendarYear
