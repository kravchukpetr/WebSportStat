--������������ �������

declare @Season varchar(50)
declare @Country varchar(50)
declare @League varchar(50)
declare @TypeTable varchar(50)
declare @IsDetailTable int 
declare @TypeTour varchar(20)
declare @LastTours int
declare @TourNumber int
declare @TourDate date
declare @IDSport int
declare @TypeReturn int

select @Season = '2019-2020'
select @Country = '�������'
select @League = '�������'
select @TypeTable = '�����'--�����/����/� ������
select @IsDetailTable =  1 --����� �� �������� ����������� ����/� ������: 1 - ��; 0 - ���
select @TypeTour = 'Full'-- ��� ����: 'Full' - �� ������� ������; 'LastTours' - �� ��������� @LastTours �����; 'OnTour' - �� @TourNumber ���; 'OnDate' - �� @TourDate ����
select @LastTours = NULL
select @TourNumber = NULL
select @TourDate = NULL
select @IDSport = 1
select @TypeReturn = 1 -- 1 - ����� dataset; 2 - ������ � �������

exec SportStat.dbo.pLoadTable @Season, @Country, @League, @TypeTable, @IsDetailTable,
							  @TypeTour, @LastTours, @TourNumber, @TourDate, @IDSport, @TypeReturn


--exec SportStat.dbo.pLoadTable '2017-2018', '������', '����� A', '�����', 0, 'Full'--, NULL, NULL, NULL
--exec pGetCountryList 2
--exec pGetLeagueList


--exec pGetResults 1, '������', '����� A', '2017-2018'

