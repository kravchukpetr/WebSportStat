CREATE DATABASE SportStat
ON (FILENAME='/var/opt/mssql/data/SportStat.mdf')
LOG ON (FILENAME='/var/opt/mssql/data/SportStat_log.ldf')
FOR ATTACH;


ALTER DATABASE SportStat
SET SINGLE_USER
--This rolls back all uncommitted transactions in the db.
WITH ROLLBACK IMMEDIATE
GO


RESTORE DATABASE SportStat
FROM DISK = '/var/opt/mssql/backup/SportStat.bak'
--WITH REPLACE
WITH MOVE 'SportStat' TO '/var/opt/mssql/data/SportStat.mdf',
MOVE 'SportStat_Log' TO '/var/opt/mssql/data/SportStat_Log.ldf'
GO

ALTER DATABASE SportStat
SET MULTI_USER