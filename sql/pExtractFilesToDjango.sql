USE [SportStat]
GO
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[pExtractFilesToDjango]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[pExtractFilesToDjango]
GO

create procedure pExtractFilesToDjango
@IsExtractBig int = 1,
@IsExtractSmall int = 1,
@IsExtractNation int = 1,
@DirStr VARCHAR(500) = 'C:\Dev\Python\WebSportStat\sportstat\files\media\'
as
BEGIN

DECLARE @SQLIMG VARCHAR(MAX),
    @IMG_PATH VARBINARY(MAX),
    @FILENAME VARCHAR(MAX),
    @ObjectToken INT

if @IsExtractBig = 1
begin
DECLARE IMGPATH_SMALL CURSOR FAST_FORWARD FOR 
        SELECT ImgBig, @DirStr + 'team_' + cast(IDTeam as varchar) + '_big.png' as FNAME 
		from DimTeam where ImgBig is not null

OPEN IMGPATH_SMALL 

FETCH NEXT FROM IMGPATH_SMALL INTO @IMG_PATH, @FILENAME

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @FILENAME

        EXEC sp_OACreate 'ADODB.Stream', @ObjectToken OUTPUT
        EXEC sp_OASetProperty @ObjectToken, 'Type', 1
        EXEC sp_OAMethod @ObjectToken, 'Open'
        EXEC sp_OAMethod @ObjectToken, 'Write', NULL, @IMG_PATH
        EXEC sp_OAMethod @ObjectToken, 'SaveToFile', NULL, @FILENAME, 2
        EXEC sp_OAMethod @ObjectToken, 'Close'
        EXEC sp_OADestroy @ObjectToken

        FETCH NEXT FROM IMGPATH_SMALL INTO @IMG_PATH, @FILENAME 
    END 

CLOSE IMGPATH_SMALL
DEALLOCATE IMGPATH_SMALL

INSERT INTO FactLogs(Dt, OperType, OperStatus)
SELECT getdate(), 'Выгрузка файлов команд BigImg', 3

end

if @IsExtractSmall = 1
begin
DECLARE IMGPATH_SMALL CURSOR FAST_FORWARD FOR 
        SELECT ImgSmall, @DirStr +  'team_' + cast(IDTeam as varchar) + '_small.png' as FNAME 
		from DimTeam where ImgSmall is not null

OPEN IMGPATH_SMALL 

FETCH NEXT FROM IMGPATH_SMALL INTO @IMG_PATH, @FILENAME

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @FILENAME

        EXEC sp_OACreate 'ADODB.Stream', @ObjectToken OUTPUT
        EXEC sp_OASetProperty @ObjectToken, 'Type', 1
        EXEC sp_OAMethod @ObjectToken, 'Open'
        EXEC sp_OAMethod @ObjectToken, 'Write', NULL, @IMG_PATH
        EXEC sp_OAMethod @ObjectToken, 'SaveToFile', NULL, @FILENAME, 2
        EXEC sp_OAMethod @ObjectToken, 'Close'
        EXEC sp_OADestroy @ObjectToken

        FETCH NEXT FROM IMGPATH_SMALL INTO @IMG_PATH, @FILENAME 
    END 

CLOSE IMGPATH_SMALL
DEALLOCATE IMGPATH_SMALL

INSERT INTO FactLogs(Dt, OperType, OperStatus)
SELECT getdate(), 'Выгрузка файлов команд SmallImg', 3


end

if @IsExtractNation = 1
begin
DECLARE IMGPATH_SMALL CURSOR FAST_FORWARD FOR 
        SELECT dn.NationImg,  @DirStr +  isnull(dc.CountryEng, dn.Nation) + '.png' as FNAME 
		from DimNation dn
		left join DimCountry dc on dn.Nation = dc.Country
		where dn.NationImg is not null

OPEN IMGPATH_SMALL 

FETCH NEXT FROM IMGPATH_SMALL INTO @IMG_PATH, @FILENAME

WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @FILENAME

        EXEC sp_OACreate 'ADODB.Stream', @ObjectToken OUTPUT
        EXEC sp_OASetProperty @ObjectToken, 'Type', 1
        EXEC sp_OAMethod @ObjectToken, 'Open'
        EXEC sp_OAMethod @ObjectToken, 'Write', NULL, @IMG_PATH
        EXEC sp_OAMethod @ObjectToken, 'SaveToFile', NULL, @FILENAME, 2
        EXEC sp_OAMethod @ObjectToken, 'Close'
        EXEC sp_OADestroy @ObjectToken

        FETCH NEXT FROM IMGPATH_SMALL INTO @IMG_PATH, @FILENAME 
    END 

CLOSE IMGPATH_SMALL
DEALLOCATE IMGPATH_SMALL

INSERT INTO FactLogs(Dt, OperType, OperStatus)
SELECT getdate(), 'Выгрузка файлов команд Nations', 3

end
END;