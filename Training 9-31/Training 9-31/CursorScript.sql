/****** Script for SelectTopNRows command from SSMS  ******/
DECLARE 
    @DepID smallint, 
    @Name varchar(50)

DECLARE cursor_dept CURSOR
FOR SELECT 
        DepartmentID, 
        [Name]
    FROM 
        [HumanResources].[Department];

OPEN cursor_dept;

FETCH NEXT FROM cursor_dept INTO 
    @DepID, 
    @Name;
WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @depID 
		print @Name --@product_name + CAST(@list_price AS varchar);
        FETCH NEXT FROM cursor_dept INTO 
            @DepID, 
            @name;
    END;

CLOSE cursor_dept;

DEALLOCATE cursor_dept;

