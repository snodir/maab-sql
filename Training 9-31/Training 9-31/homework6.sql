create database homework6
------Subqueries-----
ex1		select * into orders from homework3.dbo.orders
		select * into salesman from homework3.dbo.salesman
		select ord_no, purch_amt, 
		ord_date, customer_id,  salesman_id
		from orders 
		where salesman_id in(select salesman_id from salesman where salesman.name='Paul Adam')
ex2		select ord_no, purch_amt, ord_date, customer_id, salesman_id
		from orders 
		where orders.salesman_id in(select salesman_id from salesman  where salesman.city='London')
ex3		select ord_no, purch_amt, ord_date, customer_id, salesman_id
		from orders 
		where orders.salesman_id in(select salesman_id from orders  where orders.customer_id=3007)
ex4		select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders
		where purch_amt>(select avg(purch_amt) from orders where ord_date='2012-10-10' group by ord_date)
ex5		select ord_no, purch_amt, 
		ord_date, customer_id,  salesman_id
		from orders 
		where salesman_id in(select salesman_id from salesman where salesman.city='New York')
ex6		select * into customer from homework3.dbo.customer
		select commission from salesman 
		where salesman.salesman_id in (select salesman_id  from customer where city='Paris')
ex7		select c.cust_name from customer as c 
		where c.customer_id=(select salesman_id from salesman where salesman.name='Mc Lyon')-2001
ex8		select  grade, count(cust_name) as num_of_cust_with_certain_grade from customer 
		where grade>(select avg(grade) from customer where city='New York')
		group by grade
ex9		select ord_no, purch_amt, ord_date,  salesman_id from orders
		where salesman_id=(select top (1) salesman_id from salesman order by commission desc)

		select ord_no, purch_amt, ord_date,  salesman_id from orders
		where salesman_id=(select salesman_id from salesman 
						   where commission=(select max(commission) from salesman)
						  )		
ex10	select ord_no, purch_amt, ord_date,(select customer.cust_name from customer where orders.customer_id=customer.customer_id ) as cust_name 
		from orders 
		where ord_date='2012-08-17'

		select 	ord_no, purch_amt, ord_date, c.cust_name from orders as o inner join
		customer as c
		on o.customer_id=c.customer_id
		where o.ord_date='2012-08-17'
ex11	select salesman_id, name from salesman
		where salesman_id in
							(select salesman_id from customer group by salesman_id having count(customer.cust_name)>1)
ex12	select ord_no, purch_amt, ord_date, customer_id, salesman_id
		from orders 
		where purch_amt>(select avg(purch_amt) from orders)
ex13	select ord_no, purch_amt, ord_date, customer_id, salesman_id
		from orders 
		where purch_amt>=(select avg(purch_amt) from orders)
ex14	;with A as (select orders.ord_date, sum(purch_amt) as total_purchamt_in_one_day from orders 
		group by ord_date) 
		select A.ord_date, A.total_purchamt_in_one_day from A
		where total_purchamt_in_one_day >((select max(purch_amt) from orders  )+1000)
ex15	select * from customer where exists(select * from customer where city='London')	
ex16	select salesman_id, name, city, commission from salesman
		where salesman_id in (select salesman_id from customer group by salesman_id having count(distinct customer_id)>1)
ex17	select salesman_id, name, city, commission from salesman
		where salesman_id in (select salesman_id from customer group by salesman_id having count(distinct customer_id)=1)
ex18	select salesman_id, name, city, commission from salesman
		where 
		salesman_id =any(
			  select salesman_id from orders where 
										   customer_id in
											  (select distinct orders.customer_id from orders group by customer_id having count(ord_no)>1)
					  )
ex19	select salesman_id, name, city, commission from salesman
		where salesman_id =any(select salesman_id from customer)
			  and
			  city in (select city from customer)

		select salesman_id, name, city, commission from salesman
		where exists(select salesman_id from customer where customer.salesman_id=salesman.salesman_id)
			  and
			  exists(select city from customer where customer.city=salesman.city)

ex20	select salesman_id, name, city, commission from salesman
		where city in (select city from customer)
ex21	select salesman_id, name,  city, commission  from salesman as s
		where exists( select cust_name from customer as c  
								where  c.cust_name>s.name
					)
if 'b'>'a'
  begin
	print 'true'
  end
else
  begin
	print 'false' 
  end
ex22	select customer_id, cust_name, city, grade, salesman_id from customer
		where grade>any(select grade from customer where city<'New York')
ex23	select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders
		where purch_amt>any(select purch_amt  from orders where ord_date='2012-09-10'
		)
ex24	select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders
		where purch_amt<any(select purch_amt from orders 
							where customer_id in
											(select customer_id from customer where city='London')
							)
ex25	select ord_no, purch_amt, ord_date, customer_id, salesman_id from orders
		where purch_amt<any(select max(purch_amt) from orders 
							where customer_id in
											(select customer_id from customer where city='London')
							)
ex26	select customer_id, cust_name, city, grade, salesman_id from customer
		where grade>any(select grade from customer where city='New York')
ex27	select s.name, s.city, 
		(select sum(purch_amt) from orders as o 
		where o.salesman_id=s.salesman_id group by o.salesman_id) as [total order amount] 
		from salesman as s where s.city in(select city from customer)
ex28	select customer_id, cust_name, city, grade, salesman_id from customer
		where grade not in(select grade from customer where city='London' and grade is not null)

		select customer_id, cust_name, city, grade, salesman_id from customer
		where grade<>any(select grade from customer where city='London' and grade is not null)
ex29	select customer_id, cust_name, city, grade, salesman_id from customer
		where grade not in(select grade from customer where city='Paris' and grade is not null)
ex30	select customer_id, cust_name, city, grade, salesman_id from customer
		where  grade not in(select grade from customer where city='Dallas' and grade is not null)
ex31	select * into item_mast from homework5.dbo.item_mast
		select * into company_mast from homework5.dbo.company_mast
		select COM_NAME,
		(select avg(PRO_PRICE) from item_mast i where i.PRO_COM=c.COM_ID group by PRO_COM) as average_price
		from company_mast c
ex32	;with C as (select COM_NAME,
									(select avg(PRO_PRICE) from item_mast i 
									where i.PRO_COM=c.COM_ID group by PRO_COM
									) as average_price
		from company_mast c)
		select * from C  
		where C.average_price>=350
ex33	select PRO_NAME, pro_price, c.COM_NAME 
		from item_mast i, company_mast c
		where i.PRO_COM=c.COM_ID and
		i.PRO_PRICE in(select max(i.PRO_PRICE) from item_mast i where i.PRO_COM=c.COM_ID)
ex34	select * into emp_details from homework5.dbo.emp_details
		select emp_idno, emp_fname, emp_lname, emp_dept from emp_details 
		where EMP_LNAME='Gabriel' or EMP_LNAME='Dosio'
ex35	select * into emp_department from homework5.dbo.emp_department
		select emp_idno, emp_fname, emp_lname, emp_dept from emp_details 
		where EMP_DEPT in (89, 63)
ex36	select emp_fname, emp_lname from emp_details 
		where exists(select * from emp_department where DPT_CODE=EMP_DEPT and DPT_ALLOTMENT>50000)

		select emp_fname, emp_lname from emp_details 
		where emp_details.EMP_DEPT in (select DPT_CODE from emp_department 
									where DPT_ALLOTMENT>50000)
ex37	select dpt_code, dpt_name, dpt_allotment from emp_department
		where DPT_ALLOTMENT>(select avg(DPT_ALLOTMENT) from emp_department)
ex38	select EMP_FNAME, EMP_LNAME from emp_details emp
		where exists(select * from emp_department dep 
						where emp.EMP_DEPT=dep.DPT_CODE and dep.DPT_ALLOTMENT in
						(select max(DPT_ALLOTMENT) 
						from 
							(select top (2) with ties DPT_ALLOTMENT from emp_department order by DPT_ALLOTMENT) 
						as dep)
					)
ex39	select DPT_NAME from emp_department as dep 
		where exists(select * from emp_details as emp where emp.EMP_DEPT=dep.DPT_CODE 
					group by EMP_DEPT having count(EMP_IDNO)>2)

