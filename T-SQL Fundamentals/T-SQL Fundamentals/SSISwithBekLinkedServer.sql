create database SSISwithBek
use SSISwithBek
go

select * from OracleEmpJoinDep
truncate table OracleEmpJoinDep


insert into OracleEmpJoinDep
(employee_id, 
first_name, 
last_name, 
email, 
phone_number, 
hire_date, 
job_id, 
salary, 
commission_pct, 
manager_id, 
department_id, 
department_name)
select * 
from openquery(ORACLE,'select e.*, d.department_name from employees e inner join departments d on e.department_id=d.department_id')

select * into SSISwithBek.dbo.CustomerAllAtOnceThroughPowerShell from [ssis5].[dbo].custAll_at_once_from_Flat_ForEachFileEnumarator
select * from CustomerAllAtOnceThroughPowerShell
truncate table CustomerAllAtOnceThroughPowerShell

c:\Users\NODIR\Flat_subsource>for /r %i in (*) do bcp 
SSISwithBek.dbo.CustomerAllAtOnceThroughPowerShell in %i -T -c -t, -r\n -SDESKTOP-20RAN2E


select * into workers from CrossApply.dbo.workers
select * into workhours from CrossApply.dbo.workhours
SElect * from workers
select * from workhours

select * from Arbeiter
select * from ErrorLogFileFromFlat

truncate table Arbeiter
truncate table ErrorLogFileFromFlat

execute msdb.dbo.sp_send_dbmail
@profile_name='databaseemail',
@recipients='nodirbeksadullayev512@gmail.com',
@body='Checking if it works',
@subject='Message from SQL database'

execute msdb.dbo.sp_send_dbmail
@profile_name='databaseemail',
@recipients='nodirbeksadullayev512@gmail.com',
@body='<!DOCTYPE html>
<html>
<head>
<style>
table, th, td {
  border: 1px solid black;
  border-collapse: collapse;
}
th, td {
  padding: 5px;
  text-align: left;
}
</style>
</head>
<body>

<h2>Table Caption</h2>
<p>To add a caption to a table, use the caption tag.</p>

<table style="width:100%">
  <caption>Monthly savings</caption>
  <tr>
    <th>Month</th>
    <th>Savings</th>
  </tr>
  <tr>
    <td>January</td>
    <td>$100</td>
  </tr>
  <tr>
    <td>February</td>
    <td>$50</td>
  </tr>
</table>

</body>
</html>',
@subject='Message from SQL database'
 
