--расчет таблиц
--exec pCalcAllStand @IsCurrentSeason = null, @CountryInput = 'Кипр'
exec pCalcAllStand @IsCurrentSeason = null, @CountryInput = null
--выгрузка файлов из базы
exec pExtractFilesToDjango
--перегрузка в базу Django
exec pReLoadToDjango
