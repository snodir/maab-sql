create database homework3
--Boolean and Relational Operators
ex1		select * into customer from homework2.dbo.customer
		select customer_id, cust_name, city, grade, salesman_id from customer where grade>100
ex2		select customer_id, cust_name, city, grade, salesman_id from customer where grade>100 and city='New York'
ex3		select customer_id, cust_name, city, grade, salesman_id from customer where grade>100 or city='New York'
ex4		select customer_id, cust_name, city, grade, salesman_id from customer where grade<=100 or city='New York'
ex5		select customer_id, cust_name, city, grade, salesman_id from customer where (grade<=100 and city<>'New York')
ex6		select * into orders from homework2.dbo.orders
		select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders where not(ord_date='2012-09-10' and salesman_id>5005) 
		union
		select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders where purch_amt>1000
ex7		select * into salesman from homework2.dbo.salesman
		select salesman_id, name, city, commission from salesman where commission between 0.10 and 0.12
ex8		select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders where (purch_amt<200) or (not (ord_date>='2012-02-10' and customer_id<3009))
ex9		select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders where not(ord_date='2012-08-17' or  (customer_id>3005 and purch_amt<1000))
ex10	select ord_no, purch_amt, purch_amt/6000*100 as [achieved, % ], 100-purch_amt/6000*100 as [unachieved, %]  from orders where purch_amt>3000
ex11	select * into emp_details from homework2.dbo.emp_details 
		select emp_idno, emp_fname, emp_lname, emp_dept from emp_details where emp_lname like N'Dosni' or emp_lname like N'Mardy'
ex12	select emp_idno, emp_fname, emp_lname, emp_dept from emp_details where emp_dept=47 or emp_dept=63
--Wildcard and Special Operators
ex1		select salesman_id, name, city, commission from salesman where city='Paris' or city='Rome'
ex2		select salesman_id, name, city, commission from salesman where city='Paris' or city='Rome'
ex3		select salesman_id, name, city, commission from salesman where not(city='Paris' or city='Rome')
ex4		select customer_id, cust_name, city, grade, salesman_id from customer where customer_id in (3007, 3008, 3009)
ex5		select salesman_id, name, city, commission from salesman where commission between 0.12 and 0.14
ex6		select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders where purch_amt between 400 and 500
ex7		select salesman_id, name, city, commission from salesman where name like N'[BCDEFGHIJK]%' 
ex8		select salesman_id, name, city, commission from salesman where not (name like N'[B-K]%') 
ex9		select customer_id, cust_name, city, grade, salesman_id from customer where cust_name like N'B%'
ex10	select customer_id, cust_name, city, grade, salesman_id from customer where cust_name like N'%n'
ex11	select salesman_id, name, city, commission from salesman where name like N'N__l%' 
ex12	create table testtable(col1 nvarchar(30))
		insert into testtable values('A001/DJ-402\44_/100/2015'),('A001_\DJ-402\44_/100/2015'),('A001_DJ-402-2014-2015'),('A002_DJ-401-2014-2015'),
									('A001/DJ_401'),('A001/DJ_402\44'),('A001/DJ_402\44\2015'),('A001/DJ-402%45\2015/200'),('A001/DJ_402\45\2015%100'),
									('A001/DJ_402%45\2015/300'),('A001/DJ-402\44')
		select col1 from testtable where col1 like N'%[_]%'
ex13	select col1 from testtable where col1 not like N'%[_]%'
ex14	select col1 from testtable where col1 like N'%[/]%'
ex15	select col1 from testtable where col1 not like N'%[/]%'
ex16	select col1 from testtable where col1 like N'%/_//%' escape '/'
ex17	select col1 from testtable where col1 not like N'%/_//%' escape '/'
ex18	select col1 from testtable where col1 like N'%[%]%' 
ex19	select col1 from testtable where col1 not like N'%@%%'   escape '@'
ex20	select customer_id, cust_name, city, grade, salesman_id from customer where grade is null
ex21	select customer_id, cust_name, city, grade, salesman_id from customer where grade is not null
ex22	select emp_idno, emp_fname, emp_lname, emp_dept from emp_details where emp_lname like N'D%'



