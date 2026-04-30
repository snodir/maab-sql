
	-- QUESTION 1 --

DROP TABLE IF EXISTS NumRunTotal
GO

CREATE TABLE NumRunTotal
(
	Numbers INT
)
GO

INSERT INTO NumRunTotal
VALUES
(1), (2), (3), (4), (5)

--input
SELECT *
FROM NumRunTotal


--output
/*************************
Numbers     RunningTotal
----------- ------------
1           1
2           3
3           6
4           10
5           15
*************************/


-----------------------------------------------------

	-- QUESTION 2 --

DROP TABLE IF EXISTS RangeValues
GO

CREATE TABLE RangeValues
(
Vals INT
)
GO
 
INSERT INTO RangeValues(Vals) VALUES
(125),
(350),
(270),
(140)
GO

--input
SELECT *
FROM RangeValues

--output
/*************************
LowRange    UpperRange
----------- -----------
0           125
125         140
140         270
270         350
350         NULL
*************************/


-----------------------------------------------------

	-- QUESTION 3 --

DROP TABLE IF EXISTS EmpDetails

CREATE TABLE EmpDetails
(
	EmpID INT
	,Salary INT
)


INSERT INTO EmpDetails
VALUES
(1001, 2500)
,(1002, 1600)
,(1003, 3000)
,(1004, 1400)
,(1005, 1800)
,(1006, 900)
,(1007, 7000)
,(1008, 3900)
,(1009, 4500)
,(1010, 5000)
,(1011, 600)
,(1012, 1200)
,(1013, 3900)
,(1014, 1500)
,(1015, 2600)


--input
SELECT *
FROM EmpDetails


--output1 (3rd highest salary)
/*************************
EmpID       Salary
----------- -----------
1009        4500
*************************/


--output2 (4rd highest salary)
/*************************
EmpID       Salary
----------- -----------
1013        3900
1008        3900
*************************/


-----------------------------------------------------

	-- QUESTION 4 --

DROP TABLE IF EXISTS EmpDepDetails

CREATE TABLE EmpDepDetails
(
	EmpID INT
	,Department VARCHAR(20)
	,Salary INT
)


INSERT INTO EmpDepDetails
VALUES
(1001, 'HR', 2500)
,(1002, 'HR', 1600)
,(1003, 'HR', 3000)
,(1004, 'HR', 1400)
,(1005, 'HR', 2500)
,(1006, 'Sales', 900)
,(1007, 'Sales', 7000)
,(1008, 'Sales', 3900)
,(1009, 'Sales', 4500)
,(1010, 'Sales', 5000)
,(1011, 'Security', 600)
,(1012, 'Security', 1200)
,(1013, 'IT', 3900)
,(1014, 'IT', 1500)
,(1015, 'IT', 2600)


--input
SELECT *
FROM EmpDepDetails



--output (2nd highest salary for each department)
/*************************
EmpID       Department           Salary
----------- -------------------- -----------
1001        HR                   2500
1005        HR                   2500
1015        IT                   2600
1010        Sales                5000
1011        Security             600
*************************/


select * from 
(select EmpID, Department, Salary, DENSE_RANK() over(partition by department order by salary desc) as nTheHighestSal from EmpDepDetails) as DerTbl
--where DerTbl.nTheHighestSal=3

select * from 
(select EmpID, Department, Salary, RANK() over(partition by department order by salary desc) as nTheHighestSal from EmpDepDetails) as DerTbl
--where DerTbl.nTheHighestSal=3




select * from 
(select EmpID, Department, Salary, row_number() over(partition by department order by salary desc) as nTheHighestSal from EmpDepDetails) as DerTbl
--where DerTbl.nTheHighestSal=3
