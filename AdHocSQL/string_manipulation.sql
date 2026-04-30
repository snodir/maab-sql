declare @str as varchar(100) = 'nodir';
declare @index as int = 1;
declare @subst as varchar(100) = '';


while (select @index) <= (select len(@str))
begin
    if @index % 3 = 1 and @index <> 1 and @index <> len(@str)
        BEGIN
        set @subst= @subst + '_' + substring(@str, @index, 1)
        END
    ELSE
        begin 
        set @subst= @subst + substring(@str, @index, 1)
        end 

    set @index= @index + 1
end
select @subst;
select @str;

