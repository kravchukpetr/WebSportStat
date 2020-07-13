select * from FactPredict
delete from FactPredict


exec pSavePredict '2017-2018', '������', '�������-����', 28, '2018-02-24', '������', '�����������', 1, 1, 0.3126, 0.2874, 0.4001, NULL, NULL, 1, NULL 
go 
exec pSavePredict '2017-2018', '������', '�������-����', 28, '2018-02-24', '������� & ����', '������', 0, 1, 0.3412, 0.3087, 0.3501, NULL, NULL, 1, NULL 
go 

alter table FactPredict add DateCreate datetime

select Tour, Count(*), sum(case when GoalHome is not null then 1 else 0 END) 
from FactResult where Country = '������' AND Season = '2017-2018' 
group by Tour
order by Tour