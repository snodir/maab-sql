select * from dbo.DimDate as dd --776286
inner join dbo.FactProductInventory as fpi
on fpi.DateKey=dd.DateKey

select dd.DateKey, count(*) 
from dbo.DimDate as dd --776286
inner join dbo.FactProductInventory as fpi
on fpi.DateKey=dd.DateKey
group by dd.DateKey
order by dd.DateKey

select @@SERVERNAME;

select * from dbo.DimDate as dd --778657
left join dbo.FactProductInventory as fpi
on fpi.DateKey=dd.DateKey
where fpi.DateKey is null --2371

select * from dbo.DimDate




