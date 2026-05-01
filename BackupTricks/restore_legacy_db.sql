--Restoring the different snapshots of the same database with different names

RESTORE FILELISTONLY 
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\LegacyDB_Backup_2025_08_26\LegacyDB_Backup_2025_08_26.bak';

RESTORE FILELISTONLY 
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\LegacyDB_Backup_2025_10_06\LegacyDB_Backup_2025_10_06.bak';


RESTORE DATABASE Legacy20250826
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\LegacyDB_Backup_2025_08_26\LegacyDB_Backup_2025_08_26.bak'
WITH MOVE 'Apollo'     TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\Legacy20250826.mdf',
     MOVE 'Apollo_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\Legacy20250826.ldf';

RESTORE DATABASE Legacy20251006
FROM DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\Backup\LegacyDB_Backup_2025_10_06\LegacyDB_Backup_2025_10_06.bak'
WITH MOVE 'Apollo'     TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\Legacy20251006.mdf',
     MOVE 'Apollo_log' TO 'C:\Program Files\Microsoft SQL Server\MSSQL17.MSSQLSERVER\MSSQL\DATA\Legacy20251006.ldf';
