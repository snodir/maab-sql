create database ssis4
go
use ssis4
go

create table customer(name varchar(25), city varchar(25))
select name, city from customer
truncate table customer
DELETE from customer where name='James'

bulk insert  [ssis4].[dbo].[customer]
from 'C:\Users\99894\Documents\SQL Server Management Studio\src\customer2.txt'
with
(
	firstrow=2,
	fieldterminator=',',
	rowterminator='\n'	
)
truncate table customer

CREATE TABLE [dbo].[Transaction_Tbl](
 [CustID] [int] ,
 [TranID] [int] ,
 [TranAmt] [float] ,
 [TranDate] [date] 
) 

INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1001, 20001, 10000, CAST('2020-04-25' AS Date))
INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1001, 20002, 15000, CAST('2020-04-25' AS Date))
INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1001, 20003, 80000, CAST('2020-04-25' AS Date))
INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1001, 20004, 20000, CAST('2020-04-25' AS Date))
INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1002, 30001, 7000, CAST('2020-04-25' AS Date))
INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1002, 30002, 15000, CAST('2020-04-25' AS Date))
INSERT [dbo].[Transaction_Tbl] ([CustID], [TranID], [TranAmt], [TranDate]) VALUES (1002, 30003, 22000, CAST('2020-04-25' AS Date))

select CustID, 
	   TranID, 
	   TranAmt, 
	   max(TranAmt) over(partition by CustID) as MaxAmt,
	   cast(TranAmt as float)/(max(TranAmt) over(partition by CustID)) as Ratio,
	   TranDate
from Transaction_Tbl

