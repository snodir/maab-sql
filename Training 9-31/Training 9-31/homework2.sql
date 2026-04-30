create database homework2

create table [dbo].[salesman](salesman_id int, name nvarchar(20), city nvarchar(20), commission decimal(5,3))
insert into [dbo].[salesman] values (5001,  'James Hoog', 'New York',  0.15), (5002,  'Nail Knite',  'Paris', 0.13),
                                    (5005,  'Pit Alex', 'London', 0.11), (5006, 'Mc Lyon',  'Paris', 0.14),
						       	    (5007,  'Paul Adam', 'Rome',  0.13),  (5003,  'Lauson Hen',  'San Jose', 0.12)
ex1		select * from salesman
ex2		select 'This is SQL exercise, practice and solution' as ex2
ex3		select 1 as col1, 2 as col2, 3 as col3
ex4		select 10+15 as sum
ex5		select (-20+10)/2 as expression
ex6		select name, commission from salesman

create table orders(ord_no int, purch_amt decimal(8,4), ord_date date, customer_id int,  salesman_id int)
insert into [homework2].[dbo].orders values(70001, 150.5, '2012-10-05',  3005, 5002), (70009, 270.65, '2012-09-10', 3001, 5005),
										  (70002, 65.26,  '2012-10-05', 3002, 5001), (70004, 110.5,  '2012-08-17', 3009, 5003),
										  (70007, 948.5,  '2012-09-10', 3005, 5002), (70005, 2400.6, '2012-07-27', 3007, 5001),
										  (70008, 5760,  '2012-09-10', 3002,  5001), (70010, 1983.43, '2012-10-10', 3004, 5006),
										  (70003, 2480.4, '2012-10-10', 3009, 5003), (70012, 250.45, '2012-06-27', 3008, 5002),
										  (70011, 75.29,  '2012-08-17', 3003, 5007), (70013, 3045.6, '2012-04-25', 3002, 5001)
ex7		select ord_date, ord_no, salesman_id, purch_amt from orders
ex8		select distinct salesman_id from orders
ex9		select name, city from salesman where city='Paris'

create table [homework2].[dbo].[customer](customer_id int, cust_name nvarchar(20), city nvarchar(20), grade int, salesman_id int) 
insert into [homework2].[dbo].[customer](customer_id, cust_name, city, grade, salesman_id)
							values(3002, 'Nick Rimando', 'New York', 100, 5001), (3007, 'Brad Davis', 'New York', 200, 5001),
							      (3005, 'Graham Zusi', 'California', 200, 5002), (3008, 'Julian Green', 'London', 300, 5002),
							      (3004, 'Fabian Johnson', 'Paris', 300, 5006), (3009, 'Geoff Cameron', 'Berlin', 100,  5003),
							      (3003, 'Jozy Altidor', 'Moscow', 200, 5007), (3001, 'Brad Guzan', 'London', null,   5005)
ex10	select customer_id, cust_name, city, grade, salesman_id from customer where grade=200
ex11	select ord_no, ord_date, purch_amt from orders where salesman_id=5001

--create table nobel_win(YEAR date, SUBJECT nvarchar(20), WINNER nvarchar(20), COUNTRY nvarchar(20), CATEGORY nvarchar(20))
drop table nobel_win
create table nobel_win(YEAR int, SUBJECT nvarchar(20), WINNER nvarchar(30), COUNTRY nvarchar(20), CATEGORY nvarchar(20))

insert into nobel_win values(1970, 'Physics', 'Hannes Alfven',  'Sweden',  'Scientist'), (1970, 'Physics',  'Louis Neel', 'France', 'Scientist'),
							(1970, 'Chemistry', 'Luis Federico Leloir', 'France', 'Scientist'),(1970, 'Physiology', 'Ulf von Euler', 'Sweden', 'Scientist'),
							(1970, 'Physiology', 'Bernard Katz', 'Germany', 'Scientist'),(1970, 'Literature', 'Aleksandr Solzhenitsyn', 'Russia', 'Linguist'),
							(1970, 'Economics', 'Paul Samuelson', 'USA', 'Economist'),(1970, 'Physiology', 'Julius Axelrod', 'USA', 'Scientist'),
							(1971, 'Physics', 'Dennis Gabor', 'Hungary', 'Scientist'),(1971, 'Chemistry', 'Gerhard Herzberg', 'Germany', 'Scientist'),
							(1971, 'Peace', 'Willy Brandt', 'Germany', 'Chancellor'),(1971, 'Literature', 'Pablo Neruda', 'Chile', 'Linguist'),
							(1971, 'Economics', 'Simon Kuznets', 'Russia', 'Economist'),(1978, 'Peace', 'Anwar al-Sadat', 'Egypt', 'President'),
							(1978, 'Peace', 'Menachem Begin', 'Israel', 'Prime Minister'),(1987, 'Chemistry', 'Donald J. Cram', 'USA', 'Scientist'),
							(1987, 'Chemistry', 'Jean-Marie Lehn', 'France', 'Scientist'),(1987, 'Physiology', 'Susumu Tonegawa', 'Japan', 'Scientist'),
							(1994, 'Economics', 'Reinhard Selten', 'Germany', 'Economist'),(1994, 'Peace', 'Yitzhak Rabin', 'Israel', 'Prime Minister'),
							(1987, 'Physics', 'Johannes Georg Bednorz', 'Germany', 'Scientist'),(1987, 'Literature', 'Joseph Brodsky', 'Russia', 'Linguist'),
							(1987, 'Economics', 'Robert Solow', 'USA', 'Economist'),(1994, 'Literature', 'Kenzaburo Oe', 'Japan', 'Linguist')
ex12	select year, subject, winner from nobel_win where year in (1970)
ex13	select winner from nobel_win where subject='Literature' and year=1971
ex14	select year, subject from nobel_win where winner='Dennis Gabor'
ex15	select winner from nobel_win where subject='Physics' and year>=1950
ex16    select year, subject, winner, country from nobel_win where subject='Chemistry' and (year>=1965 and year<=1975)
ex17	select * from nobel_win where (winner='Menachem Begin' and year>=1972) or (winner='Yitzhak Rabin' and year>=1972)
ex18	select year, subject, winner, country, category from nobel_win where winner like 'Louis%'
ex19	select year, subject, winner, country, category from nobel_win where subject='Physics' and year=1970
		union 
		select year, subject, winner, country, category from nobel_win where subject='Economics' and year=1971
ex20	select year, subject, winner, country, category from nobel_win where subject='Chemistry' or 
																			 SUBJECT='Physiology' or 
																			 subject='Literature' or 
																			 subject='Peace'
ex21	select year, subject, winner, country, category from nobel_win where (SUBJECT='Physiology' and year<=1971) or (subject='Peace' and year>=1974)
ex22	select year, subject, winner, country, category from nobel_win where winner='Johannes Georg Bednorz'
ex23	select year, subject, winner, country, category from nobel_win where subject not like 'P%'
ex24	select year, case when subject='Chemistry' or
					           subject='Economics' then 2 else 1 end, subject, winner, country, category from nobel_win
							   order by case when subject='Chemistry' or
												  subject='Economics' then 2 else 1 end asc, subject asc, winner asc

ex25	create table item_mast(PRO_ID int identity(101,1), PRO_NAME varchar(30), PRO_PRICE int, PRO_COM int)
		insert into item_mast values ('Mother Board', 3200.00, 15), ('Key Board', 450.00, 16), 
									 ('ZIP drive', 250.00, 14), ('Speaker', 550.00, 16),
									 ('Monitor', 5000.00, 11), ('DVD drive', 900.00, 12),
									 ('CD drive', 800.00, 12), ('Printer', 2600.00, 13),
									 ('Refill cartridge', 350.00, 13), ('Mouse', 250.00, 12)
		select pro_id, pro_name, pro_price, pro_com from item_mast where pro_price between 200 and 600
ex26	select avg(pro_price) as avg from item_mast where pro_com=16 group by pro_com
ex27	select avg(pro_price) as avg from item_mast where pro_com=16 group by pro_com
ex28	select pro_name, pro_price from item_mast order by pro_price desc
ex29	select pro_com as [company code], avg(pro_price) as [average price]  from item_mast group by pro_com
ex30	select pro_name, pro_price from item_mast where pro_price=(select min(pro_price) from item_mast)
	 or select top 1 with ties pro_name, pro_price from item_mast order by pro_price asc

ex31    create table emp_details (EMP_IDNO int, EMP_FNAME varchar(30), EMP_LNAME varchar(30), EMP_DEPT int)
		insert into emp_details values(127323, 'Michale', 'Robbin', 57), (526689, 'Carlos',  'Snares', 63),
									  (843795, 'Enric', 'Dosio', 57), (328717, 'Jhon', 'Snares', 63),
									  (444527, 'Joseph', 'Dosni', 47), (659831, 'Zanifer', 'Emily', 47),
									  (847674, 'Kuleswar', 'Sitaraman', 57), (748681, 'Henrey', 'Gabriel', 47),
									  (555935, 'Alex', 'Manuel', 57), (539569, 'George', 'Mardy', 27),
									  (733843, 'Mario', 'Saule', 63), (631548, 'Alan', 'Snappy', 27),
									  (839139, 'Maria',  'Foster', 57)
		select distinct emp_lname from emp_details 
ex32	select emp_idno, emp_fname, emp_lname, emp_dept from emp_details where emp_lname='Snares'
ex33	select emp_idno, emp_fname, emp_lname, emp_dept from emp_details where EMP_DEPT=57