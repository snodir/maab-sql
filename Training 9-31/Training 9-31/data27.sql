create database data27

use data27
--first way--
declare @inptext nvarchar(50)='br15veev45gw'
;with A as
(
	select 1 as n, SUBSTRING(@inptext,1,1) as letters
	union all
	select A.n+1, SUBSTRING(@inptext, A.n+1, 1) from A where A.n<len(@inptext)
)
,B as
(
select n,
	   letters,
	   ROW_NUMBER() over(order by n) as rwasc,
	   ROW_NUMBER() over(order by n desc) as rwdesc
from A 
where A.letters not like '[0-9]'
)
select A.n, A.letters, isnull(cont.letters, A.letters) from A left outer join
(select x.n,  y.letters from B as x inner join B as y on x.rwasc=y.rwdesc) as cont
on A.n=cont.n

--second way--
	declare @inptext nvarchar(50)='br15vloev45gw'
	;with A as
	(
		select 1 as n, SUBSTRING(@inptext,1,1) as letters
		union all
		select A.n+1, SUBSTRING(@inptext, A.n+1, 1) from A where A.n<len(@inptext)
	)
	, B as
	(
	select n,
		   letters,
		   abs(ROW_NUMBER() over(order by n)-
		   ROW_NUMBER() over(order by n desc)) as grp
	from A 
	where A.letters not like '[0-9]'
	)
	, C as
	(
	select x.n, (select y.letters from B as y where x.grp=y.grp and x.n<>y.n) as l from B as x 
	)
	select isnull(C.l , A.letters) from A left join C on C.n=A.n for xml path('')

--third way
	declare @input nvarchar(100)='s4s91a', @output nvarchar(100)='', @id int=1
	declare @number table(id int, letter nvarchar(100))
	while len(@input)>=@id
		begin	
			if SUBSTRING(@input, @id, 1) like '[0-9]'
				begin
					insert into @number values(@id, substring(@input, @id,1))
				end
			else
				begin
					set @output=@output+SUBSTRING(@input, @id,1)
				end
			set @id=@id+1
		end
	set @output=REVERSE(@output)+REPLICATE(' ', len(@input)-len(@output))
	--select @output
	set @id=(select min(id) from @number)
	while (select count(*) from @number where id>=@id)>0
		begin 
			set @output=stuff(@output, @id, 0, (select letter from @number where id=@id))
			set @id=(select min(id) from @number where id>@id)
			print @id
		end 
	select @output

--which letter in string first repeats
declare @input nvarchar(50)='adjhajka'
;with x as
(
select 1 as n, SUBSTRING(@input, 1, 1) as letter
union all
select x.n+1, SUBSTRING(@input, x.n+1,1) from x where x.n<len(@input)
)
select n, letter, (select ''+b.letter from x as b where b.n<a.n for xml path(''))
from x as a 
where charindex(letter, (select ''+b.letter from x as b where b.n<a.n for xml path('')))>0 


























