create database data10

create table family(id int, members nvarchar(15), parentid int)
insert into family values(1, 'grandfather', null), (2, 'father', 1),(3, 'uncle', 1),(4, 'me', 2), (5, 'my son', 4), (6, 'cousine', 3)
select * from family
select * from family

select parent.members as parentname, isnull(child.members, 'unknown') as childname, 
isnull(grandchild.members, 'unknown') as grandchildname,
isnull(grandgrandchild.members, 'unknown') as grandgrandchildname
from family as parent left join family as child on child.parentid=parent.id
					  left join family as grandchild on grandchild.parentid=child.id
					  left join family as grandgrandchild on grandgrandchild.parentid=grandchild.id 
