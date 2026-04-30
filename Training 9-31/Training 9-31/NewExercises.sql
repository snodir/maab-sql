create database NewExercises
use NewExercises
go

[Forwarded from Arslonbek Abdullayev]
CREATE TABLE FruitCount
(
Name VARCHAR(20)
,Fruit VARCHAR(25)
)
GO
 
--Insert Data
INSERT INTO FruitCount(Name,Fruit) VALUES
('John'    ,'MANGO'),
('John'    ,'MANGO'),
('John'    ,'MANGO'),
('John'   ,'APPLE'),
('John'    ,'ORANGE'),
('John'    ,'LICHI'),
('John'    ,'LICHI'),
('John'    ,'LICHI'),
('Max'     ,'MANGO'),
('Max'    ,'MANGO'),
('Max'     ,'APPLE'),
('Max'     ,'ORANGE'),
('Max'     ,'LICHI'),
('Mike' ,'MANGO'),
('Mike' ,'MANGO'),
('Mike' ,'APPLE'),
('Mike' ,'APPLE'),
('Mike' ,'APPLE'),
('Mike' ,'ORANGE'),
('Mike' ,'LICHI'),
('Mayank'  ,'MANGO'),
('Mayank'  ,'MANGO'),
('Mayank'  ,'APPLE'),
('Mayank'  ,'APPLE'),
('Mayank'  ,'ORANGE'),
('Mayank'  ,'LICHI')

--First way--
select Name, 
	   count(case when Fruit= 'APPLE' then Fruit end) as Apple,
	   count(case when Fruit= 'LICHI' then Fruit end) as Lichi,
	   count(case when Fruit= 'MANGO' then Fruit end) as Mango,
	   count(case when Fruit= 'ORANGE' then Fruit end) as Orange
from FruitCount
group by Name

--second way--
select 
[Name], [Apple], [Lichi], [Mango], [Orange]
from
(select Name, Fruit from FruitCount) as PivSubquery
pivot(count(fruit) for fruit in([Apple], [Lichi], [Mango], [Orange])) as Piv
