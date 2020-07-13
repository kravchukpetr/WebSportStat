use sportstat;
SET SQL_SAFE_UPDATES = 0;
select count(*) from DimTeam;
select count(*) from FactResult;
select * from FactResult where 1=1 LIMIT 10;
select * from FactResult where IDFactResult = 14946;
delete from FactResult;
truncate table FactResult;