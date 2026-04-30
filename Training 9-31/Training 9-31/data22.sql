create database data22

use data22

select 'Nodir' as name,
	   replace('Nodir', 'o', 'a') as repl_char,
	   replace('my name is Nodir', 'Nodir', 'John') as repl_word, 
	   stuff('my name is Nodir', charindex('Nodir', 'my name is Nodir'), 0, 'John, '),
	   replicate('Nodir', 3),
	   ltrim('              Nodir')

select 123456789,
	  format(123456789, '###-##-####')



