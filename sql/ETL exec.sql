--������ ������
--exec pCalcAllStand @IsCurrentSeason = null, @CountryInput = '����'
exec pCalcAllStand @IsCurrentSeason = null, @CountryInput = null
--�������� ������ �� ����
exec pExtractFilesToDjango
--���������� � ���� Django
exec pReLoadToDjango
