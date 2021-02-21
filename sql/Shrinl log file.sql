ALTER DATABASE SportStat  
SET RECOVERY SIMPLE;  
GO  
-- Shrink the truncated log file to 1 MB.  
DBCC SHRINKFILE (SportStat_Log, 100);  
GO  
-- Reset the database recovery model.  
ALTER DATABASE SportStat  
SET RECOVERY FULL;  