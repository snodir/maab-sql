create table DuplRowsJoinPrb1
(ID int,
 Letter varchar(10)
)

create table DuplRowsJoinPrb2
(ID int,
 Letter varchar(10)
)

create table DuplRowsJoinPrb3
(ID int,
 Letter varchar(10)
)

insert into dbo.DuplRowsJoinPrb1 values(1,'a'),(1,'b'),(1,'c'),(1,'d')
insert into dbo.DuplRowsJoinPrb2 values(1,'e'),(1,'f'),(1,'g')
insert into dbo.DuplRowsJoinPrb3 values(1,'h'),(1,'i')

select P1.*, P2.*, P3.* 
from dbo.DuplRowsJoinPrb1 as P1
inner join dbo.DuplRowsJoinPrb2 as P2 on P2.ID=P1.ID
inner join dbo.DuplRowsJoinPrb3 as P3 on P3.ID=P2.ID


