create database homework4
use homework4
go 
		--Formatting query output
ex1		select salesman_id, name, city, cast(100*commission as nvarchar(25))  +' %'  as comission from salesman
ex2		select '  For  ', ord_date, '  there are  ', count(ord_no) as num_orders, 'orders' from orders group by ord_date
ex3		select * from orders order by ord_no
ex4		select * from orders order by ord_date
ex5		select * from orders order by ord_date, purch_amt
ex6		select cust_name, city, grade from customer order by customer_id
ex7		select salesman_id, ord_date, purch_amt as maxx  from orders
		where purch_amt in(select max(purch_amt) from orders group by salesman_id, ord_date)
		order by salesman_id, purch_amt desc

		select orders.salesman_id, orders.ord_date, orders.purch_amt from orders inner join
		(select  salesman_id,  max(purch_amt) as maxx_salesamount from orders group by salesman_id) as A
		on A.maxx_salesamount=orders.purch_amt and A.salesman_id=orders.salesman_id
		order by salesman_id
ex8		select cust_name, city, grade from customer order by grade desc
ex9		select customer_id, count(ord_no) as cnt, max(purch_amt) as maxx from orders group by customer_id order by cnt desc
ex10	select ord_date, sum(purch_amt) as sum, 0.15*sum(purch_amt) as commission from orders group by ord_date order by ord_date


		--Aggregate Functions
ex1		select * into orders from [homework2].[dbo].orders 
		select sum(purch_amt) as sum from orders
ex2		select avg(purch_amt) as avg from orders
ex3		select count(distinct salesman_id) as count from orders
ex4		select count(distinct customer_id) as count from orders
ex5		select * into customer from homework2.dbo.customer
		select count(distinct cust_name) as count from customer where grade is not null
ex6		select max(purch_amt) as max from orders
ex7		select min(purch_amt) as min from orders
ex8		select city, max(grade) as maxgrade_per_city from customer group by city 
ex9		select customer_id, max(purch_amt) as max from orders group by customer_id
ex10	select customer_id, ord_date, max(purch_amt) as max from orders group by customer_id, ord_date
ex11	select salesman_id, max(purch_amt) as max from orders where ord_date='2012-08-17' group by salesman_id
ex12	select customer_id, ord_date, max(purch_amt) as max from orders group by customer_id, ord_date having max(purch_amt)>2000 
ex13	select customer_id, ord_date, max(purch_amt) as max from orders group by customer_id, ord_date having max(purch_amt)>=2000 and max(purch_amt)<=6000 
ex14	select customer_id, ord_date, max(purch_amt) as max from orders group by customer_id, ord_date having max(purch_amt)=2000 or max(purch_amt)=3000 or max(purch_amt)=5760 or max(purch_amt)=6000
ex15	select customer_id, max(purch_amt) as max from orders where customer_id between 3002 and 3007 group by customer_id
ex16	select customer_id, max(purch_amt) as max from orders where customer_id between 3002 and 3007 group by customer_id having max(purch_amt)>1000
ex17	select salesman_id, max(purch_amt) as max from orders where salesman_id between 5003 and 5008 group by salesman_id
ex18	select count(purch_amt) as count from orders where ord_date='2012-08-17' 
ex19	select * into salesman from homework2.dbo.salesman
		select * from salesman
		select count(salesman_id) as count from salesman  
ex20	select ord_date, salesman_id, count(purch_amt ) as count from orders group by ord_date, salesman_id	
ex21	select * into item_mast from homework2.dbo.item_mast
		select avg(PRO_PRICE) as average_price from item_mast
ex22	select count(PRO_ID) as [Number of products] from item_mast where PRO_PRICE>=350
ex23	select avg(pro_price) as [Average Price], PRO_COM as [Company ID] from item_mast group by PRO_COM 
ex24	create table emp_department(DPT_CODE int,  DPT_NAME nvarchar(25), DPT_ALLOTMENT int)
		insert into emp_department values(57, 'IT', 65000), (63, 'Finance', 15000), (47, 'HR', 240000), (27, 'RD', 55000), (89, 'QC', 75000)
		select sum(DPT_ALLOTMENT) as sum  from emp_department
ex25	select * into emp_details from homework2.dbo.emp_details
		select  EMP_DEPT, count(EMP_DEPT) as count from emp_details group by EMP_DEPT
