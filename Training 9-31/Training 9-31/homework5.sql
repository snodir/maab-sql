create database homework5
use homework5
go
--Joins
ex1		select * into salesman from homework2.dbo.salesman
		select * into customer from homework2.dbo.customer
		select s.name, s.city, c.city, c.cust_name from salesman as s 
		full outer join customer as c on s.city=c.city
		where not ((c.city is null and c.cust_name is null) or (s.name is null and s.city is null))
ex2		select * into orders from homework2.dbo.orders
		select o.ord_no, o.purch_amt, c.cust_name, c.city from orders as o inner join 
															 customer as c on o.salesman_id=c.salesman_id
		where o.purch_amt between 500 and 2000
ex3		select c.cust_name, c.city, s.name, s.commission from salesman as s 
		full outer join customer as c on s.salesman_id=c.salesman_id
ex4		select c.cust_name, c.city, s.name, s.commission from salesman as s 
		full outer join customer as c on s.salesman_id=c.salesman_id
		where commission>0.12
ex5		select c.cust_name, c.city as customer_city, s.name as salesman_name, s.city as salesman_city, s.commission  from salesman as s 
		inner join customer as c on s.city<>c.city and s.salesman_id=c.salesman_id where commission>0.12
		
ex6		select o.ord_no, o.ord_date, o.purch_amt, c.cust_name as [Customer Name], c.grade, s.name as Salesman, s.commission
		from orders as o
		inner join customer as c on o.customer_id=c.customer_id
		inner join salesman as s on c.salesman_id=s.salesman_id

		select o.ord_no, o.ord_date, o.purch_amt, c.cust_name as [Customer Name], c.grade, s.name as Salesman, s.commission
		from orders as o
		inner join customer as c on o.salesman_id=c.salesman_id
		inner join salesman as s on c.salesman_id=s.salesman_id;
ex7		select * from orders 
		natural join customer 
		natural join salesman;
ex8		select cust_name, customer.city as [customer city], customer.grade, salesman.name Salesman, salesman.city from customer
		inner join salesman on customer.salesman_id=salesman.salesman_id
		order by customer.customer_id
ex9		select cust_name, customer.city as [customer city], customer.grade, salesman.name Salesman, salesman.city from customer
		inner join salesman on customer.salesman_id=salesman.salesman_id where customer.grade<300
		order by customer.customer_id
ex10	select c.cust_name, c.city, o.ord_no, o.ord_date, o.purch_amt from orders as o
		inner join customer as c on o.customer_id=c.customer_id order by o.ord_date, c.cust_name
		

ex11	select c.cust_name as [customer name], c.city, o.ord_no as [order number], o.ord_date as [order date], 
		o.purch_amt as [order amount], s.name as [salesman name], commission
		from customer as c left outer join orders as o on c.customer_id=o.customer_id
		left outer join salesman as s on s.salesman_id=c.salesman_id
ex12	select s.name as salesman_name, count(c.cust_name) as [number of clients] from salesman as s 
		inner join customer as c on s.salesman_id=c.salesman_id group by s.name order by s.name
ex13	select s.name as [salespersons], c.cust_name as [customer name], c.city, c.grade, o.ord_no as [order number], 
		o.ord_date as date, o.purch_amt as amount
		from salesman as s left outer join customer as c on s.salesman_id=c.salesman_id
		inner join orders as o on o.customer_id=c.customer_id order by s.name
ex14	select s.name as salesman_name, count(c.cust_name) as [number of clients] from salesman as s 
		left outer join customer as c on s.salesman_id=c.salesman_id 
		left outer join orders as o on o.customer_id=c.customer_id
		where o.purch_amt>2000 and c.grade is not null group by s.name order by s.name
ex15	select c.cust_name as [customer name], c.city, o.ord_no as [order no], o.ord_date as [order date],
		o.purch_amt as [purchase amount] from customer as c 
		left outer join orders as o on c.customer_id=o.customer_id
ex16	select c.cust_name as [customer name], c.city, o.ord_no as [order no], o.ord_date as [order date],
		o.purch_amt as [purchase amount] from orders as o
		full outer join customer as c  on c.customer_id=o.customer_id 
		where c.grade is not null
ex17	select s.*, c.* from customer as c cross join salesman as s
ex18	select s.*, c.* from customer as c cross join salesman as s where grade is not null
ex19	select s.*, c.* from customer as c cross join salesman as s where s.city<>c.city
ex21	select * into item_mast from homework4.dbo.item_mast
		create table company_mast(COM_ID int, COM_NAME nvarchar(25))
		insert into company_mast values(11, 'Samsung'),(12, 'iBall'),(13, 'Epsion'),(14, 'Zebronics'),(15, 'Asus'),(16, 'Frontech')
		select i.*, c.* from item_mast as i inner join company_mast as c on i.PRO_COM=c.COM_ID
ex22	select i.PRO_NAME, i.PRO_PRICE, c.COM_NAME from item_mast as i left outer join company_mast as c on i.PRO_COM=c.COM_ID
ex23	select c.COM_NAME, avg(i.PRO_PRICE) as average_price from item_mast as i left outer join company_mast as c on i.PRO_COM=c.COM_ID 
		group by c.COM_NAME 
ex24	select c.COM_NAME, avg(i.PRO_PRICE) as average_price from item_mast as i left outer join company_mast as c on i.PRO_COM=c.COM_ID 
		group by c.COM_NAME having avg(i.PRO_PRICE)>=350
ex25	select c.COM_NAME, i.PRO_NAME, max(i.PRO_PRICE) as most_expensive_pro_price from item_mast as i left outer join company_mast as c on i.PRO_COM=c.COM_ID 
		group by c.COM_NAME, i.PRO_NAME 
ex26	select * into emp_department from homework4.dbo.emp_department
		select * into emp_details from homework4.dbo.emp_details
		select * from emp_details as det left outer join emp_department as dep on det.EMP_DEPT=dep.DPT_CODE
ex27	select det.EMP_FNAME, det.EMP_LNAME, dep.DPT_NAME, dep.DPT_ALLOTMENT
		from emp_details as det left outer join emp_department as dep on det.EMP_DEPT=dep.DPT_CODE
ex28	select det.EMP_FNAME, det.EMP_LNAME, dep.DPT_NAME, dep.DPT_ALLOTMENT
		from emp_details as det left outer join emp_department as dep on det.EMP_DEPT=dep.DPT_CODE
		where dep.DPT_ALLOTMENT>50000
ex29	select dep.DPT_NAME, count(distinct det.EMP_FNAME) num_of_emp
		from emp_details as det left outer join emp_department as dep on det.EMP_DEPT=dep.DPT_CODE
		group by dep.DPT_NAME having count(distinct det.EMP_FNAME)>2
		select count(grade) from customer

		------Queries on multiple tables----
ex1		select c.cust_name, s.name as salesman_name, C.city from customer as C inner join salesman as s on c.city=s.city 
ex2		select c.cust_name, s.name as salesman_name, C.city from customer as C inner join salesman as s on c.salesman_id=s.salesman_id 
ex3		select o.ord_no, c.cust_name, o.customer_id , o.salesman_id
		from orders as o left outer join customer as c 
		on o.customer_id=c.customer_id
		inner join salesman as s
		on s.city<>c.city and s.salesman_id=c.salesman_id
ex4		select o.ord_no, c.cust_name from orders as o inner join customer as c 
		on o.customer_id=c.customer_id
ex5		select c.cust_name, c.grade from customer as c inner join salesman as s
		on s.salesman_id=c.salesman_id
		inner join orders as o 
		on o.customer_id=c.customer_id
		where c.grade is not null
ex6		select cust_name AS "Customer", c.city AS "City", s.name as Salesman, s.commission from customer as c inner join
		salesman as s 
		on s.salesman_id=c.salesman_id
		where s.commission between 0.12 and 0.14
ex7		select o.ord_no, c.cust_name, 100*s.commission as [Commission%], o.purch_amt as Commission from orders as o left join
		customer as c 
		on o.customer_id=c.customer_id
		left join salesman as s
		on s.salesman_id=c.salesman_id
		where c.grade>=200
ex8		select o.customer_id, c.cust_name, c.city, c.grade, c.salesman_id, o.ord_no, o.purch_amt, o.ord_date, c.customer_id, s.salesman_id
		from orders as o inner join customer as c
		on o.customer_id=c.customer_id
		inner join salesman as s
		on s.salesman_id=c.salesman_id
		where o.ord_date='2012-10-05'

		
