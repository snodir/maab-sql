create database data19

create table users(id int primary key identity (1,1), fname nvarchar(25),
lname nvarchar(25), username nvarchar(50), [password] nvarchar(25)), creation_date date default getdate())
insert into users(fname, lname, username, [password] ) values('John','Roberts','john1', 'johnn')
select * from users


create proc usp_signin @password nvarchar(25), @username nvarchar(25)
as
begin

if exists(select * from users where username=@username and password=@password)
	begin
		select 'You succesfully logged in'
	end
else
	begin
		select 'You entered wrong password or username '
	end
end

alter proc usp_signin @password nvarchar(25), @username nvarchar(25)
as
begin
	declare @doesuserexist int
	set @doesuserexist=(select COUNT(*) from users where username=@username )
	if @doesuserexist=1
		begin
			if exists(select * from users where username=@username and password=@password)
				begin
					select 'You succesfully logged in'
				end
			else
				begin
					select 'You entered wrong password or username '
				end
		end
	else
		begin
			select 'You entered wrong username'
		end
end

exec usp_signin 'johnn', 'john11'
------Registration---
alter proc usp_register 
@fname nvarchar(25), @lname nvarchar(25), 
@username nvarchar(25), @password nvarchar(25)
as
begin
	--create table users(id int primary key identity (1,1), fname nvarchar(25),
	--lname nvarchar(25), username nvarchar(50), [password] nvarchar(25))
	insert into users(fname, lname, username, [password]) values(@fname , @lname , 
	@username , @password )
	select * from users

end

exec usp_register 'Alex', 'Sagdullaev', 'alex', 'allex'

--stored procedure with output parametr
alter proc usp_getmebestpayer @payer nvarchar(25) output
as
begin
	set @payer=(SELECT TOP (1) 
				 sum([salary]) as highest
	
				 FROM [data16].[dbo].[employee] group by department order by sum([salary]) desc )
end

declare @receivepayerid int
exec usp_getmebestpayer @receivepayerid output
select * from [data16].[dbo].[employee] where id=@receivepayerid
go

create proc usp_getuser
as
begin
	select * from users
end

exec usp_getuser
select top(0) * into allusers from users
select* from allusers



