create database data13
use data13
go

create table student(name nvarchar(25), grade int)
create table graderange(name nvarchar(25), minvalue int, maxvalue int)
insert into student values('Robert', 85), ('John', 68),('Steve', 90),
						  ('Rebecca', 82), ('Brandy', 77), ('Terry', 79),
						  ('Karen', 89),('Natali', 70),('Nuno', 93)
insert into graderange values('A', 90, 100),  ('B', 80, 89),('C', 70, 79),('D', 60, 69)

select name, grade from student
select graderange.name, graderange.minvalue, graderange.maxvalue from graderange

select  count(a.name) as number_of_students, b.name as gradename 
from student as a  inner join graderange as b 
on a.grade>=b.minvalue and a.grade<=b.maxvalue --a.grade between b.minvalue and b.maxvalue
group by b.name 

select student.name, 
(select graderange.name from graderange where student.grade between graderange.minvalue and graderange.maxvalue )as gradename 
from student

select graderange.name,
(select count(student.name) from student where student.grade between graderange.minvalue and graderange.maxvalue)
from graderange
group by graderange.name

create table recipe(foodname nvarchar(25), ingredient_id int, ingredient nvarchar(25))
create table frige(ingredient_id int, ingredient_name nvarchar(25))
insert into recipe values('Hotdog', 1, 'sausage'), ('Hotdog', 2, 'bread'),
						 ('Pilov', 3, 'rice'), ('Pilov', 4, 'carrot'), ('Pilov', 5, 'meat'),
						 ('Pizza', 6, 'flour'), ('Pizza', 7, 'tomato'), ('Pizza', 8, 'cheese')
insert into frige values(1, 'sausage'), (2, 'bread'),(4, 'carrot'),(7, 'tomato'),(8, 'cheese')
--truncate table frige
select * from recipe
select * from frige

select food.foodname, food.ingredient, ingr.ingredient_name from recipe as food 
				 left join frige as ingr on food.ingredient=ingr.ingredient_name

select food.foodname from recipe as food 
				 left join frige as ingr on food.ingredient=ingr.ingredient_name 
				 where ingr.ingredient_name is not null
	    except
select food.foodname from recipe as food 
				 left join frige as ingr on food.ingredient=ingr.ingredient_name 
				 where ingr.ingredient_name is null




