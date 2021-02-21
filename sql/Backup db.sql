BACKUP DATABASE SportStat 
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\SportStat.bak'

RESTORE FILELISTONLY FROM 
DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Backup\SportStat.bak'