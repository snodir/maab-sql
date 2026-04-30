/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [orderid]
      ,[custid]
      ,[empid]
      ,[orderdate]
      ,[requireddate]
      ,[shippeddate]
      ,[shipperid]
      ,[freight]
      ,[shipname]
      ,[shipaddress]
      ,[shipcity]
      ,[shipregion]
      ,[shippostalcode]
      ,[shipcountry]
  FROM [TSQL2012].[Sales].[Orders]
  --where shipaddress like '[0-9][0-9][0-9][0-9]%'					--(boshida 4 ta belgisi raqam bo'lib kelsin )
  --where shipname like '%[0-9]%'									--(raqam qatnashsin)
  --where shipcountry like '%l%' and shipaddress not like '%m%'		--(shipcountry da 'l' bo'lsin, lekin shipaddress da 'm' bo'lmasin )
  --where shipaddress like '%[.]%'									--(shipaddress da '.' bo'lsin)
  where shipaddress like '%[0-9]%[0-9]%[0-9]%[0-9]%'	 								--(faqat 4 ta raqam qatnashsin)
  